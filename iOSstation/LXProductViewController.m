//
//  LXProductViewController.m
//  iOSstation
//
//  Created by 张彦东 on 15/11/19.
//  Copyright © 2015年 lx. All rights reserved.
//

#import "LXProductViewController.h"
#import "LXTagsScrollView.h"
#import "LXPagesScrollView.h"

@interface LXProductViewController () <LXTagsScrollViewDelegate, LXPagesScrollViewDelegate>

@property (weak, nonatomic) IBOutlet LXTagsScrollView *tagsScrollView;

@property (weak, nonatomic) IBOutlet LXPagesScrollView *pagesScrollView;

@end

@implementation LXProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.pagesScrollView layoutIfNeeded];
    [self.tagsScrollView layoutIfNeeded];
    
    NSArray * tagArray = @[@"推荐", @"营养快线", @"哇哈哈", @"七喜", @"可口可乐", @"美年达", @"五个字以上的饮料", @"东方树叶", @"..."];
    
    self.tagsScrollView.tagDelegate = self;
    self.tagsScrollView.tags = tagArray;
    
    self.pagesScrollView.pageDelegate = self;
    self.pagesScrollView.pageCount = tagArray.count;
}

#pragma mark - LXTagsScrollViewDelegate
- (void)tagsScrollView:(LXTagsScrollView *)tagsScrollView tagDidSelected:(NSInteger)selectedIndex {
    
    self.pagesScrollView.currentPageIndex = selectedIndex;
}

#pragma mark - LXPagesScrollViewDelegate
- (void)pagesScrollView:(id)pagesScrollView pageDidScroll:(NSInteger)index {
    
    self.tagsScrollView.currentTagIndex = index;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

@end
