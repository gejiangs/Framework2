//
//  BaseRequest.m
//  Framework2
//
//  Created by 郭江 on 2017/3/2.
//  Copyright © 2017年 郭江. All rights reserved.
//

#import "BaseRequest.h"
#import "AFNetworking.h"

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
        self.sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
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
    [self.sessionManager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
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
    [self.sessionManager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


@end
