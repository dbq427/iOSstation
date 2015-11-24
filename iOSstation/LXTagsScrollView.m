//
//  LXTagsScrollView.m
//  iOSstation
//
//  Created by 张彦东 on 15/11/24.
//  Copyright © 2015年 lx. All rights reserved.
//

#define kLXTagsLineViewHeight 2

#define kLXTagsButtonMargin 15

#define kLXTagsFont [UIFont systemFontOfSize:15]

#import "LXTagsScrollView.h"

@interface LXTagsScrollView ()

@property (nonatomic, weak) UIView * lineView;

@property (nonatomic, weak) UIButton * currentSelectedButton;

@property (nonatomic, strong) NSArray * buttons;

@end

@implementation LXTagsScrollView

#pragma mark - constructed
+ (instancetype)tagsScrollView {
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self setupScrollView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        [self setupScrollView];
    }
    return self;
}

- (void)setupScrollView {
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.bounces = NO;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect lineF = self.lineView.frame;
    lineF.origin.y = self.frame.size.height - kLXTagsLineViewHeight * 2;
    self.lineView.frame = lineF;
}

#pragma mark - lazy load
- (UIView *)lineView {
    
    if (_lineView == nil) {
        UIView * lineView = [[UIView alloc] init];
        [self addSubview:lineView];
        _lineView = lineView;
        _lineView.backgroundColor = [UIColor redColor];
    }
    return _lineView;
}

- (NSArray *)buttons {
    
    if (_buttons == nil) {
        _buttons = [[NSArray alloc] init];
    }
    return _buttons;
}


#pragma mark - setter
- (void)setTags:(NSArray *)tags {
    _tags = tags;
    
    CGFloat contentWidth = kLXTagsButtonMargin;
    
    // all buttons
    NSMutableArray * buttons = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < tags.count; i++) {
        
        NSString * tag = tags[i];
        
        CGFloat tagWidth = [self tagWidth:tag];
        
        UIButton * tagButton = [self createTagButtonWithTitle:tag x:contentWidth width:tagWidth index:i];
        
        [buttons addObject:tagButton];
        
        contentWidth += tagWidth + kLXTagsButtonMargin;
        
    }
    
    self.buttons = buttons;
    
    self.currentSelectedButton = buttons[0];
    
    self.contentSize = CGSizeMake(contentWidth, 0);
}

- (UIButton *)createTagButtonWithTitle:(NSString *)title x:(CGFloat)x width:(CGFloat)width index:(int)index {
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:button];
    button.frame = CGRectMake(x, 0, width, 30);
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(tagButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = kLXTagsFont;
    button.tag = index;
    
    return button;
}

- (void)setCurrentSelectedButton:(UIButton *)currentSelectedButton {
    
    _currentSelectedButton.selected = NO;
    
    currentSelectedButton.selected = YES;
    _currentSelectedButton = currentSelectedButton;
    
    // lineView
    [UIView animateWithDuration:0.3 animations:^{
        
        // 根据currentButton的位置 修改contentOffSet
        if (self.contentOffset.x > currentSelectedButton.frame.origin.x - kLXTagsButtonMargin) {
            
            CGFloat contentOffsetX = currentSelectedButton == self.buttons.firstObject ? 0 : currentSelectedButton.frame.origin.x - 70;
            self.contentOffset = CGPointMake(contentOffsetX, self.contentOffset.y);
            
        } else if ((self.contentOffset.x + self.frame.size.width) < CGRectGetMaxX(currentSelectedButton.frame) + kLXTagsButtonMargin) {
            
            CGFloat contentOffsetXIns = currentSelectedButton == self.buttons.lastObject ? kLXTagsButtonMargin : 70;
            self.contentOffset = CGPointMake(CGRectGetMaxX(currentSelectedButton.frame) - self.frame.size.width + contentOffsetXIns, self.contentOffset.y);
        }
        
        [self.lineView setFrame:CGRectMake(currentSelectedButton.frame.origin.x, self.lineView.frame.origin.y, currentSelectedButton.frame.size.width, kLXTagsLineViewHeight)];
    }];
}

- (void)setCurrentTagIndex:(NSInteger)currentTagIndex {
    
    _currentTagIndex = currentTagIndex;
    
    self.currentSelectedButton = self.buttons[currentTagIndex];
}


/**
 *  tag Width
 */
- (CGFloat)tagWidth:(NSString *)tagStr {
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    params[NSFontAttributeName] = kLXTagsFont;

    CGSize tagSize = [tagStr boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, self.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:params context:nil].size;
    
    return tagSize.width;
}

#pragma mark - tag click
- (void)tagButtonClick:(UIButton *)button {
    
    if (button.isSelected) {
        if ([self.tagDelegate respondsToSelector:@selector(tagsScrollViewSelectedTagDidClick:)]) {
            [self.tagDelegate tagsScrollViewSelectedTagDidClick:self];
        }
        return;
    }
    
    self.currentSelectedButton = button;
    
    if ([self.tagDelegate respondsToSelector:@selector(tagsScrollView:tagDidSelected:)]) {
        [self.tagDelegate tagsScrollView:self tagDidSelected:button.tag];
    }
}


@end
