//
//  LJKRecipeListHeader.h
//  LJKitchen
//
//  Created by  a on 16/7/5.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  菜单(专辑) - header (V)

#import <UIKit/UIKit.h>

// 菜单header 回调枚举
typedef NS_ENUM(NSInteger, recipeHeaderAction) {
    RecipeHeaderActionAuthorName, // 姓名
    RecipeHeaderActionCollected   // 收藏
};

@class LJKRecipeList,LJKRecipe;

@interface LJKRecipeListHeader : UIView
/** header点击事件 */
@property (nonatomic, copy) void (^recipeHeaderActionBlock)();

/** 模型:菜单 */
@property (nonatomic, strong) LJKRecipeList *recipeList;


@end
