//
//  LGNetWorkManager.m
//  NanShen
//
//  Created by MARVIS on 16/5/17.
//  Copyright © 2016年 com.xxd.woyao. All rights reserved.
//

#import "LSNetWorkManager.h"
#import "MJExtension.h"
#import "LSNetWorkManagerInterface.h"

static LSNetWorkManager *networkManager = nil;

@interface LSNetWorkManager ()


@end

@implementation LSNetWorkManager

+ (instancetype)shareInstance{
    @synchronized (self) {
        if (networkManager == nil) {
            networkManager = [[LSNetWorkManager alloc] init];
        }
    }
    return networkManager;
}

+ (instancetype)allocWithZone:(NSZone *)zone
{
    @synchronized (self) {
        if (networkManager == nil) {
            networkManager = [super allocWithZone:zone];
        }
        return networkManager;
    }
    return nil;
}

#pragma mark - HTTP request
//kServletLogin,                        //第三方用户登陆
- (void)doReqLoginWithUserName:(NSString *)userName
                      password:(NSString *)password
                       success:(RES_SUCC_BLOCK)succ
                       failure:(RES_FAIL_BLOCK)fail{
    NSDictionary *params = @{@"userName" : userName,
                             @"userPsw" : password,
                             };
    [self postHTTPRequestWithUrlString:Interface[kServletLogin]
                            parameters:params
                               success:succ
                               failure:fail];
}

@end
