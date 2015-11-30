//
//  ZLockController.h
//  ZLockDemo
//
//  Created by 张彦东 on 15/11/26.
//  Copyright © 2015年 yd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ZLockType) {
    ZLockTypeRegist = 0,
    ZLockTypeModify,
    ZLockTypeVerify
};

@class ZLockController;

typedef void(^ZLockControllerShowCompleteBlock)(ZLockController * lockController);

@protocol ZLockControllerDelegate <NSObject>

@end

@interface ZLockController : UIViewController

@property (nonatomic, weak) id<ZLockControllerDelegate> delegate;

@property (nonatomic, assign) ZLockType lockType;


+ (BOOL)hasLocalPassCode;

+ (void)showRegistLockVCInVC:(UIViewController *)rootVC completeBlock:(ZLockControllerShowCompleteBlock)block;
+ (void)showModifyLockVCInVC:(UIViewController *)rootVC completeBlock:(ZLockControllerShowCompleteBlock)block;
+ (void)showVerifyLockVCInVC:(UIViewController *)rootVC completeBlock:(ZLockControllerShowCompleteBlock)block;

@end
