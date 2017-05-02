//
//  VideoVC.m
//  Framework2
//
//  Created by 郭江 on 2017/5/2.
//  Copyright © 2017年 郭江. All rights reserved.
//

#import "VideoVC.h"
#import "KRVideoPlayerController.h"

@interface VideoVC ()

@property (nonatomic, strong) KRVideoPlayerController *videoController;


@end

@implementation VideoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *back = [self.view addButtonWithTitle:@"返回" target:self action:@selector(backAction)];
    [self.view addSubview:back];
    [back makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.bottom.offset(-10);
    }];
    
    NSURL *videoURL = [NSURL URLWithString:@"http://baobab.wdjcdn.com/1455782903700jy.mp4"];
    [self playVideoWithURL:videoURL];
    
    [self dispatchTimerWithTime:2 block:^{
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    }];
}

-(BOOL)prefersStatusBarHidden

{
    
    return YES;// 返回YES表示隐藏，返回NO表示显示
    
}

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
}

- (void)playVideoWithURL:(NSURL *)url
{
    if (!self.videoController) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        self.videoController = [[KRVideoPlayerController alloc] initWithFrame:CGRectMake(0, 0, width, width*(9.0/16.0))];
        __weak typeof(self)weakSelf = self;
        [self.videoController setDimissCompleteBlock:^{
            weakSelf.videoController = nil;
        }];
        [self.videoController showInView:self.view];
    }
    self.videoController.contentURL = url;
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
