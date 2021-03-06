//
//  UIColor+Utils.h
//  SanLianOrdering
//
//  Created by guojiang on 14-10-10.
//  Copyright (c) 2014年 DaCheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Utils)

#pragma mark --颜色相关方法
+ (UIColor *) colorWithHexString: (NSString *)hexColor;//颜色转换 IOS中十六进制的颜色转换为UIColor
+ (NSData *)hexDataWithRGBColor:(UIColor *)color;//颜色转换 UIColor转成十六进制hexData值
@end
