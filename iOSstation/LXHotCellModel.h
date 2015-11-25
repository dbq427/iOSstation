//
//  LXHotCellModel.h
//  iOSstation
//
//  Created by 张彦东 on 15/11/25.
//  Copyright © 2015年 lx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXHotCellModel : NSObject

@property (nonatomic, copy) NSString * imageUrlStr;

@property (nonatomic, copy) NSString * title;

+ (instancetype)hotCellModelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
