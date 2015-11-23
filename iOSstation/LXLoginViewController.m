//
//  LXLoginViewController.m
//  iOSstation
//
//  Created by 张彦东 on 15/11/23.
//  Copyright © 2015年 lx. All rights reserved.
//

#import "LXLoginViewController.h"

@interface LXLoginViewController ()

@end

@implementation LXLoginViewController


- (IBAction)loginButtonClick:(id)sender {
    
    self.login = !self.isLogin;
    
    if ([self.delegate respondsToSelector:@selector(loginViewControllerLoginButtonDidClick:isLogin:)]) {
        [self.delegate loginViewControllerLoginButtonDidClick:self isLogin:self.isLogin];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
