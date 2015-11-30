//
//  ZLockController.m
//  ZLockDemo
//
//  Created by 张彦东 on 15/11/26.
//  Copyright © 2015年 yd. All rights reserved.
//

#import "ZLockController.h"
#import "ZLockView.h"
#import "ZLockMessageView.h"
#import "ZLockConst.h"

@interface ZLockController () <ZLockViewDelegate, ZLockMessageViewDelegate>

@property (nonatomic, weak) ZLockView * lockView;
@property (nonatomic, weak) ZLockMessageView * messageView;
@property (nonatomic, weak) UIView * bottomView;

@property (nonatomic, copy) NSString * passCode;

@end

@implementation ZLockController

#pragma mark - 构造函数
+ (void)showRegistLockVCInVC:(UIViewController *)rootVC completeBlock:(ZLockControllerShowCompleteBlock)block {
    [self lockControllerWithRootVc:rootVC LockType:ZLockTypeRegist];
}

+ (void)showModifyLockVCInVC:(UIViewController *)rootVC completeBlock:(ZLockControllerShowCompleteBlock)block {
     [self lockControllerWithRootVc:rootVC LockType:ZLockTypeModify];
}

+ (void)showVerifyLockVCInVC:(UIViewController *)rootVC completeBlock:(ZLockControllerShowCompleteBlock)block {
     [self lockControllerWithRootVc:rootVC LockType:ZLockTypeVerify];
}

+ (void)lockControllerWithRootVc:(UIViewController *)rootVC LockType:(ZLockType)type {
    ZLockController * lockVC = [[self alloc] init];
    lockVC.lockType = type;
    [rootVC presentViewController:lockVC animated:YES completion:nil];
}

#pragma mark - 生命周期函数
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kControllerBackgroundColor;
    
    NSString * showTitle = nil;
    
    switch (self.lockType) {
        case ZLockTypeRegist:
            showTitle = kNormalMessageRegist;
            break;
        case ZLockTypeModify:
            showTitle = kNormalMessageModify;
            break;
        case ZLockTypeVerify:
            showTitle = kNormalMessageVerify;
            break;
        default:
            break;
    }
    [self.messageView setTitle:showTitle];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGFloat viewWidth = self.view.frame.size.width;
    CGFloat viewHeight = self.view.frame.size.height;
    CGFloat bottomViewHeight = 49;
    self.bottomView.frame = CGRectMake(0, viewHeight - bottomViewHeight, viewWidth, bottomViewHeight);
    self.lockView.frame = CGRectMake(0, viewHeight - bottomViewHeight - viewWidth, viewWidth, viewWidth);
    
    self.messageView.frame = CGRectMake(0, 0, viewWidth, self.lockView.frame.origin.y);
}

#pragma mark - ZLockViewDelegate
/**
 *  手势结束
 */
- (void)lockView:(ZLockView *)lockView didEndDrawWithPassCode:(NSString *)passCode {
    
    if ([passCode componentsSeparatedByString:@","].count < 5) {
        [self.messageView showMessage:kWarningMessageLowNodes type:ZLockMessageTypeWarnning];
        return;
    };
    
    switch (self.lockType) {
        case ZLockTypeRegist:
            if (self.passCode) {
                
                if ([self verifyPassCode:passCode]) {
                    
                    [self.messageView showMessage:kSuccessMessageRegist type:ZLockMessageTypeNormal];
                    [self saveLocalPassCode];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self goBack];
                    });
                } else {
                    [self.messageView showMessage:kWarningMessageSecond type:ZLockMessageTypeWarnning];
                }
            } else {
                self.passCode = passCode;
                [self.messageView setTitle:kNormalMessageSecond];
            }
            break;
        case ZLockTypeModify:
        {
            if ([self verifyPassCode:passCode]) {
                
                [self.messageView showMessage:kSuccessMessageVerify type:ZLockMessageTypeNormal];
                self.passCode = nil;
                [self.messageView setTitle:kNormalMessageRegist];
                self.lockType = ZLockTypeRegist;
            } else {
                [self.messageView showMessage:kWarningMessageVerify type:ZLockMessageTypeWarnning];
            }
        }
            break;
        case ZLockTypeVerify:
        {
            if ([self verifyPassCode:passCode]) {
                [self.messageView showMessage:kSuccessMessageVerify type:ZLockMessageTypeNormal];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self goBack];
                });
            } else {
                [self.messageView showMessage:kWarningMessageVerify type:ZLockMessageTypeWarnning];
            }
        }
            break;
        default:
            break;
    }
}

/**
 *  手势开始
 */
- (void)lockViewWillBeginDrow:(ZLockView *)lockView {
    [self.messageView clearMessage];
}

#pragma mark - 其他
+ (NSString *)localPassCode {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kPassCodeKey];
}

- (void)saveLocalPassCode {
    if (self.passCode == nil) return;
    [[NSUserDefaults standardUserDefaults] setObject:self.passCode forKey:kPassCodeKey];
}

- (void)goBack {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  验证密码一致性
 */
- (BOOL)verifyPassCode:(NSString *)passCode {
    
    NSString * localPassCode = self.passCode == nil ? [[self class] localPassCode] : self.passCode;
    return [localPassCode isEqualToString:passCode];
}

#pragma mark - ZLockMessageViewDelegate
- (void)lockMessageViewDidCancelLock:(ZLockMessageView *)messageView {
    UIAlertController * alertC = [UIAlertController alertControllerWithTitle:@"确定关闭？" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:nil]];
    [alertC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self goBack];
    }]];
    [self presentViewController:alertC animated:YES completion:nil];
}

#pragma mark - 懒加载
- (ZLockView *)lockView {
    if (_lockView == nil) {
        ZLockView * lockView = [[ZLockView alloc] init];
        [self.view addSubview:lockView];
        _lockView = lockView;
        lockView.delegate = self;
    }
    return _lockView;
}

- (ZLockMessageView *)messageView {
    if (_messageView == nil) {
        ZLockMessageView * view = [[ZLockMessageView alloc] init];
        [self.view addSubview:view];
        _messageView = view;
        view.delegate = self;
    }
    return _messageView;
}

- (UIView *)bottomView {
    if (_bottomView == nil) {
        UIView * view = [[UIView alloc] init];
        [self.view addSubview:view];
        _bottomView = view;
        view.backgroundColor = [UIColor clearColor];
    }
    return _bottomView;
}

+ (BOOL)hasLocalPassCode {
    
    NSString * passcode = [self localPassCode];
    
    if (passcode == nil || passcode.length == 0) {
        return NO;
    }
    return YES;
}

@end
