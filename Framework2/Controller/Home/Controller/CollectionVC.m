//
//  CollectionVC.m
//  Framework2
//
//  Created by 郭江 on 2017/3/21.
//  Copyright © 2017年 郭江. All rights reserved.
//

#import "CollectionVC.h"
#import "HomeCollectionView.h"

@interface CollectionVC ()<UIScrollViewDelegate>

@property (nonatomic, strong)   UIScrollView *scrollView;
@property (nonatomic, strong)   UIView *contentView;
@property (nonatomic, strong)   HomeCollectionView *homeView;

@end

@implementation CollectionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

-(void)initUI
{
    [self.view addSubview:self.scrollView];
    self.contentView = UIView.new;
    [self.scrollView addSubview:_contentView];
    
    [_contentView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.height.equalTo(self.scrollView);
    }];
    
    [_scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.bottom.offset(-50);
    }];
    
    self.homeView = [[HomeCollectionView alloc] init];
    [self.contentView addSubview:_homeView];
    [_homeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(0);
        make.height.equalTo(self.scrollView.mas_height);
        make.width.equalTo(self.scrollView.mas_width);
    }];
    
    [_contentView makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_homeView.mas_right);
    }];
}

-(UIScrollView *)scrollView
{
    if (_scrollView != nil) {
        return _scrollView;
    }
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.bounces = NO;
    _scrollView.alwaysBounceHorizontal = NO;
    _scrollView.alwaysBounceVertical = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    
    return _scrollView;
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
