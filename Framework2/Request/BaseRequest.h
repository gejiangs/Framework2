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
typedef void(^requestComplete)();

#pragma mark - 请求体
@interface RequestManager : NSObject

@property (nonatomic, strong)   NSURLSessionDataTask *task;
@property (nonatomic, copy)     void(^success)();
@property (nonatomic, copy)     void(^failure)();


@end


#pragma mark - 上传文件model
@interface RequestFileModel : NSObject

@property (nonatomic, strong)   NSData *fileData;       //文件数据
@property (nonatomic, copy)     NSString *name;         //参数名（一般为file）
@property (nonatomic, copy)     NSString *fileName;     //上传文件名（xxxx.jpg或者xxx.png）
@property (nonatomic, copy)     NSString *mimeType;     //文件类型（）

@end

@interface BaseRequest : NSObject

#pragma mark - 网络GET\POST请求
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

#pragma mark - HTTP图片上传
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
                  failure:(failureBlock)failure;

/**
 http 上传图片
 
 @param urlString url地址
 @param params 参数
 @param file 文件对象
 @param progress 上传进度
 @param success 成功block
 @param failure 失败block
 */
-(void)uploadImageWithURL:(NSString *)urlString
                   params:(NSDictionary *)params
                     file:(RequestFileModel *)file
                 progress:(progress)progress
                  success:(successBlock)success
                  failure:(failureBlock)failure;

/**
 http 上传图片
 
 @param urlString url地址
 @param params 参数
 @param files 文件对象数组
 @param progress 上传进度
 @param success 成功block
 @param failure 失败block
 */
-(void)uploadImageWithURL:(NSString *)urlString
                   params:(NSDictionary *)params
                    files:(NSArray<RequestFileModel*> *)files
                 progress:(progress)progress
                  success:(successBlock)success
                  failure:(failureBlock)failure;

#pragma mark - http网络并行请求对象
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
                          failure:(failureBlock)failure;

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
                          failure:(failureBlock)failure;


/**
 队列请求

 @param managers 请求对象数组
 @param complete 所有请求完成block
 */
-(void)requestGroupsWithManagers:(NSArray<RequestManager *> *)managers
                        complete:(requestComplete)complete;
@end
