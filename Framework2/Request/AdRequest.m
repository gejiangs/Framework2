//
//  AdRequest.m
//  Framework2
//
//  Created by 郭江 on 2017/3/8.
//  Copyright © 2017年 郭江. All rights reserved.
//

#import "AdRequest.h"

@implementation AdRequest

-(void)getADInfoWithSuccess:(void (^)(BOOL, AdModel *))s failure:(void (^)(NSError *))failure
{
    [self requestGetWithURL:@"http://m2.qiushibaike.com/ad?AdID=14260582945040F4E3A48F"
                     params:nil
                    success:^(BOOL success, NSString *msg, id object) {
                        AdModel *adModel = [AdModel mj_objectWithKeyValues:object];
                        s(YES, adModel);
                    } failure:^(NSError *error) {
                        
                    }];
    
}

@end
