//
//  LJKReviewPhoto.m
//  LJKitchen
//
//  Created by  a on 16/7/5.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKReviewPhoto.h"

@implementation LJKReviewPhoto

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_url forKey:@"url"];
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.url = [decoder decodeObjectForKey:@"url"];
    }
    return self;
}
@end
