//
//  ZLockView.h
//  ZLockDemo
//
//  Created by 张彦东 on 15/11/26.
//  Copyright © 2015年 yd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZLockView;

@protocol ZLockViewDelegate <NSObject>

@optional
- (void)lockView:(ZLockView *)lockView didEndDrawWithPassCode:(NSString *)passCode;
- (void)lockViewWillBeginDrow:(ZLockView *)lockView;
@end


@interface ZLockView : UIView

@property (nonatomic, weak) id<ZLockViewDelegate> delegate;


@end
