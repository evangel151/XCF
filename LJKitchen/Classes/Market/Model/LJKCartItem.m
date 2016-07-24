//
//  LJKCartItem.m
//  LJKitchen
//
//  Created by  a on 16/7/11.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  Done

#import "LJKCartItem.h"
#import "LJKGoods.h"
#import "LJKGoodsKind.h"

@implementation LJKCartItem

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"goods"     : @"commodity.goods",
             @"kind_name" : @"commodity.kind_name",
             @"number"    : @"commodity.number"};
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeInteger:_state      forKey:@"state"];
    [aCoder encodeObject:_goods       forKey:@"goods"];
    [aCoder encodeObject:_kind_name   forKey:@"kind_name"];
    [aCoder encodeInteger:_number     forKey:@"number"];
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.state       = [decoder decodeIntegerForKey:@"state"];
        self.goods       = [decoder decodeObjectForKey:@"goods"];
        self.kind_name   = [decoder decodeObjectForKey:@"kind_name"];
        self.number      = [decoder decodeIntegerForKey:@"number"];
    }
    return self;
}

// 现价
- (double)displayPrice {
    for (LJKGoodsKind *kind in self.goods.kinds) {
        if ([kind.name isEqualToString:self.kind_name]) _displayPrice = kind.price;
    }
    return _displayPrice;
}

// 原价
- (double)displayOriginPrice {
    for (LJKGoodsKind *kind in self.goods.kinds) {
        if ([kind.name isEqualToString:self.kind_name]) _displayOriginPrice = kind.original_price;
    }
    return _displayOriginPrice;
}


@end
