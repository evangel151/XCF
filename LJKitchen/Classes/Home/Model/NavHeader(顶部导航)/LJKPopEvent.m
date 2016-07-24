//
//  LJKPopEvent.m
//  LJKitchen
//
//  Created by  a on 16/6/15.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKPopEvent.h"

@implementation LJKPopEvent

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID" : @"id",
             @"thumbnail_280" : @"dishes.dishes[0].thumbnail_280"};
}

@end
