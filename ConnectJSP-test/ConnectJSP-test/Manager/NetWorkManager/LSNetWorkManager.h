//
//  LGNetWorkManager.h
//  NanShen
//
//  Created by MARVIS on 16/5/17.
//  Copyright © 2016年 com.xxd.woyao. All rights reserved.
//

#import "LSBaseNetWorking.h"

@interface LSNetWorkManager : LSBaseNetWorking

+ (instancetype)shareInstance;

//kServletLogin,                        //第三方用户登陆
- (void)doReqLoginWithUserName:(NSString *)userName
                      password:(NSString *)password
                       success:(RES_SUCC_BLOCK)succ
                       failure:(RES_FAIL_BLOCK)fail;

@end
