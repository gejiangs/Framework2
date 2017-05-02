//
//  ClircleVC.m
//  Framework2
//
//  Created by 郭江 on 2017/4/25.
//  Copyright © 2017年 郭江. All rights reserved.
//

#import "ClircleVC.h"
#import "ClircleHeaderView.h"

@interface ClircleVC ()

@property (nonatomic, strong)   ClircleHeaderView *v;

@end

@implementation ClircleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Clirecle";
    [self initUI];
}

-(void)initUI
{
    UIButton *actionButton = [self.view addButtonWithTitle:@"Start" target:self action:@selector(buttonAction:)];
    [actionButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(10);
        make.centerX.equalTo(self.view);
    }];
    
    self.v = [[ClircleHeaderView alloc] init];
    _v.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_v];
    [_v makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset(300);
        make.center.equalTo(self.view);
    }];
    
//    if (Phone5_5) {
//        v.transform = CGAffineTransformScale(v.transform, 1.3, 1.3);
//    }else if (Phone4_0 || Phone3_5){
//        v.transform = CGAffineTransformScale(v.transform, 0.8, 0.8);
//    }
}

-(void)buttonAction:(UIButton *)sender
{
    self.v.testState = !self.v.testState;
    [sender setTitle:self.v.testState ? @"Stop" : @"Start" forState:UIControlStateNormal];
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
