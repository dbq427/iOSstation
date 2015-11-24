//
//  LXPagesScrollView.m
//  iOSstation
//
//  Created by 张彦东 on 15/11/24.
//  Copyright © 2015年 lx. All rights reserved.
//

#define kLXRadomColor [UIColor colorWithRed:arc4random_uniform(256) / 255.0f green:arc4random_uniform(256) / 255.0f blue:arc4random_uniform(256) / 255.0f alpha:1]

#define kScrollWidth self.frame.size.width

#import "LXPagesScrollView.h"

@interface LXPagesScrollView () <UIScrollViewDelegate>

@property (nonatomic, strong) NSArray * views;

@end

@implementation LXPagesScrollView


#pragma mark - constructor
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        
        self.delegate = self;
        self.currentPageIndex = 0;
        self.showsHorizontalScrollIndicator = NO;
    }
    return self;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger cosIndex = scrollView.contentOffset.x / scrollView.frame.size.width;

    if (cosIndex == self.currentPageIndex) return;

    _currentPageIndex = cosIndex;
    
    if ([self.pageDelegate respondsToSelector:@selector(pagesScrollView:pageDidScroll:)]) {
        [self.pageDelegate pagesScrollView:self pageDidScroll:cosIndex];
    }
    
}

#pragma mark - setter
- (void)setPageCount:(NSInteger)pageCount {
    
    _pageCount = pageCount;
    
    NSLog(@"%@", NSStringFromCGRect(self.frame));
    
    self.contentSize = CGSizeMake(self.frame.size.width * pageCount, 0);
    
    NSMutableArray * viewArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < pageCount; i++) {
     
        UIView * view = [[UIView alloc] init];
        [self addSubview:view];
#warning radom color for each page
        view.backgroundColor = kLXRadomColor;
        [viewArray addObject:view];
    }
    
    self.views = viewArray;
}

- (void)setCurrentPageIndex:(NSInteger)currentPageIndex {
    
    _currentPageIndex = currentPageIndex;
    
    [self setContentOffset:CGPointMake(kScrollWidth * currentPageIndex, 0) animated:YES];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    for (int i = 0; i < self.views.count; i++) {
        UIView * view = self.views[i];
        view.frame = CGRectMake(i * kScrollWidth, 0, kScrollWidth, self.frame.size.height);
    }
}

@end
