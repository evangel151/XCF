//
//  LJKRecipeDishShowCell.h
//  LJKitchen
//
//  Created by  a on 16/7/10.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  菜谱 - 作品展示 (V)
//  商品 - 购买展示 (V)

#import <UIKit/UIKit.h>
@class LJKRecipe,LJKDish,LJKGoods;
@interface LJKRecipeDishShowCell : UITableViewCell

/** CollectionViewCell Type (ItemType:作品、商品)*/
@property (nonatomic, assign) LJKVerticalCellType type;

/** 作品模型数组 */
@property (nonatomic, strong) NSMutableArray *dishArray;
/** 展示作品 - 模型 */
@property (nonatomic, strong) LJKRecipe *recipe;
/** 评价作品(商品) - 模型 */
@property (nonatomic, strong) LJKGoods *goods;

/** CollectionViewCellClickedBlock */
@property (nonatomic, copy) void (^collectionViewCellClickedBlock)(NSInteger index);
/** 点赞按钮点击block */
@property (nonatomic, copy) void (^diggsButtonClickedBlock)(id sender);
/** 刷新回调 */
@property (nonatomic, copy) void (^refreshBlock)();
/** 查看所有作品、评价 */
@property (nonatomic, copy) void (^showAllBlock)();
/** 查看所有作品、评价 */
@property (nonatomic, copy) void (^uploadMyDishBlock)();
/** 查看所有作品、评价 */
@property (nonatomic, copy) void (^authorIconDidClickedBlock)();
@end
