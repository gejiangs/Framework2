//
//  HomeTitleCollectionCell.m
//  Framework2
//
//  Created by 郭江 on 2017/3/21.
//  Copyright © 2017年 郭江. All rights reserved.
//

#import "HomeTitleCollectionCell.h"

@interface HomeTitleCollectionCell ()

@property (nonatomic, strong)   UIView *iconView;
@property (nonatomic, strong)   UILabel *titleLabel;
@property (nonatomic, strong)   UIButton *moreButton;

@end

@implementation HomeTitleCollectionCell


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
    self.backgroundColor = [UIColor whiteColor];
    
    self.iconView = [UIView new];
    [self addSubview:_iconView];
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.width.offset(10);
        make.centerY.equalTo(self);
    }];
    
    self.titleLabel = [self addLabelWithText:@"原创" font:[UIFont systemFontOfSize:17] color:[UIColor blackColor]];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconView.mas_right).offset(10);
        make.centerY.equalTo(_iconView);
    }];
    
    self.moreButton = [self addButtonWithTitle:@"更多>>" target:nil action:nil];
    [_moreButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_moreButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [_moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.centerY.equalTo(_iconView);
    }];
}

@end
