//
//  LXHTTPRequest.m
//  iOSstation
//
//  Created by 张彦东 on 15/11/23.
//  Copyright © 2015年 lx. All rights reserved.
//

#import "LXHTTPRequest.h"
#import "AFNetworking.h"

@implementation LXHTTPRequest

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
              fail:(void (^)(NSError *error))fail {
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
    
    // get
    if (method == nil || [[method uppercaseString] isEqualToString:@"GET"]) {
        
        [manager GET:requestURL
          parameters:parmas
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 
                 if (success)
                 {
                     success(responseObject);
                 }
             }
             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 
                 if (fail) {
                     fail(error);
                 }
             }];
        
        
        // 5.post请求不带文件 和post带文件
    }else if ([[method uppercaseString] isEqualToString:@"POST"]) {
   
        if (!files) {
   
            [manager POST:requestURL
               parameters:parmas
                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  
                      if (success) {
                          success(responseObject);
                      }
                      
                  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    
                      if (fail) {
                          fail(error);
                      }
                  }];
            
        } else {

            [manager POST:requestURL
               parameters:parmas constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                   
                   
                   for (id key in files) {
                       
                       id value = files[key];

                       [formData appendPartWithFileData:value
                                                   name:key
                                               fileName:@"header.png"
                                               mimeType:@"image/png"];
                   }
                   
               } success:^(AFHTTPRequestOperation *operation, id responseObject) {
                   
                   if (success) {
                       success(responseObject);
                   }
                   
               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                   
                   if (fail) {
                       fail(error);
                   }
               }];
        }
    }
}

@end
