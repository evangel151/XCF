//
//  LJKNavContent.m
//  LJKitchen
//
//  Created by  a on 16/6/15.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKNavContent.h"
#import "LJKNav.h"

@implementation LJKNavContent
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"navs" : [LJKNav class]};
}

@end
