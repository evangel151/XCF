//
//  LJKContent.m
//  LJKitchen
//
//  Created by  a on 16/6/17.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKContent.h"
#import "LJKIssues.h"

@implementation LJKContent

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"issues" : [LJKIssues class]};
}
@end
