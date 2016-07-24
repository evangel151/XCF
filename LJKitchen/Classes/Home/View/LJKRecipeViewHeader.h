//
//  LJKRecipeViewHeader.h
//  LJKitchen
//
//  Created by  a on 16/7/7.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  具体菜谱制作 header


// 顶部视图 点击回调
typedef NS_ENUM(NSInteger, HeaderDidClickedAction) {
    RecipeHeaderActionAuthorIconClicked        = 11,
    RecipeHeaderActionCollectedButtonClicked   = 12,
    RecipeHeaderActionBasketButtonClicked      = 13
};


typedef void (^headerDidClickedBlock)();
#import <UIKit/UIKit.h>

@class LJKRecipe;
@interface LJKRecipeViewHeader : UIView

/** 菜谱header 模型 */
@property (nonatomic, strong) LJKRecipe *recipe;
/** header中事件回调 */
@property (nonatomic, copy) headerDidClickedBlock clickedBlock;

@end
