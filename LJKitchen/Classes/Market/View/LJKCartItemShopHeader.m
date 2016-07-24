//
//  LJKCartItemShopHeader.m
//  LJKitchen
//
//  Created by  a on 16/7/12.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKCartItemShopHeader.h"
#import "LJKCartItem.h"
#import "LJKGoods.h"
#import "LJKShop.h"

#import <Masonry.h>

@interface LJKCartItemShopHeader ()

/** ShopHeader - "全选"按钮 */
@property (nonatomic, strong) UIButton *checkMarkButton;
/** ShopHeader - 商铺图标 */
@property (nonatomic, strong) UIImageView *shopIcon;
/** ShopHeader - 功能性视图(容器) */
@property (nonatomic, strong) UIView *containerView;
/** ShopHeader - 商铺名称 */
@property (nonatomic, strong) UILabel *shopNameLabel;
/** ShopHeader - 箭头(能否跳转) */
@property (nonatomic, strong) UIImageView *arrowIcon;

@end

@implementation LJKCartItemShopHeader

#pragma mark - 懒加载
- (UIButton *)checkMarkButton {
    if (!_checkMarkButton) {
        _checkMarkButton = [UIButton checkMarkButtonWithtarget:self
                                                        action:@selector(selectedShopItems:)];

    }
    return _checkMarkButton;
}

- (UIImageView *)shopIcon {
    if (!_shopIcon) {
        _shopIcon = [[UIImageView alloc] init];
        _shopIcon.image = [UIImage imageNamed:@"tabCSelected-1"];
    }
    return _shopIcon;
}

- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
        UITapGestureRecognizer *tapShop = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(shopHeaderDidClicked)];
        [_containerView addGestureRecognizer:tapShop];
    }
    return _containerView;
}


- (UILabel *)shopNameLabel {
    if (!_shopNameLabel) {
        _shopNameLabel = [UILabel labelWithTextColor:Color_TintBlack
                                     backgroundColor:Color_Clear
                                            fontSize:15
                                               lines:1
                                       textAlignment:NSTextAlignmentLeft];
    }
    return _shopNameLabel;
}

- (UIImageView *)arrowIcon {
    if (!_arrowIcon) {
        _arrowIcon = [[UIImageView alloc] init];
        _arrowIcon.image = [UIImage imageNamed:@"CellArrow"];
    }
    return _arrowIcon;
}

#pragma mark - 构造方法
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.checkMarkButton];
        [self.contentView addSubview:self.shopIcon];
        [self.contentView addSubview:self.containerView];
        [self.containerView addSubview:self.shopNameLabel];
        [self.containerView addSubview:self.arrowIcon];
        
        [_checkMarkButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(LJKCircleCheckMarkWH, LJKCircleCheckMarkWH));
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.left.equalTo(self.contentView.mas_left).offset(LJKAuthorIcon2CellLeft);
        }];
        
        [_shopIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(25, 25));
            make.left.equalTo(self.contentView.mas_left).offset(62);
        }];
        
        [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top);
            make.bottom.equalTo(self.contentView.mas_bottom);
            make.right.equalTo(self.contentView.mas_right).offset(-LJKAuthorIcon2CellLeft);
            make.left.equalTo(self.shopIcon.mas_right).offset(10);
        }];
        
        [_shopNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(self.containerView);
        }];
        
        [_arrowIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(16, 24));
            make.centerY.equalTo(self.containerView.mas_centerY);
            make.left.equalTo(self.shopNameLabel.mas_right);
        }];
    }
    return self;
}

#pragma mark - 传入模型
- (void)setCartItem:(LJKCartItem *)cartItem {
    _cartItem = cartItem;
    
    self.shopNameLabel.text = cartItem.goods.shop.name;
    CGFloat shopNameWidth = 0;
    if (cartItem.goods.shop.name.length) {
        shopNameWidth = [NSString getSizeWithString:cartItem.goods.shop.name height:30 font:15].width;
        self.shopNameLabel.text = cartItem.goods.shop.name;
        [_shopNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(shopNameWidth + 10));
        }];
    } else {
        self.shopNameLabel.text = @"商铺";
        [_shopNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(50));
        }];
    }

}

- (void)setState:(LJKCartShopState)state {
    _state = state;
    self.checkMarkButton.selected = state;
}

- (void)setStyle:(LJKCartViewChildControlStyle)style {
    _style = style;
    self.checkMarkButton.hidden = YES;
    self.arrowIcon.hidden = YES;
    // cell -> 购物车
    if (self.style == LJKCartViewChildControlStyleCart) {
        self.checkMarkButton.hidden = NO;
        self.arrowIcon.hidden = NO;
    }
    // cell -> 订单
    else if (self.style == LJKCartViewChildControlStyleOrder) {
        // 更新布局
        [_shopIcon mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(20);
        }];
    }
}

#pragma mark - 点击事件
- (void)shopHeaderDidClicked {
    !self.shopHeaderDidClickedBlock ? : self.shopHeaderDidClickedBlock();
}

- (void)selectedShopItems:(UIButton *)button {
    button.selected = !button.selected;
    !self.selectedShopItemsBlock ? : self.selectedShopItemsBlock(button.isSelected);
}

@end
