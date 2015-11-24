//
//  LXWaterFlowViewModel.h
//  iOSstation
//
//  Created by 张彦东 on 15/11/24.
//  Copyright © 2015年 lx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXWaterFlowViewModel : NSObject

@property (nonatomic, weak) NSString * imageUrlStr;

@property (nonatomic, assign) float imageWidth;

@property (nonatomic, assign) float imageHeight;

+ (instancetype)waterFlowViewModelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
