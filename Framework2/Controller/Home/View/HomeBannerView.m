//
//  HomeHeaderReusableView.m
//  Framework2
//
//  Created by 郭江 on 2017/3/21.
//  Copyright © 2017年 郭江. All rights reserved.
//

#import "HomeBannerView.h"

@interface HomeBannerView ()


@end

@implementation HomeBannerView

-(instancetype)init
{
    if (self = [super init]) {
        [self initUI];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

-(void)initUI
{
    self.backgroundColor = [UIColor clearColor];
    
    self.bannerView = [[BannerScrollView alloc] initWithImageNames:@[] clickBlock:nil];
    _bannerView.pageAlign = BannerPageAlignRight;
    [self addSubview:_bannerView];
    [_bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.bottom.offset(-20);
    }];
}

-(void)moreAction:(UIButton *)sender
{
    
}

@end
