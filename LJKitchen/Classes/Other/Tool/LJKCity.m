//
//  LJKCity.m
//  LJKitchen
//
//  Created by  a on 16/6/30.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKCity.h"

@implementation LJKCity

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}


+ (instancetype)cityWithDict:(NSDictionary *)dict {
    return [[LJKCity alloc] initWithDict:dict];
}

@end
