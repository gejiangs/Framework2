//
//  HSDownloadManager.h
//  HSDownloadManagerExample
//
//  Created by hans on 15/8/4.
//  Copyright © 2015年 hans. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum {
    DownloadStateStart = 0,     /** 下载中 */
    DownloadStateSuspended,     /** 下载暂停 */
    DownloadStateCompleted,     /** 下载完成 */
    DownloadStateFailed         /** 下载失败 */
}DownloadState;

#import <UIKit/UIKit.h>
@interface HSSessionModel : NSObject

/** 流 */
@property (nonatomic, strong) NSOutputStream *stream;

/** 下载地址 */
@property (nonatomic, copy) NSString *url;

/** 获得服务器这次请求 返回数据的总长度 */
@property (nonatomic, assign) NSInteger totalLength;

/** 下载进度 */
@property (nonatomic, copy) void(^progressBlock)(NSInteger receivedSize, NSInteger expectedSize, CGFloat progress);

/** 下载状态 */
@property (nonatomic, copy) void(^stateBlock)(DownloadState state);

@end


@interface HSDownloadManager : NSObject

/**
 *  单例
 *
 *  @return 返回单例对象
 */
+ (instancetype)sharedInstance;

/**
 *  开启任务下载资源
 *
 *  @param url           下载地址
 *  @param progressBlock 回调下载进度
 *  @param stateBlock    下载状态
 */
- (void)download:(NSString *)url progress:(void(^)(NSInteger receivedSize, NSInteger expectedSize, CGFloat progress))progressBlock state:(void(^)(DownloadState state))stateBlock;

/**
 *  查询该资源的下载进度值
 *
 *  @param url 下载地址
 *
 *  @return 返回下载进度值
 */
- (CGFloat)progress:(NSString *)url;

/**
 *  获取该资源总大小
 *
 *  @param url 下载地址
 *
 *  @return 资源总大小
 */
- (NSInteger)fileTotalLength:(NSString *)url;

/**
 *  判断该资源是否下载完成
 *
 *  @param url 下载地址
 *
 *  @return YES: 完成
 */
- (BOOL)isCompletion:(NSString *)url;

/**
 *  删除该资源
 *
 *  @param url 下载地址
 */
- (void)deleteFile:(NSString *)url;

/**
 *  清空所有下载资源
 */
- (void)deleteAllFile;

@end
