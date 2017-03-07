//
//  DownloadManager.m
//  Framework2
//
//  Created by 郭江 on 2017/3/7.
//  Copyright © 2017年 郭江. All rights reserved.
//

#import "DownloadManager.h"
#import "AFNetworking.h"

@interface DownloadModel ()



@end

@implementation DownloadModel

-(void)suspend
{
    [self.task suspend];
}


-(void)resume
{
    [self.task resume];
}

@end

@interface DownloadManager ()

@property (strong, nonatomic) NSMutableDictionary *completionHandlerDictionary;

@end

@implementation DownloadManager

+(instancetype)sharedManger
{
    static id shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });
    return shared;
}

-(id)init
{
    if (self = [super init]) {
        self.completionHandlerDictionary = [NSMutableDictionary dictionary];
    }
    return self;
}

-(void)setBackgroundURLSession:(NSString *)identifier completion:(void (^)())completion
{
    [self.completionHandlerDictionary setObject:completion forKey:identifier];
}

-(DownloadModel *)addURL:(NSString *)urlString
                progress:(void(^)(CGFloat progress))progress
              completion:(void(^)(NSURL *filePath))completion
{
    DownloadModel *model = [[DownloadModel alloc] init];
    model.downloadURL = [NSURL URLWithString:urlString];
    
    //默认配置
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:urlString];
    
    //AFN3.0+基于封住URLSession的句柄
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    [manager setDidFinishEventsForBackgroundURLSessionBlock:^(NSURLSession * _Nonnull session) {
        NSLog(@"session:%@",session.configuration.identifier);
        void(^completion)() = [self.completionHandlerDictionary objectForKey:session.configuration.identifier];
        if (completion) {
            [self.completionHandlerDictionary removeObjectForKey:session.configuration.identifier];
            completion();
        }
    }];
    
    //请求
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    //下载Task操作
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        CGFloat p = 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount;
        model.progress = p;
        
        // 回到主队列刷新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            // 设置进度条的百分比
            if (progress) {
                progress(p);
            }
        });
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        //- block的返回值, 要求返回一个URL, 返回的这个URL就是文件的位置的路径
        
        NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSString *path = [cachesPath stringByAppendingPathComponent:response.suggestedFilename];
        return [NSURL fileURLWithPath:path];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        model.filePath = filePath;
        
        //设置下载完成操作
        if (completion) {
            completion(filePath);
        }
        
    }];
    
    model.task = task;
    
    return model;
}

-(DownloadModel *)downloadWithURL:(NSString *)urlString
                         progress:(void(^)(CGFloat progress))progress
                       completion:(void(^)(NSURL *filePath))completion
{
    DownloadModel *model = [self addURL:urlString progress:progress completion:completion];
    [model resume];
    return model;
}

@end
