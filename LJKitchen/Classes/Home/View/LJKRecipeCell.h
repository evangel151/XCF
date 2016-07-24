//
//  LJKRecipeCell.h
//  LJKitchen
//
//  Created by  a on 16/6/19.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
// 首页的主体Cell (V)

#import <UIKit/UIKit.h>
@class LJKItems,LJKRecipe;
@interface LJKRecipeCell : UITableViewCell
/** 通用模板数据 */
@property (nonatomic, strong) LJKItems *item;
/** 菜谱数据 */
@property (nonatomic, strong) LJKRecipe *recipe;

/** 事件block */
@property (nonatomic, copy) void (^authorIconClickedBlock)();
@end
