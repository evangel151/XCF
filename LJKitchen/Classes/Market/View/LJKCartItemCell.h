//
//  LJKCartItemCell.h
//  LJKitchen
//
//  Created by  a on 16/7/12.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  购物车 - 商品cell 

#import <UIKit/UIKit.h>

@class LJKCartItem;

@interface LJKCartItemCell : UITableViewCell

@property (nonatomic, strong) LJKCartItem *cartItem;

/** cell样式(购物车、订单) */
@property (nonatomic, assign) LJKCartViewChildControlStyle style;

/** 选中商品回调 */
@property (nonatomic, copy) void (^selectedItemBlock)(NSUInteger);      
/** 修改商品数量回调 */
@property (nonatomic, copy) void (^itemNumberChangeBlock)(NSUInteger);

@end
