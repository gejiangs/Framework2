//
//  HomeViewController.m
//  Framework2
//
//  Created by 郭江 on 2017/3/7.
//  Copyright © 2017年 郭江. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()


@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *array = @[@{@"title":@"后台下载", @"class":@"DownloadVC"},
                       @{@"title":@"后台下载2(支持关闭程序断点下载)",@"class":@"DownloadVC2"},
                       @{@"title":@"Collection",@"class":@"CollectionVC"},
                       @{@"title":@"ClircleView",@"class":@"ClircleVC"},
                       @{@"title":@"视频播放",@"class":@"VideoVC"},
                       @{@"title":@"视频播放2",@"class":@"VideoVC2"}
                       ];
    
    self.contentList = [NSMutableArray arrayWithArray:array];
    
//    UIView *bottomView = [UIView new];
//    bottomView.backgroundColor = [UIColor grayColor];
//    [self.navigationController.view addSubview:bottomView];
//    
//    [bottomView makeConstraints:^(MASConstraintMaker *make) {
//        make.left.bottom.right.offset(0);
//        make.height.offset(100);
//    }];
}

- (UIStatusBarStyle)preferredStatusBarStyle

{
    
    return UIStatusBarStyleLightContent;
    
    //UIStatusBarStyleDefault = 0 黑色文字，浅色背景时使用
    
    //UIStatusBarStyleLightContent = 1 白色文字，深色背景时使用
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark UITableView dataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.contentList count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ident = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ident];
    }
    
    cell.textLabel.text = [[self.contentList objectAtIndex:indexPath.row] objectForKey:@"title"];
    return cell;
}


#pragma mark UITableView Delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *className = [[self.contentList objectAtIndex:indexPath.row] objectForKey:@"class"];
    
    [self pushViewControllerName:className];
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
