//
//  LJKLocation.m
//  LJKitchen
//
//  Created by  a on 16/6/30.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKLocation.h"
#import "LJKCity.h"
@implementation LJKLocation

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        _province_id             = dict[@"province_id"];
        _province_name           = dict[@"province_name"];
        NSArray *citiesArray     = [NSMutableArray arrayWithArray:dict[@"cities"]];
        NSMutableArray *newArray = [NSMutableArray array];
        
        for (NSDictionary *dict in citiesArray) {
            LJKCity *city = [LJKCity cityWithDict:dict];
            [newArray addObject:city];
        }
        _cities = newArray;
    }
    return self;
}

+ (instancetype)locationWithDict:(NSDictionary *)dict {
    return [[LJKLocation alloc] initWithDict:dict];
}
@end
