//
//  LJKPopEvents.m
//  LJKitchen
//
//  Created by  a on 16/6/16.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKPopEvents.h"
#import "LJKPopEvent.h"

@implementation LJKPopEvents
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"events" : [LJKPopEvent class]};
}
@end
