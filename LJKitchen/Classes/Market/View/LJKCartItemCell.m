//
//  LJKCartItemCell.m
//  LJKitchen
//
//  Created by  a on 16/7/12.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKCartItemCell.h"
#import "LJKCartItem.h"
#import "LJKGoods.h"
#import "LJKShop.h"
#import "LJKPicture.h"
#import "LJKReviewPhoto.h"

#import <Masonry.h>
#import <UIImageView+WebCache.h>

@interface LJKCartItemCell () <UITextFieldDelegate>
/** CartItemCell - "全选"按钮 */
@property (nonatomic, strong) UIButton *checkMarkButton;
/** CartItemCell - 商品主图 */
@property (nonatomic, strong) UIImageView *goodsImage;
/** CartItemCell - 商品名称 */
@property (nonatomic, strong) UILabel *goodsNameLabel;
/** CartItemCell - 商品规格/种类 */
@property (nonatomic, strong) UILabel *goodsKindLabel;
/** CartItemCell - 商品单价 */
@property (nonatomic, strong) UILabel *unitPriceLabel;
/** CartItemCell - 选购数目(订单页面) */
@property (nonatomic, strong) UILabel *orderNumberLabel;
/** CartItemCell - 数目编辑(数量输入框) */
@property (nonatomic, strong) UITextField *numberField;
/** CartItemCell - 顶部分隔线 */
@property (nonatomic, strong) UIView *separtorLine;
/** CartItemCell - 辅助工具条 */
@property (nonatomic, strong) UIToolbar *toolBar;

@end

@implementation LJKCartItemCell

#pragma mark - 懒加载
- (UIButton *)checkMarkButton {
    if (!_checkMarkButton) {
        _checkMarkButton = [UIButton checkMarkButtonWithtarget:self
                                                        action:@selector(selectedShopItem:)];

    }
    return _checkMarkButton;
}

- (UIImageView *)goodsImage {
    if (!_goodsImage) {
        _goodsImage = [[UIImageView alloc] init];
    }
    return _goodsImage;
}

- (UILabel *)goodsNameLabel {
    if (!_goodsNameLabel) {
        _goodsNameLabel = [UILabel labelWithTextColor:Color_TintBlack
                                      backgroundColor:Color_Clear
                                             fontSize:15
                                                lines:0
                                        textAlignment:NSTextAlignmentLeft];
    }
    return _goodsNameLabel;
}

- (UILabel *)goodsKindLabel {
    if (!_goodsKindLabel) {
        _goodsKindLabel = [UILabel labelWithTextColor:Color_DarkGray
                                      backgroundColor:Color_Clear
                                             fontSize:13
                                                lines:0
                                        textAlignment:NSTextAlignmentLeft];
    }
    return _goodsKindLabel;
}

- (UILabel *)unitPriceLabel {
    if (!_unitPriceLabel) {
        _unitPriceLabel = [UILabel labelWithTextColor:Color_TintBlack
                                      backgroundColor:Color_Clear
                                             fontSize:15
                                                lines:1
                                        textAlignment:NSTextAlignmentRight];
    }
    return _unitPriceLabel;
}

- (UILabel *)orderNumberLabel {
    if (!_orderNumberLabel) {
        _orderNumberLabel = [UILabel labelWithTextColor:Color_DarkGray
                                        backgroundColor:Color_Clear
                                               fontSize:13
                                                  lines:0
                                          textAlignment:NSTextAlignmentRight];
    }
    return _orderNumberLabel;
}

- (UITextField *)numberField {
    if (!_numberField) {
        _numberField = [[UITextField alloc] init];
        _numberField.delegate = self;
        _numberField.font = [UIFont systemFontOfSize:15];
        _numberField.textAlignment = NSTextAlignmentCenter;
        _numberField.backgroundColor = Color_BackGround;
        _numberField.placeholder = @"买!";
    }
    return _numberField;
}

- (UIView *)separtorLine {
    if (!_separtorLine) {
        _separtorLine = [[UIView alloc] init];
        _separtorLine.backgroundColor = Color_DarkGray;
    }
    return _separtorLine;
}

- (UIToolbar *)toolBar {
    if (!_toolBar) {
        _toolBar = [UIToolbar createSingleButtonToolBarWithTitle:@"完成"
                                                          action:@selector(doneDidClicked)
                                                          target:self];
        _toolBar.backgroundColor = Color_BackGround;
        
    }
    return _toolBar;
}

#pragma mark - 构造方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = Color_TintWhite;
        
        self.numberField.inputAccessoryView = self.toolBar;
        [self.contentView addSubview:self.checkMarkButton];
        [self.contentView addSubview:self.goodsImage];
        [self.contentView addSubview:self.goodsNameLabel];
        [self.contentView addSubview:self.goodsKindLabel];
        [self.contentView addSubview:self.unitPriceLabel];
        [self.contentView addSubview:self.orderNumberLabel];
        [self.contentView addSubview:self.numberField];
        [self.contentView addSubview:self.separtorLine];

        [_checkMarkButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(LJKCircleCheckMarkWH, LJKCircleCheckMarkWH));
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.left.equalTo(self.contentView.mas_left).offset(LJKAuthorIcon2CellLeft);
        }];
        
        [_goodsImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(LJKCartItemMainImageWH, LJKCartItemMainImageWH));
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.left.equalTo(self.contentView.mas_left).offset(62);
        }];
        
        [_goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.goodsImage.mas_top);
            make.left.equalTo(self.goodsImage.mas_right).offset(10);
            make.bottom.equalTo(self.contentView.mas_centerY);
            make.right.equalTo(self.unitPriceLabel.mas_left).offset(-10);
        }];
        
        [_goodsKindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.goodsNameLabel.mas_left);
            make.top.equalTo(self.contentView.mas_centerY);
            make.right.equalTo(self.goodsNameLabel.mas_right);
        }];
        
        [_unitPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.orderNumberLabel.mas_top);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
            make.height.equalTo(@(20));
            make.width.equalTo(@(60));
        }];
        

        [_orderNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.numberField.mas_top);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
            make.height.equalTo(@(20));
            make.width.equalTo(@(60));
        }];
        
        [_numberField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(40, 30));
            make.right.equalTo(self.contentView.mas_right).offset(-10);
            make.top.equalTo(self.contentView.mas_centerY);
        }];
        
        [_separtorLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH - 30), 1));
            make.left.equalTo(self.contentView.mas_left).offset(LJKAuthorIcon2CellLeft);
            make.top.equalTo(self.contentView.mas_top);
        }];
    }
    return self;
}



#pragma mark - 传入模型
// 根据类型调整布局
- (void)setStyle:(LJKCartViewChildControlStyle)style {
    _style = style;
    if (style == LJKCartViewChildControlStyleCart) { // 购物车
        self.checkMarkButton.hidden = NO;
        self.orderNumberLabel.hidden = YES;
    } else if (style == LJKCartViewChildControlStyleOrder) { // 订单
        [self.checkMarkButton removeFromSuperview];
        self.numberField.hidden = YES;
        self.orderNumberLabel.hidden = NO;
        
        [self.goodsImage mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(LJKAuthorIcon2CellLeft);
        }];
    }
}

- (void)setCartItem:(LJKCartItem *)cartItem {
    _cartItem = cartItem;
    
    self.checkMarkButton.selected = cartItem.state;
    self.goodsNameLabel.text = cartItem.goods.name;
    
    [self.goodsImage sd_setImageWithURL:[NSURL URLWithString:cartItem.goods.main_pic.url]
                       placeholderImage:[UIImage imageNamed:@"loading"]];
    
    
    if (cartItem.number >= 1 && cartItem.number <=100) {
        self.numberField.text = [NSString stringWithFormat:@"%zd",cartItem.number];
    } else {
        self.numberField.text = @"1";
    }

    // 购物车 Cell 显示商品现价格
    if (self.style == LJKCartViewChildControlStyleCart) {
        self.unitPriceLabel.text = [NSString stringWithFormat:@"¥ %.1f0", cartItem.displayPrice];
    }
    // 订单  Cell  显示商品原价格
    else if (self.style == LJKCartViewChildControlStyleOrder) {
        self.unitPriceLabel.text = [NSString stringWithFormat:@"¥ %.1f0", cartItem.displayOriginPrice];
        self.orderNumberLabel.text = [NSString stringWithFormat:@"X %zd", cartItem.number];
    }
    
    // 如果商品存在多种规格参数 -> 显示对应规格
    if (cartItem.goods.kinds.count > 1) {
        self.goodsKindLabel.hidden = NO;
        self.goodsKindLabel.text = cartItem.kind_name;
    } else {
        self.goodsKindLabel.hidden = YES;
    }
    
    
}

#pragma mark - 事件处理
- (void)selectedShopItem:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    !self.selectedItemBlock ? : self.selectedItemBlock(sender.isSelected);
}

- (void)doneDidClicked {
    NSUInteger number = [self.numberField.text integerValue];
    if (number < 1) {
        self.numberField.text = @"1";
        number = 1;
    } else if (number > 100 ){
        self.numberField.text = @"100";
    }
    
    !self.itemNumberChangeBlock ? : self.itemNumberChangeBlock(number);
}

#pragma mark textField 代理
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    NSUInteger number = [self.numberField.text integerValue];
    if (number < 1) {
        self.numberField.text = @"1";
        number = 1;
    } else if (number > 100 ){
        self.numberField.text = @"100";
    }
    
    !self.itemNumberChangeBlock ? : self.itemNumberChangeBlock(number);
    return YES;
}

@end
