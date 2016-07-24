//
//  LJKCartItem.h
//  LJKitchen
//
//  Created by  a on 16/7/11.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  购物车 - 商品信息 (in cart) (M)

#import <Foundation/Foundation.h>
@class LJKGoods;
@interface LJKCartItem : NSObject <NSCoding>
/** 购物车 - 商品信息 - 商品是否被选中 */
@property (nonatomic, assign) LJKCartItemState state;      
/** 购物车 - 商品信息 - 商品 */
@property (nonatomic, strong) LJKGoods *goods;
/** 购物车 - 商品信息 - 商品种类 */
@property (nonatomic, copy)   NSString *kind_name;
/** 购物车 - 商品信息 - 购买数量 */
@property (nonatomic, assign) NSUInteger number;
/** 购物车 - 商品信息 - 现价 */
@property (nonatomic, assign) double displayPrice;
/** 购物车 - 商品信息 - 原价 */
@property (nonatomic, assign) double displayOriginPrice;
@end
