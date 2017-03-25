//
//  MABaseViewController.h
//  ConnectJSP-test
//
//  Created by MARVIS on 2017/3/25.
//  Copyright © 2017年 MARVIS. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DEAL_EXP_ACTION)(void);

typedef NS_ENUM(int, NaviBarBtn) {
    NaviBarBtnLeft = 101,
    NaviBarBtnRight,
};
@interface MABaseViewController : UIViewController

- (void)setupStatusBarWithColor:(UIColor *)color;
- (void)setupStatusBarHidden:(BOOL)hidden;

- (void)setupNaviBarWithColor:(UIColor *)color;
- (void)setupNaviBarHidden:(BOOL)hidden;

- (void)setupNavLineBreakimgViewHidden:(BOOL)hidden;


- (void)setupNaviBarWithTitle:(NSString *)title;
- (void)setupNaviBarHiddenBtnWithLeft:(BOOL)left
                                right:(BOOL)right;
/**
 *  设置统一的默认的返回样式以及中间的title
 *
 *  @param title NavBar title 即 self.title 上面显示的内容
 */
- (void)setupNaviBarWithBackAndTitle:(NSString *)title;
/**
 *  设置导航栏的左右item
 *
 *  @param btnType 按钮类型
 *  @param text    按钮上显示的文字
 *  @param imgName   按钮上的小图标
 */
- (void)setupNaviBarWithBtn:(NaviBarBtn)btnType
                  titleText:(NSString *)text
                      image:(NSString *)imgName;
- (void)setupNaviBarWithCustomView:(UIView *)view;

- (CGFloat)getNaviBarHeight;
- (CGFloat)getContentHeight;

- (UIView *)getStatusBarView;
- (UIView *)getNaviBarView;
- (UILabel *)getTitleLabel;
- (UIButton *)getNavBarBtn:(NaviBarBtn)btnTag;



- (void)setUpShowExceptionViewWithImage:(UIImage *)tipImage
                                 topGap:(CGFloat )vGapDistance
                             dealAction:(DEAL_EXP_ACTION)action;

- (void)setUpHiddenExceptionView;

#pragma mark - son class should be  Overwrite method
/**
 *  provide customUI decorate
 */
- (void)customUI;

/**
 *  handle left/right custom navbar action
 *
 *  @param barbtn <#barbtn description#>
 */
- (void)handleBarBtnAction:(UIButton *)barbtn;


@end
