//
//  CALayer+Anim.m
//  ZLockDemo
//
//  Created by 张彦东 on 15/11/27.
//  Copyright © 2015年 yd. All rights reserved.
//

#import "CALayer+Anim.h"

@implementation CALayer (Anim)

-(void)shake{
    
    CAKeyframeAnimation *kfa = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    
    CGFloat s = 16;
    
    kfa.values = @[@(-s),@(0),@(s),@(0),@(-s),@(0),@(s),@(0)];
    
    kfa.duration = .1f;
    kfa.repeatCount =2;
    kfa.removedOnCompletion = YES;
    
    [self addAnimation:kfa forKey:@"shake"];
}


@end
