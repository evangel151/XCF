//
//  LJKRecipeInstruction.m
//  LJKitchen
//
//  Created by  a on 16/6/20.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKRecipeInstruction.h"

@implementation LJKRecipeInstruction
- (CGFloat)cellHeight {
    
    // 描述文字 高度 
    CGFloat descHeight = [self.text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - LJKRecipeCellMarginTitle * 4, MAXFLOAT)
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]}
                                                 context:nil].size.height;
    
    
    CGFloat imageH = (SCREEN_WIDTH - 100) * 0.82;
    CGFloat margin = 10;
    if (self.url.length) { // 如果有词谱配图
        _cellHeight = imageH + descHeight + LJKRecipeCellMarginTitle * 3 + margin;
    } else { // 没有菜谱配图
        _cellHeight = descHeight + LJKRecipeCellMarginTitle * 2 + margin;
    }
    
    return _cellHeight;
}

@end
