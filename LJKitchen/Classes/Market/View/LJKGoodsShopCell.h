//
//  LJKGoodsShopCell.h
//  LJKitchen
//
//  Created by  a on 16/7/16.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  商品 - 店铺介绍 cell (V)
#import <UIKit/UIKit.h>
@class LJKShop;

@interface LJKGoodsShopCell : UITableViewCell
/** 店铺模型 */
@property (nonatomic, strong) LJKShop *shop;
/** "去逛逛" 点击回调 */
@property (nonatomic, copy) void (^goShopDidClickedBlock)();

@end
