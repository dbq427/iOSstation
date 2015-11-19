//
//  LXHotViewController.m
//  iOSstation
//
//  Created by 张彦东 on 15/11/19.
//  Copyright © 2015年 lx. All rights reserved.
//

#import "LXHotViewController.h"
#import "LXBannerView.h"

@interface LXHotViewController ()

@end

@implementation LXHotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.navigationController.navigationBar.translucent = NO;
    
    NSArray * array = @[@"http://img15.3lian.com/2015/f2/147/d/36.jpg",
                        @"http://a.hiphotos.baidu.com/zhidao/wh%3D600%2C800/sign=cb9f41bdfe039245a1e0e909b7a488fa/e61190ef76c6a7efc64a1f56fffaaf51f3de6655.jpg",
                        @"http://img6.faloo.com/Picture/0x0/0/747/747488.jpg",
                        @"http://hiphotos.baidu.com/%95%D7%D4%AA%B5%C0/pic/item/432e6436d9cd9b4deac4af86.jpg"];
    
    
    LXBannerView * bannerView = [[LXBannerView alloc] init];
    [self.view addSubview:bannerView];
    bannerView.imageUrls = array;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

@end
