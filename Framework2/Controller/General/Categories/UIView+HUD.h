//
//  MBProgressHUD+Utils.h
//  Framework2
//
//  Created by 郭江 on 2017/9/14.
//  Copyright © 2017年 郭江. All rights reserved.
//


#import "MBProgressHUD.h"

@interface UIView (HUD)

//显示成功提示
-(void)showHUDSuccess:(NSString *)text;

//显示失败
-(void)showHUDError:(NSString *)text;

//显示加载提示
-(void)showHUDText:(NSString *)text;

//显示进度条
-(MBProgressHUD *)showProgressHUDText:(NSString *)text;

//隐藏加载提示
- (void)hiddenHUD;

//显示加载提示,指定时间(秒数)自动消失
- (void)showHUDText:(NSString *)text hideAfterDelay:(NSTimeInterval)delay;

@end
