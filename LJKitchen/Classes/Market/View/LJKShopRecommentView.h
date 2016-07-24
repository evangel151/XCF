//
//  LJKShopRecommentView.h
//  LJKitchen
//
//  Created by  a on 16/7/14.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  好店推荐 (single item)(V)

#import <UIKit/UIKit.h>

@interface LJKShopRecommentView : UIView
@property (nonatomic, strong) UIImageView *shopImage; // 店铺配图(推荐商品)
@property (nonatomic, strong) UILabel *shopName;      // 名称
@property (nonatomic, strong) UILabel *priceLabel;    // 价格
@property (nonatomic, strong) UILabel *detailLabel;   // 广告(详情)

@property (nonatomic, copy) void (^shopDidClickedBlock)(NSUInteger);

/** 快速创建item  */
+ (instancetype)createShopRecommentViewWithShopImageName:(NSString *)imageName
                                                shopName:(NSString *)shopName
                                                   price:(NSString *)price
                                                  detail:(NSString *)detail;

@end
