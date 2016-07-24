//
//  LJKRecipeIngredient.m
//  LJKitchen
//
//  Created by  a on 16/6/20.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKRecipeIngredient.h"

@implementation LJKRecipeIngredient

// 解档 / 归档
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_name      forKey:@"name"];
    [aCoder encodeObject:_amount    forKey:@"amount"];
    [aCoder encodeInteger:_state    forKey:@"state"];
    [aCoder encodeFloat:_cellHeight forKey:@"cellHeight"];
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.name            = [decoder decodeObjectForKey:@"name"];
        self.amount          = [decoder decodeObjectForKey:@"amount"];
        self.state           = [decoder decodeIntegerForKey:@"state"];
        self.cellHeight      = [decoder decodeFloatForKey:@"cellHeight"];
    }
    return self;
}


- (CGFloat)cellHeight {
    CGFloat nameHeight = [self.name boundingRectWithSize:CGSizeMake(SCREEN_WIDTH * 0.5 - 40, MAXFLOAT)
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]}
                                                 context:nil].size.height;
    
    CGFloat amountHeight = [self.amount boundingRectWithSize:CGSizeMake(SCREEN_WIDTH * 0.5 - 40, MAXFLOAT)
                                                     options:NSStringDrawingUsesLineFragmentOrigin
                                                  attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]}
                                                     context:nil].size.height;
    
    _cellHeight = (nameHeight > amountHeight) ? nameHeight : amountHeight;
    _cellHeight += 30;
    
    return _cellHeight;
}
@end
