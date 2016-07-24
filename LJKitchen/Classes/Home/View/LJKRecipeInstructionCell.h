//
//  LJKRecipeInstructionCell.h
//  LJKitchen
//
//  Created by  a on 16/7/8.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  菜谱步骤 (V)

#import <UIKit/UIKit.h>

@class LJKRecipeInstruction;

@interface LJKRecipeInstructionCell : UITableViewCell
/** 菜谱步骤模型 */
@property (nonatomic, strong) LJKRecipeInstruction *instruction;

@end
