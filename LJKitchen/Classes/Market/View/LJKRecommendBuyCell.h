//
//  LJKRecommendBuyCell.h
//  LJKitchen
//
//  Created by  a on 16/7/16.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  商品 - 推荐购买 (V)

#import <UIKit/UIKit.h>

@interface LJKRecommendBuyCell : UITableViewCell

/** 推荐购买 - 点击回调 */
@property (nonatomic, copy) void (^collectionDidClickedBlock)(NSInteger);

@end
