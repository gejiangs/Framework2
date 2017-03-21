//
//  HomeCollectionCell.m
//  Framework2
//
//  Created by 郭江 on 2017/3/21.
//  Copyright © 2017年 郭江. All rights reserved.
//

#import "HomeCollectionCell.h"

@interface HomeCollectionCell ()

@property (nonatomic, strong)   UIImageView *imageView;
@property (nonatomic, strong)   UILabel *nameLabel;
@property (nonatomic, strong)   UILabel *infoLabel;

@end

@implementation HomeCollectionCell

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

-(void)initUI
{
    self.backgroundColor = [UIColor whiteColor];
    
    self.imageView = [self.contentView addImageViewWithName:@""];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(10);
        make.right.offset(-10);
        make.bottom.offset(-50);
    }];
    
    self.nameLabel = [self.contentView addLabelWithText:@"" font:[UIFont systemFontOfSize:16] color:[UIColor blackColor]];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.equalTo(_imageView.mas_bottom).offset(5);
        make.right.offset(-10);
    }];
    
    self.infoLabel = [self.contentView addLabelWithText:@"" font:[UIFont systemFontOfSize:16] color:[UIColor blackColor]];
    [_infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.equalTo(_nameLabel.mas_bottom).offset(5);
        make.right.offset(-10);
    }];
    
    self.nameLabel.text = @"aaa";
    self.infoLabel.text = @"bbb";
}

@end
