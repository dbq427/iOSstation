//
//  LXBannerView.m
//  iOSstation
//
//  Created by 张彦东 on 15/11/19.
//  Copyright © 2015年 lx. All rights reserved.
//

#define LXImageScale 0.5
#define LXImageScrollTimeInterval 2

#import "LXBannerView.h"
#import "UIButton+WebCache.h"

@interface LXBannerView () <UIScrollViewDelegate>

@property (nonatomic, weak) UIPageControl * pageControl;

@property (nonatomic, weak) UIScrollView * scrollView;

@property (nonatomic, weak) UIButton * preImageButton;
@property (nonatomic, weak) UIButton * currentImageButton;
@property (nonatomic, weak) UIButton * nextImageButton;

@property (nonatomic, assign) NSInteger currentImageIndex;

@end

@implementation LXBannerView
{
    NSTimer * _timer;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    
    self.frame = CGRectMake(0, 0, newSuperview.bounds.size.width, newSuperview.bounds.size.width * LXImageScale);
    self.scrollView.frame = self.bounds;
    self.pageControl.center = CGPointMake(self.center.x, CGRectGetMaxY(self.scrollView.frame) - 20);
}


- (void)setImageUrls:(NSArray *)imageUrls {
    
    _imageUrls = imageUrls;
    
    self.scrollView.contentSize = CGSizeMake(self.frame.size.width * 3, 0);
    self.pageControl.numberOfPages = imageUrls.count;
    
    CGFloat vWidth = self.scrollView.frame.size.width;
    CGFloat vHeight = self.scrollView.frame.size.height;
    self.preImageButton.frame = CGRectMake(0, 0, vWidth, vHeight);
    self.currentImageButton.frame = CGRectMake(vWidth, 0, vWidth, vHeight);
    self.nextImageButton.frame = CGRectMake(vWidth * 2, 0, vWidth, vHeight);
    
    [self loadImageButtons];
    
    [self startTimer];
}

- (void)startTimer {
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:LXImageScrollTimeInterval target:self selector:@selector(scrollImage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer {
    
    [_timer invalidate];
    _timer = nil;
}

- (void)scrollImage {
    
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width * 2, 0) animated:YES];
//    [self scrollViewDidEndDecelerating:self.scrollView];
    [self scrollViewDidEndScrollingAnimation:self.scrollView];
}

- (void)loadImageButtons {
    
    NSInteger preIndex = self.currentImageIndex == 0 ? self.imageUrls.count - 1 : self.currentImageIndex - 1;
    [self.preImageButton sd_setBackgroundImageWithURL:self.imageUrls[preIndex] forState:UIControlStateNormal];
    
    [self.currentImageButton sd_setBackgroundImageWithURL:self.imageUrls[self.currentImageIndex] forState:UIControlStateNormal];
    
    NSInteger nextIndex = self.currentImageIndex == self.imageUrls.count - 1 ? 0 : self.currentImageIndex + 1;
    [self.nextImageButton sd_setBackgroundImageWithURL:self.imageUrls[nextIndex] forState:UIControlStateNormal];
    
    [self.scrollView setContentOffset:CGPointMake(self.frame.size.width, 0)];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [self stopTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    [self startTimer];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    int cosIndex = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    if (cosIndex == 1) return;
    
    if (cosIndex > 1) {
        self.currentImageIndex = self.currentImageIndex + 1 == self.imageUrls.count ? 0 : self.currentImageIndex + 1;
        self.pageControl.currentPage = self.pageControl.currentPage == self.pageControl.numberOfPages - 1 ? 0 : self.pageControl.currentPage + 1;
        
    } else {
        self.currentImageIndex = self.currentImageIndex - 1 < 0 ? self.imageUrls.count - 1 : self.currentImageIndex - 1;
        self.pageControl.currentPage = self.pageControl.currentPage == 0 ? self.pageControl.numberOfPages - 1 : self.pageControl.currentPage - 1;
    }
    
    [self loadImageButtons];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

#pragma mark - lazy load
- (UIScrollView *)scrollView {
    
    if (_scrollView == nil) {
        
        UIScrollView * scrollView = [[UIScrollView alloc] init];
        [self addSubview:scrollView];
        _scrollView = scrollView;
        scrollView.delegate = self;
        scrollView.pagingEnabled = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    
    if (_pageControl == nil) {
        
        UIPageControl * pageControl = [[UIPageControl alloc] init];
        [self addSubview:pageControl];
        _pageControl = pageControl;
        pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    }
    return _pageControl;
    
}

- (UIButton *)preImageButton {
    
    if (_preImageButton == nil) {
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.scrollView addSubview:button];
        _preImageButton = button;
        [button addTarget:self action:@selector(buttonDidClick:) forControlEvents:UIControlEventTouchUpInside];
        button.adjustsImageWhenHighlighted = NO;
    }
    return _preImageButton;
}

- (UIButton *)currentImageButton {
    
    if (_currentImageButton == nil) {
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.scrollView addSubview:button];
        _currentImageButton = button;
        [button addTarget:self action:@selector(buttonDidClick:) forControlEvents:UIControlEventTouchUpInside];
        button.adjustsImageWhenHighlighted = NO;
    }
    return _currentImageButton;
}

- (UIButton *)nextImageButton {
    
    if (_nextImageButton == nil) {
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.scrollView addSubview:button];
        _nextImageButton = button;
        [button addTarget:self action:@selector(buttonDidClick:) forControlEvents:UIControlEventTouchUpInside];
        button.adjustsImageWhenHighlighted = NO;
    }
    return _nextImageButton;
}

- (void)setupImageButtonWithProperty:(UIButton *)proButton  {
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.scrollView addSubview:button];
    proButton = button;
    [button addTarget:self action:@selector(buttonDidClick:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - button click
- (void)buttonDidClick:(UIButton *)button {
    
    NSLog(@"button did click: index = %ld", self.currentImageIndex);
}


- (void)dealloc {
    
    if (_timer) {
        [_timer invalidate];
    }
}

@end
