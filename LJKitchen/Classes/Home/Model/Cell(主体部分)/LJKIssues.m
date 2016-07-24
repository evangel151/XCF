//
//  LJKIssues.m
//  LJKitchen
//
//  Created by  a on 16/6/17.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKIssues.h"
#import "LJKItems.h"
@implementation LJKIssues

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"items" : [LJKItems class]};
}
@end
