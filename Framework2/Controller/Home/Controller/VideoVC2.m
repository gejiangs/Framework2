//
//  VideoVC2.m
//  Framework2
//
//  Created by 郭江 on 2017/5/9.
//  Copyright © 2017年 郭江. All rights reserved.
//

#import "VideoVC2.h"
#import "WMPlayer.h"
#import "IJKVideoPlayerView.h"

@interface VideoVC2 ()

@end

@implementation VideoVC2

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    MRVLCPlayer *player = [[MRVLCPlayer alloc] init];
//    
//    player.bounds = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width / 16 * 9);
//    player.center = self.view.center;
//    player.mediaURL = [NSURL URLWithString:@"http://119.147.144.58:8088/rsfile/songs/zouma.mkv"];
//    
//    [player showInView:self.view];
    
//    WMPlayer *wmPlayer = [[WMPlayer alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth/16*9)];
//    
////    [wmPlayer setURLString:@"http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4"];
//    [wmPlayer setURLString:@"http://119.147.144.58:8088/rsfile/songs/1.flv"];
//    
//    [self.view addSubview:wmPlayer];
//    
//    [wmPlayer play];
    
    IJKVideoPlayerView *playerView = [[IJKVideoPlayerView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth/16*9)
                                                                     urlString:@"http://119.147.144.58:8088/rsfile/songs/1.flv"];
    [self.view addSubview:playerView];
    
    
    UIButton *back = [self.view addButtonWithTitle:@"返回" target:self action:@selector(backAction)];
    [self.view addSubview:back];
    [back makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.bottom.offset(-10);
    }];
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
