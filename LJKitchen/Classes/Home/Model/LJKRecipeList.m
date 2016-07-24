//
//  LJKRecipeList.m
//  LJKitchen
//
//  Created by  a on 16/7/5.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKRecipeList.h"
#import "LJKAuthor.h"
#import "LJKRecipe.h"

@implementation LJKRecipeList

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID" : @"id"};
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"recipes" : [NSString class],
             @"sample_recipes" : [LJKRecipe class]};
}

- (CGFloat)headerheight {
    CGFloat nameLabelHeight = 25;
    CGFloat collectButtonHeight = 30;
    
    CGFloat totalMargin = LJKAuthorIcon2CellTop * 7;
    CGFloat unchangedHeaderHeight = nameLabelHeight + collectButtonHeight + totalMargin;
    
    CGFloat titleHeight = [self.name boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 2 * LJKAuthorIcon2CellLeft, MAXFLOAT)
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17]}
                                                  context:nil].size.height;
    
    if (self.desc.length) { // 存在菜谱简介
        CGFloat descHeight = [self.desc boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - LJKAuthorIcon2CellLeft * 2, MAXFLOAT)
                                                     options:NSStringDrawingUsesLineFragmentOrigin
                                                  attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]}
                                                     context:nil].size.height;
        
        _headerheight = unchangedHeaderHeight + titleHeight + descHeight + 20;
    } else {
        _headerheight = unchangedHeaderHeight + titleHeight + 20;
    }
    
    return _headerheight;
}

@end
