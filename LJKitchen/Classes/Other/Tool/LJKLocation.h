//
//  LJKLocation.h
//  LJKitchen
//
//  Created by  a on 16/6/30.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LJKCity;

@interface LJKLocation : NSObject

@property (nonatomic, copy) NSString *province_name;
@property (nonatomic, copy) NSString *province_id;
@property (nonatomic, strong) NSArray <LJKCity *> *cities;


- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)locationWithDict:(NSDictionary *)dict;

@end
