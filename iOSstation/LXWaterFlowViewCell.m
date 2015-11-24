//
//  LXWaterFlowViewCell.m
//  iOSstation
//
//  Created by 张彦东 on 15/11/24.
//  Copyright © 2015年 lx. All rights reserved.
//

#import "LXWaterFlowViewCell.h"
#import "LXWaterFlowViewCell.h"
#import "HMWaterflowView.h"
#import "UIImageView+WebCache.h"
#import "LXWaterFlowViewModel.h"

@interface LXWaterFlowViewCell ()

@property (nonatomic, weak) UIImageView * imageView;

@end

@implementation LXWaterFlowViewCell

+ (instancetype)cellWithWaterFlowView:(HMWaterflowView *)waterFlowView {
    
    static NSString *ID = @"Cell";
    LXWaterFlowViewCell *cell = [waterFlowView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[LXWaterFlowViewCell alloc] init];
        cell.identifier = ID;
    }
    return cell;
}

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        [self addSubview:imageView];
        self.imageView = imageView;
    }
    return self;
}

- (void)setDataModel:(LXWaterFlowViewModel *)dataModel {
    
    _dataModel = dataModel;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:dataModel.imageUrlStr]];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.frame = self.bounds;
}

@end
