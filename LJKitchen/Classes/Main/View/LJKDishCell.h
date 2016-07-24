//
//  LJKDishCell.h
//  LJKitchen
//
//  Created by  a on 16/7/10.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  作品展示 、 商品评价 (V)

#import <UIKit/UIKit.h>

@class LJKDish,LJKReview;
@interface LJKDishCell : UICollectionViewCell

@property (nonatomic, strong) LJKDish *dish;

@property (nonatomic, strong) LJKReview *review;

/** 点赞按钮点击block */
@property (nonatomic, copy) void (^diggsButtonClickedBlock)(id sender);
/** 点赞按钮点击block */
@property (nonatomic, copy) void (^authorIconClickedBlock)();
@end
