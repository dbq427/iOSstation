//
//  LXCollectionItemModel.h
//  iOSstation
//
//  Created by 张彦东 on 15/11/23.
//  Copyright © 2015年 lx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LXCollectionItemModel : NSObject

@property (nonatomic, copy) NSString * imageUrlStr;

@property (nonatomic, assign) CGFloat imageWidth;

@property (nonatomic, assign) CGFloat imageHeight;

+ (instancetype)collectionItemModelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
