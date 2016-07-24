//
//  LJKCartSettlementView.h
//  LJKitchen
//
//  Created by  a on 16/7/11.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  购物车 - 底部结算 View


// 购物车编辑类型
typedef NS_ENUM(NSInteger, LJKCartEditStyle) {
    LJKCartEditStyleSettlement, // 结算
    LJKCartEditStyleDelete      // 删除
};


#import <UIKit/UIKit.h>
@class LJKCartItem;
@interface LJKCartSettlementView : UIView

@property (nonatomic, assign) LJKCartEditStyle style;
@property (nonatomic, assign) LJKCartItemState state;

/** 所有商品数据(数组) */
@property (nonatomic, strong) NSArray<LJKCartItem *> *totalItemsArray;
/** 选中全部商品回调 */
@property (nonatomic, copy) void (^selectedAllItemBlock)(LJKCartItemState);
/** 结算\删除回调 */
@property (nonatomic, copy) void (^settleOrDeleteBlock)();       
@end
