//
//  LJKDiggUsers.m
//  LJKitchen
//
//  Created by  a on 16/7/5.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKDiggUsers.h"
#import "LJKAuthor.h"


@implementation LJKDiggUsers
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"users" : [LJKAuthor class]};
}
@end
