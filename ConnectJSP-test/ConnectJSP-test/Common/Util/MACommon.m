//
//  MACommon.m
//  ConnectJSP-test
//
//  Created by MARVIS on 2017/3/25.
//  Copyright © 2017年 MARVIS. All rights reserved.
//

#import "MACommon.h"

@implementation MACommon

+ (void)addTapGesturesWithView:(UIView*)view target:(id)target selector:(SEL)selector {
    view.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:target action:selector];
    [tapGesture setNumberOfTapsRequired:1];
    [view addGestureRecognizer:tapGesture];
}

+ (CGFloat)getLabelWidth:(UILabel *)label {
    if (!label) {
        return 0.0;
    }
    CGSize constraint = CGSizeMake(MAXFLOAT, label.frame.size.height);
    return [self getStringSize:label.text constraint:constraint fontSize:label.font].width ;
}

+ (CGFloat)getLabelHeight:(UILabel *)label {
    if (!label) {
        return 0.0;
    }
    CGSize constraint = CGSizeMake(label.frame.size.width, MAXFLOAT);
    return [self getStringSize:label.text constraint:constraint fontSize:label.font].height ;
    
}

//不再支持iOS6
+ (CGSize)getStringSize:(NSString *)text constraint:(CGSize )constraint fontSize:(UIFont *)fontSize{
    NSDictionary *dict = [NSDictionary dictionaryWithObject:fontSize forKey: NSFontAttributeName];
    CGSize  size = [text boundingRectWithSize:constraint
                                      options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                   attributes:dict
                                      context:nil].size;
    return size;
}



@end
