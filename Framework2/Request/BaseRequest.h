//
//  BaseRequest.h
//  Framework2
//
//  Created by 郭江 on 2017/3/2.
//  Copyright © 2017年 郭江. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^successBlock)(BOOL success, NSString *msg, id object);
typedef void(^successListBlock)(BOOL success, NSString *msg, NSArray *list);
typedef void(^failureBlock)(NSError *error);
typedef void(^progress)(CGFloat progress);

@interface BaseRequest : NSObject

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
                 failure:(failureBlock)failure;

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
                  failure:(failureBlock)failure;

@end
