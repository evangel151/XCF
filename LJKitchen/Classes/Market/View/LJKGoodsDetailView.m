//
//  LJKGoodsDetailView.m
//  LJKitchen
//
//  Created by  a on 16/7/15.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  Done 

#import "LJKGoodsDetailView.h"
#import "LJKGoods.h"

#import <Masonry.h>

@interface LJKGoodsDetailView ()

/** 商品详情 - 概览显示条(容器) */
@property (nonatomic, strong) UIView *topContainerView;
/** 商品详情 - 顶部显示条 - 评分 */
@property (nonatomic, strong) UILabel *rateLabel;
/** 商品详情 - 顶部显示条 - 月销量 */
@property (nonatomic, strong) UILabel *monthSoldLabel;
/** 商品详情 - 顶部显示条 - 总销量 */
@property (nonatomic, strong) UILabel *totalSoldLabel;

/** 商品详情 - 分隔线 - 概览条  */
@property (nonatomic, strong) UIView *separtorLine;
/** 商品详情 - 分隔线 - 底部  */
@property (nonatomic, strong) UIView *separtorLineBottom;

/** 商品详情 - 店铺 标语 */
@property (nonatomic, strong) UILabel *shopTitleLabel;
/** 商品详情 - 商品名称 */
@property (nonatomic, strong) UILabel *goodsNameLabel;
/** 商品详情 - 现价 */
@property (nonatomic, strong) UILabel *displayPriceLabel;
/** 商品详情 - 原价 */
@property (nonatomic, strong) UILabel *originPriceLabel;
/** 商品详情 - 运费 */
@property (nonatomic, strong) UILabel *freightLabel;
@end

@implementation LJKGoodsDetailView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        CGFloat topLabelWidth = (SCREEN_WIDTH - 40) / 3;
        _topContainerView = [[UIView alloc] init];
        [self addSubview:_topContainerView];
        
        _rateLabel = [UILabel labelWithTextColor:Color_DarkGray
                                 backgroundColor:Color_Clear
                                        fontSize:13 lines:1
                                   textAlignment:NSTextAlignmentLeft];
        [self.topContainerView addSubview:_rateLabel];
        
        _monthSoldLabel = [UILabel labelWithTextColor:Color_DarkGray
                                      backgroundColor:Color_Clear
                                             fontSize:13 lines:1
                                        textAlignment:NSTextAlignmentCenter];
        [self.topContainerView addSubview:_monthSoldLabel];
        
        _totalSoldLabel = [UILabel labelWithTextColor:Color_DarkGray
                                      backgroundColor:Color_Clear
                                             fontSize:13 lines:1
                                        textAlignment:NSTextAlignmentRight];
        [self.topContainerView addSubview:_totalSoldLabel];
        
        _shopTitleLabel = [UILabel labelWithTextColor:Color_DarkGray
                                      backgroundColor:Color_Clear
                                             fontSize:13 lines:0
                                        textAlignment:NSTextAlignmentLeft];
        [self addSubview:_shopTitleLabel];
        
        _goodsNameLabel = [UILabel labelWithTextColor:Color_TintBlack
                                      backgroundColor:Color_Clear
                                             fontSize:21 lines:0
                                        textAlignment:NSTextAlignmentLeft];
        [self addSubview:_goodsNameLabel];
        
        _displayPriceLabel = [UILabel labelWithTextColor:Color_ThemeColor
                                         backgroundColor:Color_Clear
                                                fontSize:19 lines:1
                                           textAlignment:NSTextAlignmentLeft];
        [self addSubview:_displayPriceLabel];
        
        _originPriceLabel = [UILabel labelWithTextColor:Color_DarkGray
                                        backgroundColor:Color_Clear
                                               fontSize:15 lines:1
                                          textAlignment:NSTextAlignmentLeft];
        [self addSubview:_originPriceLabel];
        
        _freightLabel = [UILabel labelWithTextColor:Color_DarkGray
                                    backgroundColor:Color_Clear
                                           fontSize:15 lines:1
                                      textAlignment:NSTextAlignmentRight];
        [self addSubview:_freightLabel];
        
        
        _separtorLine = [[UIView alloc] init];
        _separtorLine.backgroundColor = Color_DarkGray;
        [self.topContainerView addSubview:_separtorLine];
        
        _separtorLineBottom = [[UIView alloc] init];
        _separtorLineBottom.backgroundColor = Color_DarkGray;
        [self addSubview:_separtorLineBottom];
        
        [_topContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-40, 40));
            make.top.equalTo(self.mas_top);
            make.centerX.equalTo(self);
        }];
        
        [_rateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(topLabelWidth, 40));
            make.centerY.equalTo(self.topContainerView.mas_centerY);
            make.left.equalTo(self.topContainerView.mas_left);
        }];
        
        [_monthSoldLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(self.rateLabel);
            make.centerY.equalTo(self.topContainerView);
            make.left.equalTo(self.rateLabel.mas_right);
        }];
        
        [_totalSoldLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(self.rateLabel);
            make.centerY.equalTo(self.topContainerView);
            make.left.equalTo(self.monthSoldLabel.mas_right);
        }];
        
        [_separtorLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 40, 1));
            make.centerX.equalTo(self.mas_centerX);
            make.bottom.equalTo(self.topContainerView.mas_bottom);
        }];
        
        [_shopTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.topContainerView.mas_left);
            make.right.equalTo(self.topContainerView.mas_right);
            make.top.equalTo(self.topContainerView.mas_bottom).offset(10);
//            make.height.equalTo(@(30));
        }];
        
        [_goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.shopTitleLabel);
            make.top.equalTo(self.shopTitleLabel.mas_bottom).offset(10);
        }];
        
        [_displayPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.shopTitleLabel);
            make.top.equalTo(self.goodsNameLabel.mas_bottom).offset(10);
            make.height.equalTo(@(40));
        }];
        
        [_originPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.displayPriceLabel.mas_centerY);
            make.left.equalTo(self.displayPriceLabel.mas_left).offset(100);
            make.height.equalTo(@(40));
        }];
        
        [_freightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.displayPriceLabel.mas_centerY);
            make.height.equalTo(@(40));
            make.right.equalTo(self.totalSoldLabel.mas_right);
        }];
        
        [_separtorLineBottom mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 40, 1));
            make.centerX.equalTo(self.mas_centerX);
            make.bottom.equalTo(self.mas_bottom);
        }];
    }
    return self;
}


- (void)setGoods:(LJKGoods *)goods {
    _goods = goods;
    
    [self.rateLabel setAttributeTextWithString:[NSString stringWithFormat:@"评分 %@",goods.average_rate]
                                         range:NSMakeRange(3, goods.average_rate.length)
                                         color:Color_ThemeColor];
    [self.monthSoldLabel setAttributeTextWithString:[NSString stringWithFormat:@"月销量 %@",goods.recent_30days_sales_volume]
                                              range:NSMakeRange(4, goods.recent_30days_sales_volume.length)
                                              color:Color_ThemeColor];
    [self.totalSoldLabel setAttributeTextWithString:[NSString stringWithFormat:@"总销量 %@",goods.total_sales_volume]
                                              range:NSMakeRange(4, goods.total_sales_volume.length)
                                              color:Color_ThemeColor];
    
    self.shopTitleLabel.text = goods.foreword;
    self.goodsNameLabel.text = goods.name;
    self.displayPriceLabel.text = [NSString stringWithFormat:@"¥ %@", goods.display_price];
    self.freightLabel.text = goods.display_freight;
    
    // 为原价添加 删除线
    NSString *originPriceString = [NSString stringWithFormat:@"¥ %@", goods.display_original_price];
    NSMutableAttributedString *originPriceAttrsStr = [[NSMutableAttributedString alloc] initWithString:originPriceString];
    [originPriceAttrsStr addAttribute:NSStrikethroughStyleAttributeName value:@(1)
                                range:NSMakeRange(0, originPriceString.length)];
    self.originPriceLabel.attributedText = originPriceAttrsStr;
}

@end
