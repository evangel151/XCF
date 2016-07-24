//
//  LJKMarketCategoryCell.h
//  LJKitchen
//
//  Created by  a on 16/7/14.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  市集 分类 


/** 市集分类商品按钮点击回调 - 枚举 */
typedef NS_ENUM(NSInteger, marketNavButtonAction) {
    /**
     @[@"烘焙", @"果蔬生鲜", @"器具", @"领券中心",@"方便食品", @"进口食品", @"调味品", @"全部分类"];
     */
    marketNavButtonActionCure            = 20,// 烘焙
    marketNavButtonActionFresh           = 21,// 果蔬生鲜
    marketNavButtonActionTableware       = 22,// 器具
    marketNavButtonActionPromotionCenter = 23,// 领券中心
    marketNavButtonActionFastFood        = 24,// 方便食品
    marketNavButtonActionIportedFood     = 25,// 进口食品
    marketNavButtonActionCondiment       = 26,// 调味品
    marketNavButtonActionAllCategories   = 27 // 全部分类
};

typedef void (^marketNavButtonDidClickedBlock)();

#import <UIKit/UIKit.h>

@interface LJKMarketCategoryCell : UITableViewCell

/** 市集分类商品按钮点击回调 */
@property (nonatomic, copy) marketNavButtonDidClickedBlock clickBlock;
@end
