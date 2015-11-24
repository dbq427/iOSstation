//
//  LXWaterFlowViewModel.m
//  iOSstation
//
//  Created by 张彦东 on 15/11/24.
//  Copyright © 2015年 lx. All rights reserved.
//

#import "LXWaterFlowViewModel.h"

@implementation LXWaterFlowViewModel

+ (instancetype)waterFlowViewModelWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict {
    
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (NSString *)description {
    
    return [NSString stringWithFormat:@"imageWidth:%.2f, imageHeight:%.2f, imageUrl:%@", _imageWidth, _imageHeight, _imageUrlStr];
}

@end
