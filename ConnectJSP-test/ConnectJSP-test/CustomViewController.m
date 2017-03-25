//
//  CustomViewController.m
//  ConnectJSP-test
//
//  Created by MARVIS on 2017/3/25.
//  Copyright © 2017年 MARVIS. All rights reserved.
//

#import "CustomViewController.h"
#define WEAKSELF(weakSelf)  __weak __typeof(&*self)weakSelf = self;

@interface CustomViewController ()

@end

@implementation CustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - OverWirte
#pragma mark - 
//改方法的执行介于子类的viewDidLoad 之前，父类的viewDidLoad之后，用于界面子view的构建
- (void)customUI{
    //方式一
    [self setupNaviBarWithBackAndTitle:@"自定义navbar"];
    [self setupNaviBarWithBtn:NaviBarBtnRight titleText:nil image:@"navi_editor_nor"];
    
    //方式二
//    [self setupNaviBarWithTitle:@"自定义navbar"];
//    [self setupNaviBarWithBtn:NaviBarBtnLeft titleText:@"返回" image:@"navi_back_nor"];
//    [self setupNaviBarWithBtn:NaviBarBtnRight titleText:@"编辑" image:@"navi_editor_nor"];
    
    //设置默认空数据展示
    WEAKSELF(weakSelf);
    [self setUpShowExceptionViewWithImage:[UIImage imageNamed:@"toast_cry_4"] topGap:0 dealAction:^{
        [weakSelf setUpHiddenExceptionView];
        NSLog(@"被点击了");
    }];
}


- (void)handleBarBtnAction:(UIButton *)barbtn{
    if (barbtn.tag == NaviBarBtnLeft) {//也可默认不处理交给父类
        if ([[self.navigationController viewControllers] count] != 1) {
            [self.navigationController popViewControllerAnimated:YES];
        }

    }else if(barbtn.tag == NaviBarBtnRight){
        NSLog(@"点击了右侧的按钮");
    }
}


@end
