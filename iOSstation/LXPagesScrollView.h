//
//  LXPagesScrollView.h
//  iOSstation
//
//  Created by 张彦东 on 15/11/24.
//  Copyright © 2015年 lx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LXPagesScrollView;

@protocol LXPagesScrollViewDelegate <NSObject>

@optional

- (void)pagesScrollView:()pagesScrollView pageDidScroll:(NSInteger)index;

@end

@interface LXPagesScrollView : UIScrollView

@property (nonatomic, assign) NSInteger pageCount;

@property (nonatomic, assign) NSInteger currentPageIndex;

@property (nonatomic, weak) id<LXPagesScrollViewDelegate> pageDelegate;

@end
