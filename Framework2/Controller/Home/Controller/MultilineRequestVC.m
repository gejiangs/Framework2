//
//  MultilineRequestVC.m
//  Framework2
//
//  Created by gejiangs on 2018/5/9.
//  Copyright © 2018年 郭江. All rights reserved.
//

#import "MultilineRequestVC.h"
#import "BaseRequest.h"

@interface MultilineRequestVC ()

@property (nonatomic, strong)   BaseRequest *request;

@end

@implementation MultilineRequestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"并行请求";
    [self loadRequest];
}

-(void)loadRequest
{
    NSString *urlString1 = @"http://m2.qiushibaike.com/ad?AdID=14260582945040F4E3A48F";
    NSString *urlString2 = @"http://nearby.qiushibaike.com/user/10000/detail";
    NSString *urlString3 = @"http://www.baidu.com";
    RequestManager *manager1 = [self.request requestWithGET:urlString1 params:nil success:^(BOOL success, NSString *msg, id object) {
        NSLog(@"manager 1 请求OK:%@", object);
    } failure:^(NSError *error) {
        NSLog(@"manager 1 请求failure");
    }];
    
    RequestManager *manager2 = [self.request requestWithGET:urlString2 params:nil success:^(BOOL success, NSString *msg, id object) {
        NSLog(@"manager 2 请求OK:%@", object);
    } failure:^(NSError *error) {
        NSLog(@"manager 2 请求failure");
    }];
    
    RequestManager *manager3 = [self.request requestWithGET:urlString3 params:nil success:^(BOOL success, NSString *msg, id object) {
        NSLog(@"manager 3 请求OK:%@", object);
    } failure:^(NSError *error) {
        NSLog(@"manager 3 请求failure");
    }];
    
    [self.request requestGroupsWithManagers:@[manager1, manager2, manager3] complete:^{
        NSLog(@"All 请求完成");
    }];
}

-(BaseRequest *)request
{
    if (_request) {
        return _request;
    }
    self.request = [[BaseRequest alloc] init];
    return _request;
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
