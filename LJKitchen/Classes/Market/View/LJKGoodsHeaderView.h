//
//  LJKGoodsHeaderView.h
//  LJKitchen
//
//  Created by  a on 16/7/15.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  商品 - 顶部视图 (V)

#import <UIKit/UIKit.h>
@class LJKGoods;

@interface LJKGoodsHeaderView : UIView
@property (nonatomic, strong) LJKGoods *goods;
/** 存储cell内图片轮播器滚动位置 */
@property (nonatomic, assign) CGFloat imageViewCurrentLocation;
/** 图片点击回调 */
@property (nonatomic, copy) void (^showImageBlock)(NSUInteger, CGRect);
@end
