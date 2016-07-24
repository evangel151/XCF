//
//  LJKRecipe.m
//  LJKitchen
//
//  Created by  a on 16/6/20.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKRecipe.h"
#import "LJKRecipeStats.h"
#import "LJKRecipeIngredient.h"
#import "LJKRecipeInstruction.h"
#import "LJKAuthor.h"

@implementation LJKRecipe
// 解档 / 归档
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_name          forKey:@"name"];
    [aCoder encodeObject:_ingredient    forKey:@"ingredient"];
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.name           = [decoder decodeObjectForKey:@"name"];
        self.ingredient     = [decoder decodeObjectForKey:@"ingredient"];
    }
    return self;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID" : @"id"};
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"instruction" : [LJKRecipeInstruction class],
             @"ingredient"  : [LJKRecipeIngredient class],
             @"dish_author" : [LJKAuthor class]};
}


- (CGFloat)headerHeight {
    
    // 不变的高度 + 间距 总和
    // 顺序: 图片H + (图片2菜名) + (菜名2独家) + 独家 + (独家2分数) + 分数 + (分数2分割线) + 作者头像部分 + 姓名栏 + 创建时间 + 收藏按钮 + 底部间距……
    // SCREEN_WIDTH * 0.6 + 20 + 10 + 20 + 10 + 20 + 10 + 1 + 80 + 30 + 30 + 60 + 20;
    CGFloat unChangedHeightSum = SCREEN_WIDTH * 0.6 + 311;
    
    CGFloat recipeNameHeight =
    [self.name boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - LJKAuthorIcon2CellLeft * 2, MAXFLOAT)
                            options:NSStringDrawingUsesLineFragmentOrigin
                         attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20]}
                            context:nil].size.height;
    
    if (self.desc.length) {
        CGFloat recipeDescHeight =
        [self.desc boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - LJKAuthorIcon2CellLeft * 2, MAXFLOAT)
                                options:NSStringDrawingUsesLineFragmentOrigin
                             attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]}
                                context:nil].size.height;
        _headerHeight = unChangedHeightSum + recipeNameHeight + recipeDescHeight + 10;
    } else {
        _headerHeight = unChangedHeightSum + recipeNameHeight + 10;
    }
    return _headerHeight;
}

- (CGFloat)tipsHeight {
    
    CGFloat margin = LJKAuthorIcon2CellTop * 2;
    
    CGFloat descHeight = [self.tips boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - LJKAuthorIcon2CellLeft * 2, MAXFLOAT)
                                                options:NSStringDrawingUsesLineFragmentOrigin
                                             attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]}
                                                context:nil].size.height;
    _tipsHeight = margin + descHeight;
    
    return _tipsHeight;
}

@end
