//
//  TouchIDViewController.m
//  Framework2
//
//  Created by gejiangs on 2017/11/2.
//  Copyright © 2017年 郭江. All rights reserved.
//

#import "TouchIDViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface TouchIDViewController ()

@property (nonatomic, strong)   UILabel *messageLabel;

@end

@implementation TouchIDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"TouchID";
    
    UIButton *touchButton = [self.view addButtonWithTitle:@"Touch" target:self action:@selector(touchAction)];
    [touchButton setBackgroundImage:[UIImage imageWithColor:AppColorGray] forState:UIControlStateNormal];
    touchButton.layer.cornerRadius = 50.f;
    touchButton.layer.masksToBounds = YES;
    [touchButton makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.equalTo(Size(100, 100));
    }];
    
    self.messageLabel = [self.view addLabelWithText:@""];
    [_messageLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(touchButton.mas_bottom).offset(20);
    }];
}

-(void)touchAction
{
    LAContext *context = [[LAContext alloc] init];
    NSError *error = nil;
    if (![context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        NSLog(@"不支持指纹识别");
        switch (error.code) {
            case LAErrorTouchIDNotEnrolled:
            {
                self.messageLabel.text = @"设备没有注册TouchID";
                NSLog(@"TouchID is not enrolled");
                break;
            }
            case LAErrorPasscodeNotSet:
            {
                self.messageLabel.text = @"没有在设备上设置密码";
                NSLog(@"A passcode has not been set");
                break;
            }
            default:
            {
                NSLog(@"TouchID not available");
                break;
            }
        }
        
        NSLog(@"%@",error.localizedDescription);
        return;
    }
    [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"请按home键指纹解锁" reply:^(BOOL success, NSError * _Nullable error) {
        [self dispatchAsyncMainQueue:^{            
            if (success) {
                self.messageLabel.text = @"验证成功 刷新主界面";
            }else{
                NSLog(@"%@",error.localizedDescription);
                switch (error.code) {
                    case LAErrorSystemCancel:
                    {
                        self.messageLabel.text = @"系统取消授权，如其他APP切入";
                        break;
                    }
                    case LAErrorUserCancel:
                    {
                        self.messageLabel.text = @"用户取消验证Touch ID";
                        break;
                    }
                    case LAErrorAuthenticationFailed:
                    {
                        self.messageLabel.text = @"授权失败";
                        break;
                    }
                    case LAErrorPasscodeNotSet:
                    {
                        self.messageLabel.text = @"系统未设置密码";
                        break;
                    }
                    case LAErrorTouchIDNotAvailable:
                    {
                        self.messageLabel.text = @"设备Touch ID不可用，例如未打开";
                        break;
                    }
                    case LAErrorTouchIDNotEnrolled:
                    {
                        self.messageLabel.text = @"设备Touch ID不可用，用户未录入";
                        break;
                    }
                    case LAErrorUserFallback:
                    {
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            self.messageLabel.text = @"用户选择输入密码，切换主线程处理";
                        }];
                        break;
                    }
                    default:
                    {
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            self.messageLabel.text = @"其他情况，切换主线程处理";
                        }];
                        break;
                    }
                }
            }
        }];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
