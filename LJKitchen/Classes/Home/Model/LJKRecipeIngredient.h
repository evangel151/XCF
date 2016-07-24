//
//  LJKRecipeIngredient.h
//  LJKitchen
//
//  Created by  a on 16/6/20.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
// 菜谱用料 

#import <Foundation/Foundation.h>

// useless 
typedef NS_ENUM(NSInteger, LJKIngredientState) {
    LJKIngredientStateNone,      // 未购买
    LJKIngredientStatePurchased  // 已购买
};

@interface LJKRecipeIngredient : NSObject <NSCoding>

/** 名称 */
@property (nonatomic, copy) NSString *name;
/** 用量 */
@property (nonatomic, copy) NSString *amount;
/** 用料cellHeight */
@property (nonatomic, assign) CGFloat cellHeight;
/** 菜篮子内 - 原料 - 购买状态 */
@property (nonatomic, assign) LJKIngredientState state;


///** 未知 */
//@property (nonatomic, copy) NSString *cat;
@end
