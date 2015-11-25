//
//  LXHotCellModel.m
//  iOSstation
//
//  Created by 张彦东 on 15/11/25.
//  Copyright © 2015年 lx. All rights reserved.
//

#import "LXHotCellModel.h"

@implementation LXHotCellModel

+ (instancetype)hotCellModelWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict {
    
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (NSString *)description {
    
    return [NSString stringWithFormat:@"title:%@,, imageUrl:%@", _title, _imageUrlStr];
}


@end
