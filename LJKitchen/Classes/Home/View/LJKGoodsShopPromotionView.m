//
//  LJKGoodsShopPromotionView.m
//  LJKitchen
//
//  Created by  a on 16/7/16.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKGoodsShopPromotionView.h"
#import "LJKGoods.h"
#import "LJKShop.h"

#import <Masonry.h>

@interface LJKGoodsShopPromotionView ()

/** 店铺优惠信息 - 店铺公告 */
@property (nonatomic, strong) UILabel *announcementLabel;
/** 店铺优惠信息 - 商品描述 */
@property (nonatomic, strong) UILabel *goodsDescLabel;

@end

@implementation LJKGoodsShopPromotionView

#pragma mark - 构造方法
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        _announcementLabel = [UILabel labelWithTextColor:Color_ThemeColor
                                         backgroundColor:Color_Clear
                                                fontSize:15
                                                   lines:0
                                           textAlignment:NSTextAlignmentLeft];
        [self addSubview:_announcementLabel];
        
        _goodsDescLabel = [UILabel labelWithTextColor:Color_TintBlack
                                      backgroundColor:Color_Clear
                                             fontSize:15
                                                lines:0
                                        textAlignment:NSTextAlignmentLeft];
        [self addSubview:_goodsDescLabel];
        
        [_announcementLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(LJKAuthorIcon2CellLeft);
            make.right.equalTo(self.mas_right).offset(-LJKAuthorIcon2CellLeft);
            make.top.equalTo(self.mas_top).offset(10);
        }];
        
        [_goodsDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.announcementLabel);
            make.top.equalTo(self.announcementLabel.mas_bottom).offset(10);
        }];
        
        
    }
    return self;
}

#pragma mark - 传入模型
- (void)setGoods:(LJKGoods *)goods {
    _goods = goods;
    if (goods.shop.announcement.length) {
        self.announcementLabel.text = goods.shop.announcement;
    } else  {
        _announcementLabel.hidden = YES;
        [_goodsDescLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(10);
        }];
    }
    self.goodsDescLabel.text = goods.desc;    
}

@end
