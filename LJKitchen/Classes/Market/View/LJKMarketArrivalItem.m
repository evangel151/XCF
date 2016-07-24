//
//  LJKMarketArrivalItem.m
//  LJKitchen
//
//  Created by  a on 16/7/15.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKMarketArrivalItem.h"

#import <Masonry.h>

@interface LJKMarketArrivalItem ()
/** 市集 - 新品上架 - 商品配图*/
@property (nonatomic, strong) UIImageView *goodsImageView;
/** 市集 - 新品上架 - 商品描述 */
@property (nonatomic, strong) UILabel *goodsDescLabel;
/** 市集 - 新品上架 - 已售出数量 */
@property (nonatomic, strong) UILabel *soldCountLabel;
/** 市集 - 新品上架 - 运费 */
@property (nonatomic, strong) UILabel *freightLabel;
/** 市集 - 新品上架 - 价格 */
@property (nonatomic, strong) UILabel *priceLabel;
/** 市集 - 新品上架 - 分隔线 */
@property (nonatomic, strong) UIView *separtorLine; // 应该是虚线的……凑合用吧

@end

@implementation LJKMarketArrivalItem

#pragma mark - 构造方法
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        CGFloat margin = 20;
        CGFloat padding = 10;
        CGFloat itemW = (SCREEN_WIDTH - 3 * margin) / 2;
        _goodsImageView = [[UIImageView alloc] init];
        _goodsImageView.layer.cornerRadius = 5;
        _goodsImageView.image = [UIImage imageNamed:@"loveFresh"];
        [self.contentView addSubview:_goodsImageView];
        
        _goodsDescLabel = [UILabel labelWithTextColor:Color_TintBlack
                                      backgroundColor:Color_Clear
                                             fontSize:15 lines:0
                                        textAlignment:NSTextAlignmentLeft];
        _goodsDescLabel.text = @"【限时特价】等一味 | 手工芒果干(2个规格)";
        [self.contentView addSubview:_goodsDescLabel];
        
        _soldCountLabel = [UILabel labelWithTextColor:Color_DarkGray
                                      backgroundColor:Color_Clear
                                             fontSize:12 lines:1
                                        textAlignment:NSTextAlignmentLeft];
        _soldCountLabel.text = @"已售 1967 件";
        [self.contentView addSubview:_soldCountLabel];
        
        _freightLabel = [UILabel labelWithTextColor:Color_DarkGray
                                    backgroundColor:Color_Clear
                                           fontSize:12 lines:1
                                      textAlignment:NSTextAlignmentRight];
        _freightLabel.text = @"包邮";
        [self.contentView addSubview:_freightLabel];
        
        _separtorLine = [[UIView alloc] init];
        _separtorLine.backgroundColor = Color_BackGround;
        [self.contentView addSubview:_separtorLine];
        
        _priceLabel = [UILabel labelWithTextColor:Color_ThemeColor
                                  backgroundColor:Color_Clear
                                         fontSize:17 lines:1
                                    textAlignment:NSTextAlignmentLeft];
        _priceLabel.text = @"￥ 16.9";
        [self.contentView addSubview:_priceLabel];
        
        
        [_goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(itemW, itemW));
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.top.equalTo(self.contentView.mas_top);
        }];
        
        [_goodsDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(itemW - 2 * padding, 40));
            make.top.equalTo(self.goodsImageView.mas_bottom);
            make.centerX.equalTo(self.contentView.mas_centerX);
        }];
        
        [_soldCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(padding);
            make.top.equalTo(self.goodsDescLabel.mas_bottom);
            make.right.equalTo(self.contentView.mas_centerX);
            make.height.equalTo(@(10));
        }];
        
        [_freightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.soldCountLabel.mas_right);
            make.right.equalTo(self.contentView.mas_right).offset(-padding);
            make.top.equalTo(self.goodsDescLabel.mas_bottom);
            make.height.equalTo(@(10));
        }];
        
        [_separtorLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(itemW - 2 *padding, 1));
            make.top.equalTo(self.soldCountLabel.mas_bottom).offset(6);
            make.centerX.equalTo(self.contentView.mas_centerX);
        }];
        
        [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.separtorLine.mas_bottom);
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(itemW - 2 * padding, 30));
        }];
    }
    return self;
}

@end
