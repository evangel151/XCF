//
//  LJKFeedsViewCell.h
//  LJKitchen
//
//  Created by  a on 16/7/1.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  关注动态 cell (V)

#import <UIKit/UIKit.h>


// dish 回调状态枚举
typedef NS_ENUM(NSInteger, DishViewAction) {
    DishViewActionIcon,
    DishViewActionName,
    DishViewActionDigg,
    DishViewActionCommment,
    DishViewActionMore
};


@class LJKDish,LJKReview;
@interface LJKFeedsViewCell : UITableViewCell
/** 关注动态 - cell类型 */
@property (nonatomic, assign) LJKShowViewType type;

/** 关注动态 - 模型 */
@property (nonatomic, strong) LJKDish *dish;
@property (nonatomic, strong) LJKReview *review;

/** 图片数据 */
@property (nonatomic, strong) NSArray *imageArray;
/** 存储cell内图片轮播器滚动位置 */
@property (nonatomic, assign) CGFloat imageViewCurrentLocation;
/** cell滚动回调 */
@property (nonatomic, copy) void (^imageViewDidScrolledBlock)();
/** 底部button事件回调 */
@property (nonatomic, copy) void (^actionBlock)();
@end
