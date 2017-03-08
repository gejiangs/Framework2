//
//  DownloadVC.m
//  Framework2
//
//  Created by 郭江 on 2017/3/8.
//  Copyright © 2017年 郭江. All rights reserved.
//

#import "DownloadVC.h"
#import "DownloadManager.h"

@interface DownloadVC ()

@property (weak, nonatomic) IBOutlet UILabel *progressLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (nonatomic, strong)   DownloadModel *downloadModel;


@property (weak, nonatomic) IBOutlet UILabel *progressLabel2;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView2;
@property (nonatomic, strong)   DownloadModel *downloadModel2;

@end

@implementation DownloadVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"后台下载";
}

-(void)initDownload
{
    NSString *urlStirng1 = @"http://dldir1.qq.com/qqfile/QQforMac/QQ_V5.4.1.dmg";
    self.downloadModel = [[DownloadManager sharedManger] addURL:urlStirng1 progress:^(CGFloat progress) {
        self.progressView.progress = progress;
        self.progressLabel.text = [NSString stringWithFormat:@"%0.2f%@", progress*100.f, @"%"];
        NSLog(@"progress:%0.2f", progress);
    } completion:^(NSURL *filePath) {
        NSLog(@"filePath:%@", filePath);
    }];
    
    NSString *urlStirng2 = @"http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4";
    self.downloadModel2 = [[DownloadManager sharedManger] addURL:urlStirng2 progress:^(CGFloat progress) {
        self.progressView2.progress = progress;
        self.progressLabel2.text = [NSString stringWithFormat:@"%0.2f%@", progress*100.f, @"%"];
        NSLog(@"progress:%0.2f", progress);
    } completion:^(NSURL *filePath) {
        NSLog(@"filePath:%@", filePath);
    }];
}

- (IBAction)startAction:(UIButton *)sender
{
    if (sender.tag == 1) {
        [self.downloadModel resume];
    }else if (sender.tag == 2){
        [self.downloadModel2 resume];
    }
}

- (IBAction)pauseAction:(UIButton *)sender
{
    if (sender.tag == 1) {
        [self.downloadModel suspend];
    }else if (sender.tag == 2){
        [self.downloadModel2 suspend];
    }
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
