//
//  LJKCartItemShopHeader.h
//  LJKitchen
//
//  Created by  a on 16/7/12.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  购物车 - header

// 回调枚举
typedef NS_ENUM(NSUInteger, LJKCartShopState) {
    LJKCartShopStateNone,    // 未选中
    LJKCartShopStateSelected // 全选
};

#import <UIKit/UIKit.h>
@class LJKCartItem;

@interface LJKCartItemShopHeader : UITableViewHeaderFooterView
/** 店铺选中状态 */
@property (nonatomic, assign) LJKCartShopState state;
/** 店铺主体Cell类型 */
@property (nonatomic, assign) LJKCartViewChildControlStyle style;
/** 商品模型 */
@property (nonatomic, strong) LJKCartItem *cartItem;
/** "全选"点击回调 */
@property (nonatomic, copy) void (^selectedShopItemsBlock)(NSUInteger);
/** ShopHeader 点击后回调 */
@property (nonatomic, copy) void (^shopHeaderDidClickedBlock)();

@end
