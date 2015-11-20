//
//  LXOtherViewController.m
//  iOSstation
//
//  Created by 张彦东 on 15/11/19.
//  Copyright © 2015年 lx. All rights reserved.
//

#import "LXOtherViewController.h"

@interface LXOtherViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@end

@implementation LXOtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.navigationController.navigationBar.translucent = NO;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

@end
