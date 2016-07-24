//
//  LJKGoodsShopCell.m
//  LJKitchen
//
//  Created by  a on 16/7/16.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKGoodsShopCell.h"

#import "LJKShop.h"

#import <Masonry.h>
#import <UIImageView+WebCache.h>

@interface LJKGoodsShopCell ()

/** 店铺简介 - Logo */
@property (nonatomic, strong) UIImageView *shopIconView;
/** 店铺简介 - 店铺名称 */
@property (nonatomic, strong) UILabel *shopNameLabel;
/** 店铺简介 - 所有商品 */
@property (nonatomic, strong) UILabel *totalGoodsLabel;
/** 店铺简介 - 邮费说明 */
@property (nonatomic, strong) UILabel *freightDescLabel;
/** 店铺简介 - 前往商店(去逛逛) */
@property (nonatomic, strong) UIButton *goShoppingButton;
@end

@implementation LJKGoodsShopCell

#pragma mark - 构造方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _shopIconView = [[UIImageView alloc] init];
        [self.contentView addSubview:_shopIconView];
        
        _shopNameLabel = [UILabel labelWithTextColor:Color_TintBlack
                                     backgroundColor:Color_Clear
                                            fontSize:17
                                               lines:1
                                       textAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:_shopNameLabel];
        
        _totalGoodsLabel = [UILabel labelWithTextColor:Color_DarkGray
                                       backgroundColor:Color_Clear
                                              fontSize:15
                                                 lines:1
                                         textAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:_totalGoodsLabel];
        
        _freightDescLabel = [UILabel labelWithTextColor:Color_DarkGray
                                        backgroundColor:Color_Clear
                                               fontSize:15
                                                  lines:1
                                          textAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:_freightDescLabel];
        

        _goShoppingButton = [UIButton buttonWithBackgroundColor:Color_ThemeColor_Alpha
                                                          title:@"去逛逛"
                                                       fontSize:17
                                                     titleColor:Color_TintWhite
                                                         target:self
                                                         action:@selector(goShoppingButtonDidClicked)
                                                  clipsToBounds:YES];
        [self.contentView addSubview:_goShoppingButton];
        
        [_shopIconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(LJKAuthorIconWH, LJKAuthorIconWH));
            make.left.equalTo(self.contentView.mas_left).offset(LJKAuthorIcon2CellLeft);
            make.top.equalTo(self.contentView.mas_top).offset(LJKAuthorIcon2CellTop * 2);
        }];
        
        [_shopNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.shopIconView.mas_top);
            make.left.equalTo(self.shopIconView.mas_right).offset(LJKAuthorIcon2CellLeft);
            make.right.equalTo(self.contentView.mas_right).offset(-LJKAuthorIcon2CellLeft);
            make.height.equalTo(@(25));
        }];
        
        [_totalGoodsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.shopNameLabel.mas_left);
            make.top.equalTo(self.shopNameLabel.mas_bottom);
            make.height.equalTo(@(25));
        }];
        
        [_freightDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.totalGoodsLabel.mas_top);
            make.left.equalTo(self.totalGoodsLabel.mas_right).offset(5);
            make.height.equalTo(@(25));
            make.right.equalTo(self.shopNameLabel.mas_right);
        }];
        
        [_goShoppingButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 40, 40));
            make.centerX.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-20);
        }];
    }
    return self;
}


#pragma mark - 传入模型
- (void)setShop:(LJKShop *)shop {
    _shop = shop;
    [self.shopIconView sd_setImageWithURL:[NSURL URLWithString:shop.shop_logo_url]];
    self.shopNameLabel.text = shop.name;
    NSString *totalCount = [NSString stringWithFormat:@"商品数 : %@",shop.goods_count];
    CGFloat totalLabelWidth = [NSString getSizeWithString:totalCount height:25 font:15].width;
    [_totalGoodsLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(totalLabelWidth + 5));
    }];
    self.totalGoodsLabel.text = totalCount;
}

#pragma mark -  点击事件
- (void)goShoppingButtonDidClicked {
    !self.goShopDidClickedBlock ? : self.goShopDidClickedBlock();
}

@end
