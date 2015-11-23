//
//  LXLoginViewController.h
//  iOSstation
//
//  Created by 张彦东 on 15/11/23.
//  Copyright © 2015年 lx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LXLoginViewController;

@protocol LXLoginViewControllerDelegate <NSObject>

@optional
- (void)loginViewControllerLoginButtonDidClick:(LXLoginViewController *)viewController isLogin:(BOOL)isLogin;

@end

@interface LXLoginViewController : UIViewController

@property (nonatomic, assign, getter=isLogin) BOOL login;

@property (nonatomic, weak) id<LXLoginViewControllerDelegate> delegate;

@end
