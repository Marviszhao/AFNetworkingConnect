//
//  LGBaseNetWorking.h
//  NanShen
//
//  Created by MARVIS on 16/5/17.
//  Copyright © 2016年 com.xxd.woyao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LSConstants.h"

#define kStatusCode                 @"status"
#define kResData                    @"resData"

#define LOAD_DATA_PAGESIZE  10

typedef NS_ENUM(NSInteger, STATUS_CODE) {
    STATUS_CODE_CUSTOM_ERROR       = - 10000,
    STATUS_CODE_FAILED             = - 11001,//网络异常类型
    STATUS_CODE_SUCCESS            = 200,//接口调用成功
    STATUS_CODE_NEED_CHARGE        = 10088,//用户金币不足
    
    
};
//额外存储数据时使用
typedef void(^RES_SUCC_OPERATION_BLOCK)(id data);
/**
 *  封装二次请求到dataController时的处理
 *
 *  @param success    请求是否成功
 *  @param resultData 回调数据
 */
typedef void(^RES_SIM_CALLBACK)(BOOL success,id resultData);

typedef void(^RES_SUCC_BLOCK)(id data);
/**
 *  请求失败回调
 *
 *  @param resStatus 服务请请求返回状态码（主）、网络异常导致的失败也包括、不包括STATUS_CODE_SUCCESS
 *  @param data      暂时为字符串类型，包括@“当前网络异常，请稍后重试!”
 */
typedef void(^RES_FAIL_BLOCK)(NSInteger resStatus,id data);


@interface LSBaseNetWorking : NSObject

- (void)getHTTPRequestWithUrlString:(NSString *)urlStr
                         parameters:(NSDictionary *)paraDic
                            success:(RES_SUCC_BLOCK)succ
                            failure:(RES_FAIL_BLOCK)fail;

- (void)postHTTPRequestWithUrlString:(NSString *)urlStr
                          parameters:(NSDictionary *)paraDic
                             success:(RES_SUCC_BLOCK)succ
                             failure:(RES_FAIL_BLOCK)fail;

@end
