//
//  HomeCollectionView.m
//  Framework2
//
//  Created by 郭江 on 2017/3/21.
//  Copyright © 2017年 郭江. All rights reserved.
//

#import "HomeCollectionView.h"
#import "HomeCollectionCell.h"
#import "HomeTitleCollectionCell.h"
#import "HomeBannerView.h"

@interface HomeCollectionView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong)   UICollectionView *collectionView;

@end

@implementation HomeCollectionView

-(id)init
{
    if (self = [super init]) {
        [self initUI];
    }
    return self;
}

-(void)initUI
{
    self.backgroundColor = [UIColor grayColor];
    [self initCollectionView];
}


- (void)initCollectionView
{
    //首先需要创建一个布局对象
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    
    //创建cllectionView对象
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:flowLayout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.backgroundColor = [UIColor clearColor];
    [collectionView registerClass:[HomeCollectionCell class] forCellWithReuseIdentifier:@"HomeCell"];
    [collectionView registerClass:[HomeTitleCollectionCell class] forCellWithReuseIdentifier:@"HomeTitleCell"];
    [collectionView registerClass:[HomeBannerView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HomeBannerView"];
    [self addSubview:collectionView];
    
    
    self.collectionView = collectionView;
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
}


#pragma mark - UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 6;
}

//指定有多少个子视图
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section % 2 == 0) {
        return 1;
    }
    return 4;
}

//指定子视图
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section % 2 == 0) {
        HomeTitleCollectionCell *titleCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeTitleCell" forIndexPath:indexPath];
        
        return titleCell;
    }
    
    
    HomeCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeCell" forIndexPath:indexPath];
    
    //返回
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView;
    //此处是headerView
    if (kind == UICollectionElementKindSectionHeader) {
        
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HomeBannerView" forIndexPath:indexPath];
        HomeBannerView *bannerView = (HomeBannerView *)reusableView;
        bannerView.bannerView.hidden = indexPath.section != 0;
        if (indexPath.section == 0) {
            NSArray *urls = @[@"https://ss2.baidu.com/6ONYsjip0QIZ8tyhnq/it/u=27041453,3463581746&fm=80&w=179&h=119&img.JPEG",
                              @"https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=2049985347,1293161627&fm=80&w=179&h=119&img.JPEG",
                              @"https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=2809772170,1089477635&fm=80&w=179&h=119&img.JPEG"];
            
            [bannerView.bannerView replaceImageUrls:urls clickBlock:^(NSInteger index) {
                
            }];
        }
        
    }
    return reusableView;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%ld - %ld",indexPath.section, indexPath.row);
}

// 表头尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeMake(self.collectionView.frame.size.width, 150);
    }
    if (section % 2 == 1) {
        return CGSizeZero;
    }
    return CGSizeMake(self.collectionView.frame.size.width, 20);
}



//返回每个子视图的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section % 2 == 0) {
        return CGSizeMake(self.collectionView.frame.size.width, 50);
    }
    CGFloat height = 80;
    CGFloat width = self.collectionView.frame.size.width/2.f;
    return CGSizeMake(width, height);
    
}

@end
