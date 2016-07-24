//
//  LJKForum.m
//  LJKitchen
//
//  Created by  a on 16/6/22.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKForum.h"
#import "LJKAuthor.h"
@implementation LJKForum

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"latest_authors" : [LJKAuthor class]};
}
@end
