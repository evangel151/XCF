//
//  LJKRecipeIngredientCell.h
//  LJKitchen
//
//  Created by  a on 16/7/8.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  菜谱用料 (V)

#import <UIKit/UIKit.h>
@class LJKRecipeIngredient;
@interface LJKRecipeIngredientCell : UITableViewCell

@property (nonatomic, strong) LJKRecipeIngredient *ingredient;
@property (nonatomic, copy) void (^cellDidClickedBlock)(); // cell被点击的回调
@end
