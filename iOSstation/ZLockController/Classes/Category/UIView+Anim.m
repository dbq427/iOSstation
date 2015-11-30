//
//  UIView+Anim.m
//  ZLockDemo
//
//  Created by 张彦东 on 15/11/30.
//  Copyright © 2015年 yd. All rights reserved.
//

#import "UIView+Anim.h"

@implementation UIView (Anim)


+ (void)animateWithDuration1:(NSTimeInterval)duration1 animations1:(void (^__nullable)(void))animations1 duration2:(NSTimeInterval)duration2 animations2:(void (^__nullable)(void))animations2 completion:(void (^ __nullable)(BOOL finished))completion {
    
    [UIView animateWithDuration:duration1 animations:animations1 completion:^(BOOL finished) {
        if (animations2) {
            [UIView animateWithDuration:duration2 animations:animations2 completion:completion];
        }
    }];
}

@end
