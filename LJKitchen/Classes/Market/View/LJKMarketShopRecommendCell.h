//
//  LJKMarketShopRecommendCell.h
//  LJKitchen
//
//  Created by  a on 16/7/14.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  市集 - 好店推荐 (V)

// 好店推荐 - 点击位置枚举
typedef NS_ENUM(NSInteger, shopItemLocation) {
   
    shopItemLocationLeft   = 10,
    shopItemLocationMiddle = 11,
    shopItemLocationRight  = 12 
};

/** Block Define */
typedef void (^shopItemDidClickedBlock)();

#import <UIKit/UIKit.h>

@interface LJKMarketShopRecommendCell : UITableViewCell

/** 店铺点击Block */
@property (nonatomic, copy) shopItemDidClickedBlock clickedBlock;

@end
