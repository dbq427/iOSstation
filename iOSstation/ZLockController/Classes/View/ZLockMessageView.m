//
//  ZLockMessageView.m
//  ZLockDemo
//
//  Created by 张彦东 on 15/11/27.
//  Copyright © 2015年 yd. All rights reserved.
//

#import "ZLockMessageView.h"
#import "CALayer+Anim.h"
#import "UIView+Anim.h"
#import "ZLockConst.h"

@interface ZLockMessageView ()


@property (nonatomic, weak) UIButton * closeButton;

@property (nonatomic, weak) UILabel * msgLabel;

@property (nonatomic, weak) UILabel * titleLabel;

@end

@implementation ZLockMessageView

- (void)setTitle:(NSString *)title {
    
    [UIView animateWithDuration1:0.1 animations1:^{
        self.titleLabel.alpha = 0;
    } duration2:0.3 animations2:^{
        self.titleLabel.text = title;
        self.titleLabel.alpha = 1;
    } completion:nil];
}

- (void)showMessage:(NSString *)msg type:(ZLockMessageType)type {
    self.msgLabel.text = msg;
    
    switch (type) {
        case ZLockMessageTypeNormal:
        {
            self.msgLabel.textColor = [UIColor whiteColor];
            self.msgLabel.alpha = 0;
            self.msgLabel.transform = CGAffineTransformMakeTranslation(0, -30);
            [UIView animateWithDuration:0.3 animations:^{
                self.msgLabel.transform = CGAffineTransformIdentity;
                self.msgLabel.alpha = 1;
            }];
            break;
        }
        case ZLockMessageTypeWarnning:
        {
            self.msgLabel.textColor = [UIColor redColor];
            [self.msgLabel.layer shake];
            break;
        }
        default:
            break;
    }
}

- (void)clearMessage {
    self.msgLabel.text = @"";
}

#pragma mark - 懒加载
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.closeButton.frame = CGRectMake(0, 30, 100, 30);
    self.titleLabel.frame = CGRectMake(0, CGRectGetMaxY(self.closeButton.frame), self.frame.size.width, 60);
    self.msgLabel.frame = CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame), self.frame.size.width, 50);
}

#pragma mark - 懒加载
- (UILabel *)titleLabel {
    
    if (_titleLabel == nil) {
        UILabel * titleLabel = [[UILabel alloc] init];
        [self addSubview:titleLabel];
        _titleLabel = titleLabel;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = kViewTitleColor;
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = kViewTitleFont;
    }
    return _titleLabel;
}
- (UIButton *)closeButton {
    
    if (_closeButton == nil) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:button];
        _closeButton = button;
        [button setTitle:kViewCloseButtonText forState:UIControlStateNormal];
        [button setTitleColor:kViewCloseButtonColor forState:UIControlStateNormal];
        [button addTarget:self action:@selector(closeButtonClick) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = kViewCloseButtonFont;
    }
    return _closeButton;
}

- (UILabel *)msgLabel {
    
    if (_msgLabel == nil) {
        UILabel * label = [[UILabel alloc] init];
        [self addSubview:label];
        _msgLabel = label;
        label.font = kViewMessageFont;
        label.textAlignment = NSTextAlignmentCenter;
    }
    return _msgLabel;
}

#pragma mark - button click
- (void)closeButtonClick {
    if ([self.delegate respondsToSelector:@selector(lockMessageViewDidCancelLock:)]) {
        [self.delegate lockMessageViewDidCancelLock:self];
    }
}

@end
