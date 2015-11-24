//
//  LXTagsScrollView.h
//  iOSstation
//
//  Created by 张彦东 on 15/11/24.
//  Copyright © 2015年 lx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LXTagsScrollView;

@protocol LXTagsScrollViewDelegate <NSObject>

@optional
- (void)tagsScrollView:(LXTagsScrollView *)tagsScrollView tagDidSelected:(NSInteger)selectedIndex;

- (void)tagsScrollViewSelectedTagDidClick:(LXTagsScrollView *)tagsScrollView;

@end

@interface LXTagsScrollView : UIScrollView

@property (nonatomic, strong) NSArray * tags;

@property (nonatomic, assign) NSInteger currentTagIndex;

@property (nonatomic, weak) id<LXTagsScrollViewDelegate> tagDelegate;

+ (instancetype)tagsScrollView;

@end
