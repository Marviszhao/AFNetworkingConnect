//
//  LSNetWorkManagerHeader.h
//  LiveShow
//
//  Created by MARVIS on 16/8/9.
//  Copyright © 2016年 MARVIS. All rights reserved.
//

#ifndef LSNetWorkManagerHeader_h
#define LSNetWorkManagerHeader_h

/**
 *  1.6版本接口，与后台版本号,teambition保持一致
 */
static NSString * const Interface[] = {
    @"",
    @"user/appLogin",                    // servlet用户登陆
    
};
/* HTTP接口对应的标识 */
typedef NS_ENUM(NSUInteger, InterfaceAction) {
    kNull = 0,
    kServletLogin,                        //servlet用户登陆
};


#endif /* LSNetWorkManagerHeader_h */
