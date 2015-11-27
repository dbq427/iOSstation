//
//  LXHTTPRequest.h
//  iOSstation
//
//  Created by 张彦东 on 15/11/23.
//  Copyright © 2015年 lx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXHTTPRequest : NSObject

/**
 *  send request
 *
 *  @param method    GET or POST , default is GET
 */
+ (void)requestURL:(NSString *)requestURL
        httpMethod:(NSString *)method
            params:(NSMutableDictionary *)parmas
              file:(NSDictionary *)files
           success:(void (^)(id data))success
              fail:(void (^)(NSError *error))fail;

@end
