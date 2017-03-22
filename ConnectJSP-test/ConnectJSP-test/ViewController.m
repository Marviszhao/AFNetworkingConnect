//
//  ViewController.m
//  ConnectJSP-test
//
//  Created by MARVIS on 2017/2/22.
//  Copyright © 2017年 MARVIS. All rights reserved.
//

#import "ViewController.h"
#import "LSNetWorkManager.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UITextField *userNameTF;

@property (nonatomic, weak) IBOutlet UITextField *userPswTF;

-(IBAction)buttonClick :(UIButton *)butt;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(IBAction)buttonClick :(UIButton *)butt{
    NSString *userName = self.userNameTF.text;
    NSString *usePsw = self.userPswTF.text;
    [[LSNetWorkManager shareInstance] doReqLoginWithUserName:userName password:usePsw success:^(id data) {
        
    } failure:^(NSInteger resStatus, id data) {
        
    }];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
