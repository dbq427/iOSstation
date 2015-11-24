//
//  LXWaterFlowViewCell.h
//  iOSstation
//
//  Created by 张彦东 on 15/11/24.
//  Copyright © 2015年 lx. All rights reserved.
//

#import "HMWaterflowViewCell.h"

@class HMWaterflowView, LXWaterFlowViewModel;

@interface LXWaterFlowViewCell : HMWaterflowViewCell

@property (nonatomic, strong) LXWaterFlowViewModel *dataModel;

+ (instancetype)cellWithWaterFlowView:(HMWaterflowView *)waterFlowView;

@end
