//
//  MABaseViewController.m
//  ConnectJSP-test
//
//  Created by MARVIS on 2017/3/25.
//  Copyright © 2017年 MARVIS. All rights reserved.
//

#import "MABaseViewController.h"
#import "MACommon.h"

#define kWIDTH   44.0

// CUSTOM NAV APPERANCE

#define kNAV_BAR_HEIGHT   40.0

#define STATUS_BAR_COLOR [UIColor redColor]

#define NAV_BAR_COLOR    [UIColor redColor]

#define NAV_TEXT_COLOR   [UIColor whiteColor]

#define NAV_TEXT_FONT    [UIFont systemFontOfSize:16.0]


@interface MABaseViewController ()
{
    CGFloat barSpacing;
}
@property (strong, nonatomic) UIView *statusBarView;
@property (strong, nonatomic) UIView *naviBarView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIButton *leftBtn;
@property (strong, nonatomic) UIButton *rightBtn;

@property (nonatomic, strong) UIImageView *bottomLineBreakImgView;

@property (nonatomic, strong) UIView *exceptionView;
@property (nonatomic, strong) UIImageView *expTipImgView;
@property (nonatomic, copy)   DEAL_EXP_ACTION exceptionAction;

@end

@implementation MABaseViewController

- (id)init {
    self = [super init];
    if (self) {
        //
        barSpacing = 0.0;
    }
    return self;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation{
    return UIStatusBarAnimationFade;
}

- (void)initWithStatusBar {
    CGRect frame = CGRectZero;
    // The status bar default color by red color.
    frame = CGRectMake(0.0, 0.0, kScreenWidth, barSpacing);
    self.statusBarView = [[UIView alloc] initWithFrame:frame];
    [self.statusBarView setBackgroundColor:STATUS_BAR_COLOR];
    [self.view addSubview:_statusBarView];
}

- (void)initWithNaviBar {
    CGRect frame = CGRectZero;
    // The status bar default color by red color.
    frame = CGRectMake(0.0, barSpacing, kScreenWidth, kNAV_BAR_HEIGHT);
    self.naviBarView = [[UIView alloc] initWithFrame:frame];
    [self.naviBarView setBackgroundColor:NAV_BAR_COLOR];
    [self.view addSubview:_naviBarView];
    
    // Left button
    frame = CGRectMake(0.0, 0.0, kWIDTH, kNAV_BAR_HEIGHT);
    self.leftBtn = [[UIButton alloc] initWithFrame:frame];
    [self.leftBtn addTarget:self
                     action:@selector(handleBarBtnAction:)
           forControlEvents:UIControlEventTouchUpInside];
    [self.leftBtn setTitleColor:NAV_TEXT_COLOR forState:UIControlStateNormal];
    [self.leftBtn.titleLabel setFont:NAV_TEXT_FONT];
    [self.leftBtn setTag:NaviBarBtnLeft];
    [self.leftBtn setHidden:YES];
    [self.naviBarView addSubview:_leftBtn];
    
    // Right button
    frame = CGRectMake(CGRectGetWidth(_naviBarView.bounds) - kWIDTH, 0.0, kWIDTH, kNAV_BAR_HEIGHT);
    self.rightBtn = [[UIButton alloc] initWithFrame:frame];
    [self.rightBtn addTarget:self
                      action:@selector(handleBarBtnAction:)
            forControlEvents:UIControlEventTouchUpInside];
    [self.rightBtn.titleLabel setFont:NAV_TEXT_FONT];
    [self.rightBtn setTitleColor:NAV_TEXT_COLOR forState:UIControlStateNormal];
    [self.rightBtn setTag:NaviBarBtnRight];
    [self.rightBtn setHidden:YES];
    [self.naviBarView addSubview:_rightBtn];
    
    // Title label
    frame = CGRectMake(0.0, 0.0, 0.0, kNAV_BAR_HEIGHT);
    self.titleLabel = [[UILabel alloc] initWithFrame:frame];
    [self.titleLabel setBackgroundColor:[UIColor clearColor]];
    [self.titleLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [self.titleLabel setFont:NAV_TEXT_FONT];
    [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.titleLabel setTextColor:NAV_TEXT_COLOR];
    [self.naviBarView addSubview:_titleLabel];
    
    frame = CGRectMake(0, kNAV_BAR_HEIGHT - 1, kScreenWidth, 1);
    self.bottomLineBreakImgView = [[UIImageView alloc] initWithFrame:frame];
    UIImage *image = [[UIImage imageNamed:@"login_linebreak"] stretchableImageWithLeftCapWidth:2 topCapHeight:1];
    self.bottomLineBreakImgView.image = image;
    [self.naviBarView addSubview:_bottomLineBreakImgView];
    [self.bottomLineBreakImgView setHidden:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.modalPresentationCapturesStatusBarAppearance = NO;
    
    barSpacing = 20.0;
    [self initWithStatusBar];
    
    // init navi bar
    [self initWithNaviBar];
    if ([self respondsToSelector:@selector(customUI)]) {
        [self customUI];
    }
    
}

#pragma mark - 判断是否有网络

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view bringSubviewToFront:self.statusBarView];
    [self.view bringSubviewToFront:self.naviBarView];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{//统一在此取消VC注册到通知中心的通知，防止出现崩溃问题。
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - touchAction
#pragma mar
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

#pragma mark - Public method
- (void)setupStatusBarWithColor:(UIColor *)color {
    if (![color isEqual:_statusBarView.backgroundColor]) {
        [self.statusBarView setBackgroundColor:color];
    }
}

- (void)setupStatusBarHidden:(BOOL)hidden {
    [self.statusBarView setHidden:hidden];
}

- (void)setupNaviBarWithColor:(UIColor *)color {
    if (![color isEqual:_naviBarView.backgroundColor]) {
        [self.naviBarView setBackgroundColor:color];
    }
}

- (void)setupNaviBarHidden:(BOOL)hidden {
    [self.naviBarView setHidden:hidden];
}

- (void)setupNavLineBreakimgViewHidden:(BOOL)hidden{
    [self.bottomLineBreakImgView setHidden:hidden];
}

- (void)setupNaviBarWithTitle:(NSString *)title {
    if (_titleLabel && [title length] > 0) {
        [self.titleLabel setText:title];
        
        CGRect frame = _titleLabel.frame;
        //标题title 不能超过160 否则会影响界面展示效果
        frame.size.width = MIN([MACommon getLabelWidth:_titleLabel], 160);
        [self.titleLabel setFrame:frame];
        
        CGPoint center = CGPointMake(self.naviBarView.center.x, self.naviBarView.center.y - barSpacing);
        [self.titleLabel setCenter:center];
    }
}

- (void)setupNaviBarHiddenBtnWithLeft:(BOOL)left
                                right:(BOOL)right {
    if (left != _leftBtn.isHidden) {
        [self.leftBtn setHidden:left];
    }
    
    if (right != _rightBtn.isHidden) {
        [self.rightBtn setHidden:right];
    }
}

- (void)setupNaviBarWithBackAndTitle:(NSString *)title {
    [self setupNaviBarWithTitle:title];
    
    if ([[self.navigationController viewControllers] count] > 1) {
        [self setupNaviBarWithBtn:NaviBarBtnLeft
                        titleText:@""
                            image:@"navi_back_nor"];
    }
}

- (void)setupNaviBarWithBtn:(NaviBarBtn)btnType
                  titleText:(NSString *)text
                      image:(NSString *)imgName{
    UIButton *btn = nil;
    if (btnType == NaviBarBtnLeft) {
        btn = _leftBtn;
    } else if (btnType == NaviBarBtnRight) {
        btn = _rightBtn;
    }
    
    if (!btn) return;
    if ([btn isHidden]) [btn setHidden:NO];
    
    CGRect frame = btn.frame;
    UIImage *image = nil;
    if ([imgName length] > 0) {
        image = [UIImage imageNamed:imgName];
        [btn setImage:image forState:UIControlStateNormal];
        
        frame.size.width = MAX(image.size.width, 44.0);
    }
    
    if ([text length] > 0) {
        [btn setTitle:text forState:UIControlStateNormal];
        
        if (image) {
            frame.size.width = image.size.width + [MACommon getLabelWidth:btn.titleLabel] + 20.0;
        } else {
            frame.size.width = [MACommon getLabelWidth:btn.titleLabel] + 20.0;
        }
    }
    
    frame.size.width = MAX(CGRectGetWidth(frame), CGRectGetWidth(btn.frame));
    
    if (btn.tag == NaviBarBtnRight) {
        frame.origin.x = CGRectGetWidth(_naviBarView.bounds) - CGRectGetWidth(frame);
    }
    
    [btn setFrame:frame];
}

- (void)setupNaviBarWithCustomView:(UIView *)view {
    if (view) {
        //
        [self.titleLabel setHidden:YES];
        
        [self.naviBarView addSubview:view];
    }
}

- (CGFloat)getNaviBarHeight {
    if (_naviBarView && !_naviBarView.isHidden) {
        return barSpacing + CGRectGetHeight(_naviBarView.frame);
    }
    return barSpacing;
}

- (CGFloat)getContentHeight {
    return CGRectGetHeight(self.view.bounds) - [self getNaviBarHeight];
}

- (UIView *)getStatusBarView{
    return  self.statusBarView;
}

- (UIView *)getNaviBarView {
    return self.naviBarView;
}

- (UILabel *)getTitleLabel {
    return self.titleLabel;
}

- (UIButton *)getNavBarBtn:(NaviBarBtn)btnTag{
    if (btnTag == NaviBarBtnLeft) {
        return self.leftBtn;
    } else if(btnTag == NaviBarBtnRight){
        return self.rightBtn;
    }
    return nil;
}

- (void)setUpShowExceptionViewWithImage:(UIImage *)tipImage
                                 topGap:(CGFloat )vGapDistance
                             dealAction:(DEAL_EXP_ACTION)action{
    if (!tipImage) {
        NSLog(@"exception Tip image can not be nil !!!");
        return;
    }
    
    if (!self.exceptionView) {
        CGFloat v_distance =  CGRectGetMaxY(self.naviBarView.frame) + vGapDistance;
        CGRect frame = CGRectMake(0, v_distance, kScreenWidth, kScreenHeight - v_distance);
        self.exceptionView = [[UIView alloc] initWithFrame:frame];
        self.exceptionView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_exceptionView];
    } else {
        self.exceptionView.hidden = NO;
    }
    [self.view bringSubviewToFront:_exceptionView];
    
    if (!self.expTipImgView) {
        self.expTipImgView = [[UIImageView alloc] init];
        [self.exceptionView addSubview:self.expTipImgView];
    }
    CGSize tipImgSize = tipImage.size;
    self.expTipImgView.image = tipImage;
    self.expTipImgView.bounds = CGRectMake(0, 0, tipImgSize.width, tipImgSize.height);
    CGPoint center = CGPointMake(kScreenWidth/2, CGRectGetHeight(self.exceptionView.frame)/2);
    center.y = center.y - 30 - vGapDistance/8;
    self.expTipImgView.center = center;
    
    if (action) {
        self.exceptionAction = action;
        [MACommon addTapGesturesWithView:self.expTipImgView target:self selector:@selector(exceptionImgTapAction:)];
    } else {
        self.exceptionAction = nil;
    }
    
}

- (void)setUpHiddenExceptionView{
    self.exceptionView.hidden = YES;
}

- (void)exceptionImgTapAction:(UITapGestureRecognizer *)tapGestureRecognizer{
    if (self.exceptionAction) {
        self.exceptionAction();
    }
}


#pragma mark - Public method
- (void)customUI{
    NSLog(@"son class should implement this Method!");
}

- (void)handleBarBtnAction:(UIButton *)btn {
    if (btn.tag == NaviBarBtnLeft) {
        if ([[self.navigationController viewControllers] count] != 1) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}


@end
