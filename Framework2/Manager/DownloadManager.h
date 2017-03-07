//
//  DownloadManager.h
//  Framework2
//
//  Created by 郭江 on 2017/3/7.
//  Copyright © 2017年 郭江. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DownloadModel : NSObject

@property (nonatomic, assign)   CGFloat progress;
@property (nonatomic, copy)     NSURL *downloadURL;
@property (nonatomic, copy)     NSURL *filePath;
@property (nonatomic, strong)   NSURLSessionDownloadTask *task;

-(void)suspend;
-(void)resume;

@end

@interface DownloadManager : NSObject

+(instancetype)sharedManger;

-(void)setBackgroundURLSession:(NSString *)identifier completion:(void(^)())completion;

-(DownloadModel *)addURL:(NSString *)urlString
                progress:(void(^)(CGFloat progress))progress
              completion:(void(^)(NSURL *filePath))completion;

-(DownloadModel *)downloadWithURL:(NSString *)urlString
                         progress:(void(^)(CGFloat progress))progress
                       completion:(void(^)(NSURL *filePath))completion;

@end
