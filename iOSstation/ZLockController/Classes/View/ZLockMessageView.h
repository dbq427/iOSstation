//
//  ZLockMessageView.h
//  ZLockDemo
//
//  Created by 张彦东 on 15/11/27.
//  Copyright © 2015年 yd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZLockMessageView;

typedef NS_ENUM(NSUInteger, ZLockMessageType) {
    ZLockMessageTypeNormal,
    ZLockMessageTypeWarnning
};

@protocol ZLockMessageViewDelegate <NSObject>

@optional
- (void)lockMessageViewDidCancelLock:(ZLockMessageView *)messageView;

@end


@interface ZLockMessageView : UIView

@property (nonatomic, weak) id<ZLockMessageViewDelegate> delegate;

- (void)showMessage:(NSString *)msg type:(ZLockMessageType)type;

- (void)setTitle:(NSString *)title;

- (void)clearMessage;

@end
