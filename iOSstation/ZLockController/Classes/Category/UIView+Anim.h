//
//  UIView+Anim.h
//  ZLockDemo
//
//  Created by 张彦东 on 15/11/30.
//  Copyright © 2015年 yd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Anim)

+ (void)animateWithDuration1:(NSTimeInterval)duration1 animations1:(void (^__nullable)(void))animations1 duration2:(NSTimeInterval)duration2 animations2:(void (^__nullable)(void))animations2 completion:(void (^ __nullable)(BOOL finished))completion;


@end
