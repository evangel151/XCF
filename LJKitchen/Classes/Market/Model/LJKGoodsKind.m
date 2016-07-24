//
//  LJKGoodsKind.m
//  LJKitchen
//
//  Created by  a on 16/7/11.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKGoodsKind.h"

@implementation LJKGoodsKind
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeInteger:_original_price       forKey:@"original_price"];
    [aCoder encodeDouble:_price                 forKey:@"price"];
    [aCoder encodeObject:_name                  forKey:@"name"];
    [aCoder encodeInteger:_stock                forKey:@"stock"];
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.original_price         = [decoder decodeIntegerForKey:@"original_price"];
        self.price                  = [decoder decodeDoubleForKey:@"price"];
        self.name                   = [decoder decodeObjectForKey:@"name"];
        self.stock                  = [decoder decodeIntegerForKey:@"stock"];
    }
    return self;
}
@end
