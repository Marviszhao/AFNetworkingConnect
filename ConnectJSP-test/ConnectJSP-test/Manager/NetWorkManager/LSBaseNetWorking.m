//
//  LGBaseNetWorking.m
//  NanShen
//
//  Created by MARVIS on 16/5/17.
//  Copyright © 2016年 com.xxd.woyao. All rights reserved.
//

#import "LSBaseNetWorking.h"
#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"
typedef NS_ENUM(NSUInteger, HttpRequestType) {
    DoGet,
    DoPost,
};

@interface LSBaseNetWorking ()

@property (nonatomic, strong) AFHTTPSessionManager* httpManager;

@end

@implementation LSBaseNetWorking
- (instancetype)init{
    self = [super init];
    if (self) {
        //
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
        _httpManager = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:BASE_URL_STR]];
        NSSet *set = [NSSet setWithObjects:@"text/html",@"text/plain",@"application/json", nil];
        _httpManager.requestSerializer.cachePolicy =  NSURLRequestReloadIgnoringLocalCacheData;
        _httpManager.responseSerializer.acceptableContentTypes = set;
        [_httpManager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            NSLog(@"Reachability = %ld",(long)status);
            switch (status) {
                case AFNetworkReachabilityStatusReachableViaWWAN:
                case AFNetworkReachabilityStatusReachableViaWiFi:
//                    [operationQueue setSuspended:NO];
                    NSLog(@"network is now changed Reachable！！！");
                    break;
                case AFNetworkReachabilityStatusNotReachable:
//                    [operationQueue setSuspended:YES];
                    NSLog(@"network is now changed  NotReachable！！！");
                    break;
                default:
                    break;
            }
        }];
        [_httpManager.reachabilityManager startMonitoring];
    }
    return self;
}

- (void)printHTTPUrlWithUrl:(NSString *)url
                 parameters:(NSDictionary *)parameters{
    NSString *httpUrl = @"";
    NSString *dicKey = nil;
    for (int i = 0; i < [[parameters allKeys] count]; i++) {
        httpUrl = i == 0 ? @"?" : [httpUrl stringByAppendingString:@"&"];
        
        dicKey = [parameters allKeys][i];
        httpUrl = [httpUrl stringByAppendingFormat:@"%@=%@", dicKey, parameters[dicKey]];
    }
    //Warn httpUrl 非nil 否则追加会导致崩溃
    httpUrl = [url stringByAppendingString:httpUrl];
    
    NSLog(@"\n-----------------[HTTP Url]-----------------\n%@%@\
              \n--------------------------------------------", BASE_URL_STR,httpUrl);
}

- (void)requestHTTPRequestWithReqType:(HttpRequestType)reqType
                            UrlString:(NSString *)urlStr
                           parameters:(NSDictionary *)paraDic
                            operation:(RES_SUCC_OPERATION_BLOCK)operAction
                              success:(RES_SUCC_BLOCK)succ
                              failure:(RES_FAIL_BLOCK)fail{
    void (^success)(NSURLSessionTask *operation, id responseObject) = ^(NSURLSessionTask *operation, id responseObject) {
        NSInteger statuscode = [responseObject[ kStatusCode ] integerValue];
        id data = responseObject[kResData];
        if (succ || fail) {//成功或失败有处理就进行打印
            [self printHTTPUrlWithUrl:urlStr parameters:paraDic];
        }
        if (statuscode == STATUS_CODE_SUCCESS) {
            if (operAction) {
                operAction(data);
            }
            if (succ) {
                NSLog(@"\nStatus:%li \n%@\n---------------------------------------", (long)statuscode, responseObject);
                succ(data);
            }
        }else {
            NSString *errorTipMsg = responseObject[kResData];
            //调整输出模式,只有statuscode = 600提示且为字符串通通输出
            if (statuscode == 600 && [errorTipMsg respondsToSelector:@selector(length)] && kStrProperty(errorTipMsg)) {

            }else if (statuscode ==  601 && [errorTipMsg respondsToSelector:@selector(length)] && kStrProperty(errorTipMsg)) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:errorTipMsg delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles: nil];
                [alertView show];
            }
            if (fail) {
                NSLog(@"responseObject error:%@", responseObject);
                fail([responseObject[kStatusCode] integerValue],data);
            }
        }
    };
    
    void (^failure)(NSURLSessionTask *operation, NSError *error) = ^(NSURLSessionTask *operation, NSError *error) {
        if (succ && fail) {//成功失败都处理才进行打印
            [self printHTTPUrlWithUrl:urlStr parameters:paraDic];
        }
        NSLog(@"Error:%@", error);
        if (fail) {
            fail(STATUS_CODE_FAILED,@"当前网络异常，请稍后重试!");
        }
    };
    
    //    默认追加的参数
    NSMutableDictionary *newParameters = [NSMutableDictionary dictionaryWithDictionary:paraDic];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"参数值－－－－%@\n", newParameters);
    });
    if (reqType == DoGet) {
        [_httpManager GET:urlStr parameters:newParameters progress:nil success:success failure:failure];
    } else if (reqType == DoPost){
        [_httpManager POST:urlStr parameters:newParameters progress:nil success:success failure:failure];
    }
}

- (void)postHTTPRequestWithUrlString:(NSString *)urlStr
                          parameters:(NSDictionary *)paraDic
                             success:(RES_SUCC_BLOCK)succ
                             failure:(RES_FAIL_BLOCK)fail{
    [self requestHTTPRequestWithReqType:DoPost
                              UrlString:urlStr
                             parameters:paraDic
                              operation:nil
                                success:succ
                                failure:fail];
}

- (void)getHTTPRequestWithUrlString:(NSString *)urlStr
                         parameters:(NSDictionary *)paraDic
                            success:(RES_SUCC_BLOCK)succ
                            failure:(RES_FAIL_BLOCK)fail{
    [self requestHTTPRequestWithReqType:DoGet
                              UrlString:urlStr
                             parameters:paraDic
                              operation:nil
                                success:succ
                                failure:fail];
}

@end
