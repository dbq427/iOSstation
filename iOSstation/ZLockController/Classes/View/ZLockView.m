//
//  ZLockView.m
//  ZLockDemo
//
//  Created by 张彦东 on 15/11/26.
//  Copyright © 2015年 yd. All rights reserved.
//

#import "ZLockView.h"
#import "ZLockConst.h"

@interface ZLockView ()


@property (nonatomic, strong) NSArray * buttons;

@property (nonatomic, strong) NSMutableArray * selectedButtons;

@property (nonatomic, assign) CGPoint currentTouchPoint;

@end

@implementation ZLockView



#pragma mark - constructor
- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.currentTouchPoint = kViewDefaultPoint;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        
    }
    return self;
}

#pragma mark - view life
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat buttonWidth = (self.frame.size.width - 4 * kViewMarginOfNodes) / 3;
    for (int i = 0; i < self.buttons.count; i++) {
        
        int row = i / kViewRowNumber;
        int col = i % kViewRowNumber;
        
        UIButton * button = self.buttons[i];
        
        button.frame = CGRectMake(kViewMarginOfNodes + col * (buttonWidth + kViewMarginOfNodes), kViewMarginOfNodes +  row * (buttonWidth + kViewMarginOfNodes), buttonWidth, buttonWidth);
    }
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];

    CGContextRef ref = UIGraphicsGetCurrentContext();
    CGContextClearRect(ref, self.bounds);
    UIButton * fBtn = self.selectedButtons.firstObject;
    CGContextMoveToPoint(ref, fBtn.center.x, fBtn.center.y);
    for (int i = 1; i < self.selectedButtons.count; i++) {
        UIButton * btn = self.selectedButtons[i];
        CGContextAddLineToPoint(ref, btn.center.x, btn.center.y);
    }
    if (self.currentTouchPoint.x != kViewDefaultPoint.x
        && self.currentTouchPoint.y != kViewDefaultPoint.y) {
        CGContextAddLineToPoint(ref, self.currentTouchPoint.x, self.currentTouchPoint.y);
    }
    CGContextSetLineJoin(ref, kCGLineJoinRound);
    CGContextSetLineWidth(ref, kViewLineWidth);
    [kViewLineColor setStroke];
    CGContextStrokePath(ref);
}


#pragma mark - 触摸事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch * touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    UIButton * touchButton = [self containsButtonWithPoint:touchPoint];
    if (touchButton) {
        touchButton.selected = YES;
        [self.selectedButtons addObject:touchButton];
        self.currentTouchPoint = touchPoint;
        
        if ([self.delegate respondsToSelector:@selector(lockViewWillBeginDrow:)]) {
            [self.delegate lockViewWillBeginDrow:self];
        }
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch * touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    
    if (!CGRectContainsPoint(self.bounds, touchPoint)) return;
    
    UIButton * touchButton = [self containsButtonWithPoint:touchPoint];
    if (touchButton && ![self.selectedButtons containsObject:touchButton]) {
        touchButton.selected = YES;
        [self.selectedButtons addObject:touchButton];
    }
    
    if (self.selectedButtons.count < 1) return;
    self.currentTouchPoint = touchPoint;
    [self setNeedsDisplay];
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if (self.selectedButtons.count < 1) return;
    
    if ([self.delegate respondsToSelector:@selector(lockView:didEndDrawWithPassCode:)]) {
        NSMutableString * passCode = [[NSMutableString alloc] init];
        for (UIButton * button in self.selectedButtons) {
            [passCode appendString:[NSString stringWithFormat:@"%ld,", button.tag]];
        }
        [self.delegate lockView:self didEndDrawWithPassCode:passCode];
    }
    
    [self resetSelectedButtons];
    [self setNeedsDisplay];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self resetSelectedButtons];
    [self setNeedsDisplay];
}

- (void)resetSelectedButtons {
    for (UIButton * button in self.selectedButtons) {
        button.selected = NO;
    }
    
    [self.selectedButtons removeAllObjects];
    self.currentTouchPoint = kViewDefaultPoint;
}

#pragma mark -
- (UIButton *)containsButtonWithPoint:(CGPoint)point {
    for (UIButton * button in self.buttons) {
        if (CGRectContainsPoint(button.frame, point)) return button;
    }
    return nil;
}

#pragma mark - 懒加载
- (NSArray *)buttons {
    
    if (_buttons == nil) {
        NSMutableArray * buttons = [[NSMutableArray alloc] init];
        for (int i = 0; i < kViewNumberOfNodes; i++) {
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            [self addSubview:button];
            [buttons addObject:button];
            [button setBackgroundImage:[UIImage imageNamed:kViewNodeImageNameNormal] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:kViewNodeImageNameSelected] forState:UIControlStateSelected];
            button.userInteractionEnabled = NO;
            button.tag = i;
            
        }
        _buttons = buttons;
    }
    return _buttons;
}

- (NSMutableArray *)selectedButtons {
    
    if (_selectedButtons == nil) {
        _selectedButtons = [[NSMutableArray alloc] init];
    }
    return _selectedButtons;
}

@end
