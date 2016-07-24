//
//  LJKRecommendItem.h
//  LJKitchen
//
//  Created by  a on 16/7/16.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  商品 - 推荐购买 - item (V)

#import <UIKit/UIKit.h>

@interface LJKRecommendItem : UICollectionViewCell

/** 推荐购买item - 配图 */
@property (nonatomic, strong) UIImageView *mainImage;
/** 推荐购买item - 商品名称 */
@property (nonatomic, strong) UILabel *goodsNameLabel;
/** 推荐购买item - 价格 */
@property (nonatomic, strong) UILabel *priceLabel;

@end
