//
//  ClircleHeaderView.m
//  CircleAnimateDemo
//
//  Created by 郭江 on 2017/4/25.
//  Copyright © 2017年 qiuyu wang. All rights reserved.
//

#import "ClircleHeaderView.h"

@interface ClircleTopView : UIView

@end

@implementation ClircleTopView

//绘制轨迹上半圈
- (void)drawRect:(CGRect)rect
{
    CGFloat width = 230, height = 60;
    CGFloat x = (self.frame.size.width - width)/2.f;
    CGFloat y = (self.frame.size.height - height)/2.f;
    
    CGFloat startAngle = M_PI, endAngle = 0;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGPoint center = CGPointMake(x + width / 2.0, y + height / 2.0);
    UIBezierPath* clip = [UIBezierPath bezierPathWithArcCenter:center
                                                        radius:MAX(width, height)
                                                    startAngle:startAngle
                                                      endAngle:endAngle
                                                     clockwise:YES];
    [clip addLineToPoint:center];
    [clip closePath];
    [clip addClip];
    
    UIBezierPath *arc = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(x, y, width, height)];
    arc.lineWidth = 5;
    [AppColorBlue setStroke];
    [arc stroke];
    
    CGContextRestoreGState(context);
}

@end


@interface ClircleBottomView : UIView

@end

@implementation ClircleBottomView

//绘制轨迹下半圈
- (void)drawRect:(CGRect)rect
{
    CGFloat width = 230, height = 60;
    CGFloat x = (self.frame.size.width - width)/2.f;
    CGFloat y = (self.frame.size.height - height)/2.f;
    
    CGFloat startAngle = 0, endAngle = M_PI;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGPoint center = CGPointMake(x + width / 2.0, y + height / 2.0);
    UIBezierPath* clip = [UIBezierPath bezierPathWithArcCenter:center
                                                        radius:MAX(width, height)
                                                    startAngle:startAngle
                                                      endAngle:endAngle
                                                     clockwise:YES];
    [clip addLineToPoint:center];
    [clip closePath];
    [clip addClip];
    
    UIBezierPath *arc = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(x, y, width, height)];
    arc.lineWidth = 5;
    [AppColorBlue setStroke];
    [arc stroke];
    
    CGContextRestoreGState(context);
}

@end

@interface ClircleHeaderView ()

@property (nonatomic, strong)   UIView *dotView;
@property (nonatomic, strong)   ClircleTopView *topClircle;
@property (nonatomic, strong)   ClircleBottomView *bottomClircle;
@property (nonatomic, strong)   UILabel *healthLabel;
@property (nonatomic, strong)   UILabel *valueLabel;
@property (nonatomic, strong)   UIButton *testButton;

@property (nonatomic, strong)   NSMutableArray *paths;
@property (nonatomic, strong)   NSTimer *clircleTimer;

@end

@implementation ClircleHeaderView

-(id)init
{
    if (self = [super init]) {
        [self initUI];
        [self initAnimationPaths];
    }
    return self;
}

-(void)initUI
{
    //绘制轨迹下半圈
    self.topClircle = [[ClircleTopView alloc] init];
    _topClircle.backgroundColor = [UIColor clearColor];
    _topClircle.hidden = YES;
    [self addSubview:_topClircle];
    [_topClircle makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    
    //点
    self.dotView = [[UIView alloc] init];
    [self addSubview:_dotView];
    _dotView.frame = CGRectMake(160, 130, 20, 20);
    [_dotView.layer setCornerRadius:10];
    _dotView.backgroundColor = [UIColor yellowColor];
    
    UIImageView *bgImageView = [self addImageViewWithName:@"home_bg"];
    [bgImageView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    //添加一个圆圈View
    UIView *circleView = [UIView new];
    circleView.layer.cornerRadius = 75.f;
    circleView.layer.masksToBounds = YES;
    [self addSubview:circleView];
    [circleView makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.height.equalTo(self).multipliedBy(0.5);
    }];
    
    //圆圈View里面添加一个touchView ，用于点击操作
    UIView *touchView = [UIView new];
    [circleView addSubview:touchView];
    [touchView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(circleView);
    }];
    
//    CGFloat valueWidth = 150;
//    self.waveView = [[WaterWaveView alloc] initWithFrame:CGRectMake(0, 0, valueWidth, valueWidth)];
//    _waveView.layer.cornerRadius = valueWidth/2.f;
//    _waveView.layer.masksToBounds = YES;
//    _waveView.firstWaveColor = RGB(28, 99, 124);
//    _waveView.secondWaveColor = RGB(84, 201, 252);
//    _waveView.percent = 0.5;
//    _waveView.hidden = YES;
//    [_waveView stopWave];
//    [circleView addSubview:_waveView];
//    [_waveView makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(circleView);
//        make.width.height.offset(valueWidth);
//    }];
    
    
//    if (Phone5_5) {
//        self.transform = CGAffineTransformScale(self.transform, 1.3, 1.3);
//    }else if (Phone4_0 || Phone3_5){
//        self.transform = CGAffineTransformScale(self.transform, 0.8, 0.8);
//    }
    
    self.healthLabel = [self addLabelWithText:[self languageKey:@"Healthindex"] font:[UIFont systemFontOfSize:16] color:[UIColor whiteColor]];
    [_healthLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(90);
        make.centerX.equalTo(self);
    }];
    
    self.valueLabel = [self addLabelWithText:[self languageKey:@"0%"] font:[UIFont boldSystemFontOfSize:40] color:[UIColor whiteColor]];
    [_valueLabel makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    
    self.testButton = [self addButtonWithTitle:[self languageKey:@"StartTest"] target:nil action:nil];
    [_testButton setTitle:[self languageKey:@"Testing"] forState:UIControlStateDisabled];
    [_testButton.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [_testButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_testButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_valueLabel.bottom).offset(0);
        make.centerX.equalTo(self);
        make.height.offset(40);
        make.width.offset(100);
    }];
    
    
    //绘制轨迹下半圈
    self.bottomClircle = [[ClircleBottomView alloc] init];
    _bottomClircle.backgroundColor = [UIColor clearColor];
    _bottomClircle.hidden = YES;
    [self addSubview:_bottomClircle];
    [_bottomClircle makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
}

-(void)setTestState:(BOOL)state
{
    _testState = state;
    if (state) {
        [self startAnimation];
    }else{
        [self stopAnimation];
    }
}
//开始动画
-(void)startAnimation
{
    [self stopAnimation];
    self.topClircle.hidden = NO;
    self.bottomClircle.hidden = NO;
    self.dotView.hidden = NO;
    self.healthLabel.hidden = YES;
    
    [_valueLabel updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self).offset(-20);
    }];
    [_testButton updateConstraints:^(MASConstraintMaker *make) {
       make.top.equalTo(_valueLabel.bottom).offset(-10);
    }];
    
    self.clircleTimer = [NSTimer scheduledTimerWithTimeInterval:0.005 target:self selector:@selector(changeDotViewPosition) userInfo:nil repeats:YES];
}

//修改点的位置
-(void)changeDotViewPosition
{
    NSString *p = NSStringFromCGPoint(self.dotView.center);
    NSInteger index = 0;
    if ([self.paths containsObject:p]) {
        index = [self.paths indexOfObject:p];
    }    
    if (index >= [self.paths count]-1) {
        index = 0;
    }else{
        index ++;
    }
    
    CGPoint point = CGPointFromString(self.paths[index]);
    self.dotView.center = point;
    
    if (index == [self.paths count]/2+20) {
        [self sendSubviewToBack:self.dotView];
        [self sendSubviewToBack:self.topClircle];
    }else if (index == [self.paths count]-20){
        [self bringSubviewToFront:self.dotView];
    }
}

//停止动画
-(void)stopAnimation
{
    if (_clircleTimer) {
        [_clircleTimer invalidate];
        _clircleTimer = nil;
    }
    
    self.topClircle.hidden = YES;
    self.bottomClircle.hidden = YES;
    self.dotView.hidden = YES;
    self.healthLabel.hidden = NO;
    self.dotView.center = CGPointFromString(self.paths[0]);
    [self bringSubviewToFront:self.dotView];
    
    [_valueLabel updateConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    [_testButton updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_valueLabel.bottom).offset(0);
    }];
}

//初始华运动轨迹
-(void)initAnimationPaths
{
    self.paths = [NSMutableArray array];
    
    CGFloat contentCenterX=115;
    CGFloat contentCenterY = 115;
    CGFloat a = 115;
    CGFloat b = 30;
    
    //下半部分的轨迹
    for (int x=0; x<230; x++) {
        CGFloat y = (int) (sqrt((1 - pow(x - contentCenterX, 2) / pow(a, 2)) * pow(b, 2)) * 1 + contentCenterY);
        [self.paths addObject:NSStringFromCGPoint(CGPointMake(x+35, y+35))];
    }
    
    //上半部分的轨迹
    for (int x=230; x>0; x--) {
        CGFloat y = (int) (sqrt((1 - pow(x - contentCenterX, 2) / pow(a, 2)) * pow(b, 2)) * -1 + contentCenterY);
        [self.paths addObject:NSStringFromCGPoint(CGPointMake(x+35, y+35))];
    }
}

@end
