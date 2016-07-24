//
//  LJKNetworkTool.h
//  LJKitchen
//
//  Created by  a on 16/6/8.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJKNetworkTool : NSObject
+ (void)afnGet:(NSString *)url
        params:(NSDictionary *)params
       success:(void(^)(id json))success
       failure:(void(^)(NSError *error))failure;

+ (void)afnPost:(NSString *)url
         params:(NSDictionary *)params
        success:(void(^)(id json))success
        failure:(void(^)(NSError *error))failure;
@end
