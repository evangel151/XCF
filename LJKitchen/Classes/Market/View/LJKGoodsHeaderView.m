//
//  LJKGoodsHeaderView.m
//  LJKitchen
//
//  Created by  a on 16/7/15.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKGoodsHeaderView.h"
#import "LJKImageShowView.h"            // 图片轮播器
#import "LJKGoodsDetailView.h"          // 商品详情
#import "LJKGoodsShopPromotionView.h"   // 店铺公告 & 优惠信息

#import "LJKReviewPhoto.h"
#import "LJKGoods.h"

#import <MJExtension.h>
#import <Masonry.h>

@interface LJKGoodsHeaderView ()
/** 商品 - 顶部视图 - 图片轮播器 */
@property (nonatomic, strong) LJKImageShowView *imageShowView;
/** 商品 - 顶部视图 - 商品详情 */
@property (nonatomic, strong) LJKGoodsDetailView *detailView;
/** 商品 - 顶部视图 - 公告 & 优惠信息 */
@property (nonatomic, strong) LJKGoodsShopPromotionView *promotionView;

@end

@implementation LJKGoodsHeaderView

#pragma mark - 构造方法
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        

        
        _imageShowView = [[LJKImageShowView alloc] init];
        _imageShowView.showImageBlock = self.showImageBlock;
        [self addSubview:_imageShowView];
        
        _detailView = [[LJKGoodsDetailView alloc] init];
        [self addSubview:_detailView];
        
        _promotionView = [[LJKGoodsShopPromotionView alloc] init];
        [self addSubview:_promotionView];
        
        [_imageShowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.height.equalTo(@350);
        }];
        
        [_detailView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self.imageShowView.mas_bottom);
        }];
        
        [_promotionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self.detailView.mas_bottom);
        }];
    }
    return self;
}

#pragma mark - 传入模型
- (void)setGoods:(LJKGoods *)goods {
    _goods = goods;
    
    NSMutableArray *imageArray = [NSMutableArray array];
    [imageArray addObject:goods.main_pic];
    if (goods.extra_pics.count) {
        NSArray *photosArray = [LJKReviewPhoto mj_objectArrayWithKeyValuesArray:goods.extra_pics];
        [imageArray addObjectsFromArray:photosArray];
    }
    self.imageShowView.imageArray = goods.totalPics;
    self.imageShowView.type = LJKShowViewTypeGoods;
    self.detailView.goods = goods;
    self.promotionView.goods = goods;
    
    [_detailView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(goods.goodsDetailViewHeight));
    }];
    
    [_promotionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(goods.shopPromotionViewHeight));
    }];
}

#pragma mark 记录当前图片位置
- (void)setImageViewCurrentLocation:(CGFloat)imageViewCurrentLocation {
    _imageViewCurrentLocation = imageViewCurrentLocation;
    self.imageShowView.imageViewCurrentLocation = imageViewCurrentLocation;
}

@end
