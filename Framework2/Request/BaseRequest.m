//
//  BaseRequest.m
//  Framework2
//
//  Created by 郭江 on 2017/3/2.
//  Copyright © 2017年 郭江. All rights reserved.
//

#import "BaseRequest.h"
#import "AFNetworking.h"

@implementation RequestManager

@end

@implementation RequestFileModel

-(id)init
{
    if (self = [super init]) {
        self.mimeType = @"image/png";
        self.name = @"file";
    }
    return self;
}

@end

@interface BaseRequest ()

@property (nonatomic, copy) successBlock successHandler;
@property (nonatomic, copy) failureBlock failureHandler;
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@end

@implementation BaseRequest

-(id)init
{
    if (self = [super init]) {
        self.sessionManager = [AFHTTPSessionManager manager];
        self.sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        NSMutableSet *set = [[NSMutableSet alloc] initWithSet:self.sessionManager.responseSerializer.acceptableContentTypes];
        [set addObject:@"application/json"];
        [set addObject:@"text/json"];
        [set addObject:@"text/javascript"];
        [set addObject:@"text/html"];
        [set addObject:@"text/css"];
        [set addObject:@"text/plain"];
        
        self.sessionManager.responseSerializer.acceptableContentTypes = set;
    }
    return self;
}

/**
 *  http get请求
 *
 *  @param url     url地址
 *  @param params  参数
 *  @param success 成功block
 *  @param failure 失败block
 */
-(void)requestGetWithURL:(NSString *)url
                  params:(NSDictionary *)params
                 success:(successBlock)success
                 failure:(failureBlock)failure
{
    self.successHandler = success;
    self.failureHandler = failure;
    
    [self.sessionManager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"response:%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.failureHandler) {
            self.failureHandler(error);
        }
    }];
}

/**
 *  http post请求
 *
 *  @param url     url地址
 *  @param params  参数
 *  @param success 成功block
 *  @param failure 失败block
 */
-(void)requestPostWithURL:(NSString *)url
                   params:(NSDictionary *)params
                  success:(successBlock)success
                  failure:(failureBlock)failure
{
    self.successHandler = success;
    self.failureHandler = failure;
    
    [self.sessionManager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.failureHandler) {
            self.failureHandler(error);
        }
    }];
}

/**
 http 上传图片
 
 @param urlString url地址
 @param params 参数
 @param file 文件对象
 @param success 成功block
 @param failure 失败block
 */
-(void)uploadImageWithURL:(NSString *)urlString
                   params:(NSDictionary *)params
                     file:(RequestFileModel *)file
                  success:(successBlock)success
                  failure:(failureBlock)failure
{
    [self.sessionManager uploadTaskWithRequest:<#(nonnull NSURLRequest *)#> fromData:<#(nullable NSData *)#> progress:<#^(NSProgress * _Nonnull uploadProgress)uploadProgressBlock#> completionHandler:<#^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error)completionHandler#>]
}

/**
 http Get 请求对象
 
 @param urlString url地址
 @param params 参数
 @param success 成功
 @param failure 失败
 @return http get 请求对象
 */
-(RequestManager *)requestWithGET:(NSString *)urlString
                           params:(NSDictionary *)params
                          success:(successBlock)success
                          failure:(failureBlock)failure
{
    RequestManager *request = [[RequestManager alloc] init];
    request.task = [self.sessionManager GET:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(YES, @"", responseObject);
        }
        
        if (request.success) {
            request.success();
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
        
        if (request.failure) {
            request.failure();
        }
    }];
    
    return request;
}

/**
 http post 请求对象
 
 @param urlString url地址
 @param params 参数
 @param success 成功
 @param failure 失败
 @return http post 请求对象
 */
-(RequestManager *)requestWithPOST:(NSString *)urlString
                            params:(NSDictionary *)params
                           success:(successBlock)success
                           failure:(failureBlock)failure
{
    RequestManager *request = [[RequestManager alloc] init];
    request.task = [self.sessionManager POST:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(YES, @"", responseObject);
        }
        
        if (request.success) {
            request.success();
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
        
        if (request.failure) {
            request.failure();
        }
    }];
    
    return request;
}


/**
 队列请求
 
 @param managers 请求对象数组
 @param complete 所有请求完成block
 */
-(void)requestGroupsWithManagers:(NSArray<RequestManager *> *)managers
                        complete:(requestComplete)complete
{
//    dispatch_queue_t queue = dispatch_queue_create("com.request.group.queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();
    
    
    for (RequestManager *request in managers) {
        dispatch_group_enter(group);
        request.success = ^{
            dispatch_group_leave(group);
        };
        request.failure = ^{
            dispatch_group_leave(group);
        };
    }
    
    dispatch_group_notify(group, dispatch_get_main_queue(), complete);
    
}

@end
