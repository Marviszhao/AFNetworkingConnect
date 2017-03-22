//
//  LSConstants.h
//  LiveShow
//
//  Created by MARVIS on 16/6/24.
//  Copyright © 2016年 MARVIS. All rights reserved.
//

#ifndef LSConstants_h
#define LSConstants_h

#define BASE_URL_STR @"http://192.168.8.129:8080/Oracle-test/"

//屏幕的物理尺寸
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

/*
 * CoreData filter
 */
//FIXIT kIntProperty,kFloatProperty,kUIntProperty 类型定义优重复
#define kNotNullProperty(property)          ![(property) isKindOfClass:[NSNull class]]
#define kStrProperty(property)              (kNotNullProperty(property) && [property length] > 0)
#define kIntProperty(property)              (kNotNullProperty(property) && [property integerValue] >= 0)
#define kFloatProperty(property)            (kNotNullProperty(property) && [property floatValue] >= 0)
#define kUIntProperty(property)             (kNotNullProperty(property) && [property intValue] >= 0)
#define kArrayProperty(property)            [(property) isKindOfClass:[NSArray class]]
#define kDictProperty(property)             [(property) isKindOfClass:[NSDictionary class]]
#define kErrorProperty(property)            ![(property) isKindOfClass:[NSError class]]

#endif /* LSConstants_h */
