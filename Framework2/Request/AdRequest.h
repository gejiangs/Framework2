//
//  AdRequest.h
//  Framework2
//
//  Created by 郭江 on 2017/3/8.
//  Copyright © 2017年 郭江. All rights reserved.
//

#import "BaseRequest.h"
#import "AdModel.h"

@interface AdRequest : BaseRequest

-(void)getADInfoWithSuccess:(void (^)(BOOL success, AdModel *adModel))success
                    failure:(void (^)(NSError *error))failure;

@end
