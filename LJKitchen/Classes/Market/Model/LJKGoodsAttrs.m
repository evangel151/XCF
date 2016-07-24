//
//  LJKGoodsAttrs.m
//  LJKitchen
//
//  Created by  a on 16/7/11.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKGoodsAttrs.h"

@implementation LJKGoodsAttrs


- (CGFloat)cellHeight {
    NSString *string = [NSString stringWithFormat:@"%@：%@", self.name, self.value];
    _cellHeight = [string boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 30, MAXFLOAT)
                                       options:NSStringDrawingUsesLineFragmentOrigin
                                    attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]}
                                       context:nil].size.height;
    return _cellHeight;
}
@end
