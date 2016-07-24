//
//  LJKGoodsBottomView.h
//  LJKitchen
//
//  Created by  a on 16/7/15.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  商品 - 底部功能View (V)


// 底部视图点击 回调枚举
typedef NS_ENUM(NSInteger, bottomViewAction) {
    bottomViewActionGoToShop    = 20, // 前往店铺
    bottomViewActionContactShop = 21, // 联系卖家
    bottomViewActionAddToCart   = 22, // 加入购物车
    bottomViewActionBuyNow      = 23  // 立即购买
};

typedef void (^bottomViewDidClickedBlock)();
#import <UIKit/UIKit.h>

@interface LJKGoodsBottomView : UIView

/** 底部视图点击回调 */
@property (nonatomic, copy) bottomViewDidClickedBlock clickBlock;

@end
