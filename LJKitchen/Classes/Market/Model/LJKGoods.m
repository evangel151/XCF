//
//  LJKGoods.m
//  LJKitchen
//
//  Created by  a on 16/7/5.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKGoods.h"
#import "LJKShop.h"
#import "LJKReview.h"
#import "LJKReviewPhoto.h"
#import "LJKGoodsKind.h"
#import "LJKGoodsAttrs.h"

#import <MJExtension.h>

@implementation LJKGoods

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID" : @"id"};
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"attrs" : [LJKGoodsAttrs class],
             @"extra_pics" : [LJKReviewPhoto class],
             @"kinds" : [LJKGoodsKind class],
             @"promotion_text_list" : [NSString class],
             @"reviews" : [LJKReview class]};
}


- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_main_pic                          forKey:@"main_pic"];
    [aCoder encodeObject:_average_rate                      forKey:@"average_rate"];
    [aCoder encodeObject:_recent_30days_sales_volume        forKey:@"recent_30days_sales_volume"];
    [aCoder encodeObject:_total_sales_volume                forKey:@"total_sales_volume"];
    [aCoder encodeObject:_name                              forKey:@"name"];
    [aCoder encodeObject:_foreword                          forKey:@"foreword"];
    [aCoder encodeObject:_freight                           forKey:@"freight"];
    [aCoder encodeObject:_display_freight                   forKey:@"display_freight"];
    [aCoder encodeObject:_display_original_price            forKey:@"display_original_price"];
    [aCoder encodeObject:_display_price                     forKey:@"display_price"];
    [aCoder encodeObject:_promotion_text_list               forKey:@"promotion_text_list"];
    [aCoder encodeObject:_desc                              forKey:@"desc"];
    [aCoder encodeObject:_shop                              forKey:@"shop"];
    [aCoder encodeObject:_n_reviews                         forKey:@"n_reviews"];
    [aCoder encodeObject:_img_txt_detail_url                forKey:@"img_txt_detail_url"];
    [aCoder encodeObject:_kinds                             forKey:@"kinds"];
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.main_pic                           = [decoder decodeObjectForKey:@"main_pic"];
        self.extra_pics                         = [decoder decodeObjectForKey:@"extra_pics"];
        self.average_rate                       = [decoder decodeObjectForKey:@"average_rate"];
        self.recent_30days_sales_volume         = [decoder decodeObjectForKey:@"recent_30days_sales_volume"];
        self.total_sales_volume                 = [decoder decodeObjectForKey:@"total_sales_volume"];
        self.name                               = [decoder decodeObjectForKey:@"name"];
        self.foreword                           = [decoder decodeObjectForKey:@"foreword"];
        self.freight                            = [decoder decodeObjectForKey:@"freight"];
        self.display_freight                    = [decoder decodeObjectForKey:@"display_freight"];
        self.display_original_price             = [decoder decodeObjectForKey:@"display_original_price"];
        self.display_price                      = [decoder decodeObjectForKey:@"display_price"];
        self.promotion_text_list                = [decoder decodeObjectForKey:@"promotion_text_list"];
        self.desc                               = [decoder decodeObjectForKey:@"desc"];
        self.shop                               = [decoder decodeObjectForKey:@"shop"];
        self.n_reviews                          = [decoder decodeObjectForKey:@"n_reviews"];
        self.reviews                            = [decoder decodeObjectForKey:@"reviews"];
        self.img_txt_detail_url                 = [decoder decodeObjectForKey:@"img_txt_detail_url"];
        self.attrs                              = [decoder decodeObjectForKey:@"attrs"];
        self.kinds                              = [decoder decodeObjectForKey:@"kinds"];
        self.goodsDetailViewHeight              = [decoder decodeFloatForKey:@"goodsDetailViewHeight"];
        self.shopPromotionViewHeight            = [decoder decodeFloatForKey:@"shopPromotionViewHeight"];
    }
    return self;
}

- (NSArray <LJKReviewPhoto *> *)totalPics {
    
    NSMutableArray *imageArray = [NSMutableArray array];
    [imageArray addObject:self.main_pic];
    if (self.extra_pics.count) {
        NSArray *photosArray = [LJKReviewPhoto mj_objectArrayWithKeyValuesArray:self.extra_pics];
        [imageArray addObjectsFromArray:photosArray];
    }
    return imageArray;
}


- (CGFloat)goodsDetailViewHeight {
    
    // 已经固定高度 = 顶部概览条高度(40) + PriceLabel高度(40) + 全部空白填充距离(10 * 4)
    CGFloat unChangedHeight = 40 * 3;
    CGFloat detailWidth = SCREEN_WIDTH - 40;
    

    CGFloat forewordLabelHeight = [NSString getSizeWithString:self.foreword width:detailWidth font:13].height;
    CGFloat shopNameLabelHeight = [NSString getSizeWithString:self.name width:detailWidth font:21].height;
    
    
    _goodsDetailViewHeight = unChangedHeight + forewordLabelHeight + shopNameLabelHeight;
    
    return _goodsDetailViewHeight;
}


- (CGFloat)shopPromotionViewHeight {
    
    CGFloat promotionWidth = SCREEN_WIDTH - 40;
    CGFloat sumMargin = 20;
    CGFloat goodsDescHeight = [NSString getSizeWithString:self.desc width:promotionWidth font:15].height;
    if (self.shop.announcement.length) {
        CGFloat announcementHeight = [NSString getSizeWithString:self.shop.announcement width:promotionWidth font:15].height;
        _shopPromotionViewHeight = announcementHeight + goodsDescHeight + sumMargin + 10;
    } else {
        _shopPromotionViewHeight = goodsDescHeight + sumMargin;
    }
    return _shopPromotionViewHeight;
}


- (CGFloat)goodsCategoryViewHeight {

    return 10;
}


- (CGFloat)shopRecommendBuyCellHeight {
    
    CGFloat titleLabelHeight = 25;
    CGFloat collectionHeight = (SCREEN_WIDTH - 20 * 4) / 3 + 70;
    _shopRecommendBuyCellHeight = collectionHeight + titleLabelHeight + 10;
    
    return _shopRecommendBuyCellHeight;
}

@end
