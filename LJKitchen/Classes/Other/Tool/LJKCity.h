//
//  LJKCity.h
//  LJKitchen
//
//  Created by  a on 16/6/30.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJKCity : NSObject

@property (nonatomic, copy) NSString *city_name;
@property (nonatomic, copy) NSString *city_id;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)cityWithDict:(NSDictionary *)dict;

@end
