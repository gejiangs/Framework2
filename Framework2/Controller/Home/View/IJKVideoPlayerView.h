//
//  IJKVideoPlayerView.h
//  Framework2
//
//  Created by 郭江 on 2017/5/16.
//  Copyright © 2017年 郭江. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IJKVideoPlayerView : UIView

@property (nonatomic, copy)void(^dimissCompleteBlock)(void);

- (id)initWithFrame:(CGRect)frame urlString:(NSString *)urlString;
- (void)showInWindow;
- (void)showInView:(UIView *)view;
- (void)dismiss;

@end
