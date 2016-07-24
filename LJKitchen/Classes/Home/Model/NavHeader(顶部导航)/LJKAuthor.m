//
//  LJKAuthor.m
//  LJKitchen
//
//  Created by  a on 16/6/15.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKAuthor.h"
#import "LJKAuthorDetail.h"
#import "LJKMyInfo.h"

@implementation LJKAuthor
// 解/归档
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_name    forKey:@"name"];
    [aCoder encodeObject:_image   forKey:@"image"];
    [aCoder encodeObject:_photo   forKey:@"photo"];
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.name    = [decoder decodeObjectForKey:@"name"];
        self.image   = [decoder decodeObjectForKey:@"image"];
        self.photo   = [decoder decodeObjectForKey:@"photo"];
    }
    return self;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID" : @"id"};
}

+ (instancetype)me {
    LJKAuthor *me = [[LJKAuthor alloc] init];
    LJKAuthorDetail *meDetail = [LJKMyInfo info];
    me.name = meDetail.name;
    me.image = meDetail.image;
    return me;
}
@end
