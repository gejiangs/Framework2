//
//  MBProgressHUD+Utils.m
//  Framework2
//
//  Created by 郭江 on 2017/9/14.
//  Copyright © 2017年 郭江. All rights reserved.
//

#import "UIView+HUD.h"

#define ACTIVITYTAG 9999

@implementation UIView (HUD)

//显示成功提示
-(void)showHUDSuccess:(NSString *)text
{
    [self hiddenHUD];
    [self showSuccess:StringIsEmpty(text) ? nil : text];
}

//显示失败
-(void)showHUDError:(NSString *)text
{
    [self hiddenHUD];
    [self showError:StringIsEmpty(text) ? nil : text];
}

//显示加载提示
- (void)showHUDText:(NSString *)text
{
    UIView *view = [self viewWithTag:ACTIVITYTAG];
    if (view) {
        [view removeFromSuperview];
    }
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self];
    hud.tag = ACTIVITYTAG;
    hud.label.text = StringIsEmpty(text) ? nil : text;
    [self addSubview:hud];
    [hud showAnimated:YES];
}

//显示进度条
-(MBProgressHUD *)showProgressHUDText:(NSString *)text
{
    UIView *view = [self viewWithTag:ACTIVITYTAG];
    if (view) {
        [view removeFromSuperview];
    }
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self];
    hud.tag = ACTIVITYTAG;
    hud.label.text = StringIsEmpty(text) ? nil : text;
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    [self addSubview:hud];
    [hud showAnimated:YES];
    return hud;
}

//隐藏加载提示
- (void)hiddenHUD
{
    MBProgressHUD *view =(MBProgressHUD *) [self viewWithTag:ACTIVITYTAG];
    [view hideAnimated:YES];
}

//显示加载提示,指定时间(秒数)自动消失
- (void)showHUDText:(NSString *)labelText hideAfterDelay:(NSTimeInterval)delay
{
    UIView *view = [self viewWithTag:ACTIVITYTAG];
    if (view) {
        [view removeFromSuperview];
    }
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self];
    hud.tag = ACTIVITYTAG;
    hud.label.text = StringIsEmpty(labelText) ? nil : labelText;
    hud.mode = MBProgressHUDModeText;
    [self addSubview:hud];
    [hud showAnimated:YES];
    [hud hideAnimated:YES afterDelay:delay];
    
}

- (void)showError:(NSString *)error{
    [self show:error icon:@"error" view:nil];
}

- (void)showSuccess:(NSString *)success
{
    [self show:success icon:@"success" view:nil];
}

- (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = text;
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hideAnimated:YES afterDelay:1];
}

@end
