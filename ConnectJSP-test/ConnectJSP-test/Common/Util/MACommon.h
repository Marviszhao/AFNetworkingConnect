//
//  MACommon.h
//  ConnectJSP-test
//
//  Created by MARVIS on 2017/3/25.
//  Copyright © 2017年 MARVIS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MACommon : NSObject
+ (void)addTapGesturesWithView:(UIView*)view target:(id)target selector:(SEL)selector;

+ (CGFloat)getLabelWidth:(UILabel *)label;
+ (CGFloat)getLabelHeight:(UILabel *)label;
/**
 *  获取字符串的Size
 *
 *  @param text       需要计算的text
 *  @param constraint 约束类型限制条件
 *  @param fontSize   字体大小
 *
 *  @return 字符串的size
 */
+ (CGSize)getStringSize:(NSString *)text constraint:(CGSize )constraint fontSize:(UIFont *)fontSize;

@end
