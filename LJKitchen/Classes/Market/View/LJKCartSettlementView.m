//
//  LJKCartSettlementView.m
//  LJKitchen
//
//  Created by  a on 16/7/11.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKCartSettlementView.h"
#import "LJKCartItem.h"
#import "LJKGoods.h"

#import <Masonry.h>

@interface LJKCartSettlementView ()

/** 结算View - 全选(按钮) */
@property (nonatomic, strong) UIButton *checkMarkButton;
/** 结算View - 说明 */
@property (nonatomic, strong) UILabel *checkMarkLabel;
/** 结算View - 合计金额 */
@property (nonatomic, strong) UILabel *totalLabel;
/** 结算View - 运费 */
@property (nonatomic, strong) UILabel *freightLabel;
/** 结算View - 结算按钮 */
@property (nonatomic, strong) UIButton *settlementButton;
/** 结算View - 顶部分隔线 */
@property (nonatomic, strong) UIView *separtorLine;
@end

@implementation LJKCartSettlementView
#pragma mark - 懒加载
- (UIButton *)checkMarkButton {
    if (!_checkMarkButton) {
        _checkMarkButton = [UIButton checkMarkButtonWithtarget:self
                                                        action:@selector(selectedAllItems:)];

    }
    return _checkMarkButton;
}

- (UILabel *)checkMarkLabel {
    if (!_checkMarkLabel) {
        _checkMarkLabel = [UILabel labelWithTextColor:Color_TintBlack
                                      backgroundColor:Color_Clear
                                             fontSize:15
                                                lines:1
                                        textAlignment:NSTextAlignmentLeft];
        _checkMarkLabel.text = @"全选";
    }
    return _checkMarkLabel;
}

- (UILabel *)totalLabel {
    if (!_totalLabel) {
        _totalLabel = [UILabel labelWithTextColor:Color_ThemeColor
                                      backgroundColor:Color_Clear
                                             fontSize:15
                                                lines:1
                                        textAlignment:NSTextAlignmentRight];
        
    }
    return _totalLabel;
}

- (UILabel *)freightLabel {
    if (!_freightLabel) {
        _freightLabel = [UILabel labelWithTextColor:Color_DarkGray
                                    backgroundColor:Color_Clear
                                           fontSize:12
                                              lines:1
                                      textAlignment:NSTextAlignmentRight];
        _freightLabel.text = @"不含运费";

    }
    return _freightLabel;
}

- (UIButton *)settlementButton {
    if (!_settlementButton) {
        _settlementButton = [UIButton buttonWithTitle:@"结算"
                                           titleColor:Color_TintWhite
                                      backgroundColor:Color_ThemeColor
                                             fontSize:17
                                               target:self
                                               action:@selector(settleOrDeleteDidClicked:)];
        _settlementButton.layer.cornerRadius = 5;
    }
    return _settlementButton;
}

- (UIView *)separtorLine {
    if (!_separtorLine) {
        _separtorLine = [[UIView alloc] init];
        _separtorLine.backgroundColor = Color_DarkGray;
    }
    return _separtorLine;
}


#pragma mark - 构造方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = Color_BackGround;
        
        [self addSubview:self.checkMarkButton];
        [self addSubview:self.checkMarkLabel];
        [self addSubview:self.totalLabel];
        [self addSubview:self.freightLabel];
        [self addSubview:self.settlementButton];
        [self addSubview:self.separtorLine];
        
        [_checkMarkButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(LJKCircleCheckMarkWH, LJKCircleCheckMarkWH));
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(self.mas_left).offset(LJKAuthorIcon2CellLeft);
        }];
        
        [_checkMarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(50, 30));
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(self.checkMarkButton.mas_right).offset(LJKAuthorIcon2CellLeft);
        }];
        
        [_settlementButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(100, 40));
            make.right.equalTo(self.mas_right).offset(-10);
            make.centerY.equalTo(self.mas_centerY);
        }];
        
        [_totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.settlementButton.mas_left).offset(-5);
            make.bottom.equalTo(self.mas_centerY);
            make.top.equalTo(self.settlementButton.mas_top);
        }];
        
        [_freightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.totalLabel.mas_right);
            make.top.equalTo(self.totalLabel.mas_bottom);
            make.bottom.equalTo(self.settlementButton.mas_bottom);
        }];
        
        [_separtorLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 1));
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(self.mas_top);
        }];
        
    }
    return self;
}

// 当前页面状态 (结算 or 删除)
- (void)setStyle:(LJKCartEditStyle)style {
    _style = style;
    
    // 删除模式
    if (style == LJKCartEditStyleDelete) {
        self.totalLabel.hidden = YES;
        self.freightLabel.hidden = YES;
    }
    // 结算模式
    else {
        self.totalLabel.hidden = NO;
        self.freightLabel.hidden = NO;
    }
}

// 当前商品状态 (选中 or 未选中)
- (void)setState:(LJKCartItemState)state {
    _state = state;
    self.checkMarkButton.selected = state;
}

// 购物车内所有商品数组
- (void)setTotalItemsArray:(NSArray<LJKCartItem *> *)totalItemsArray {
    _totalItemsArray = totalItemsArray;
    
    double totalPrice      = 0;// 总价格
    NSUInteger totalNumber = 0;// 总购买数量 (结算模式)
    NSUInteger totalGoods  = 0;// 总商品数  (删除模式)
    
    // 选中后计算 三项 对应属性
    for (NSArray *shopArray in totalItemsArray) {
        for (LJKCartItem *item in shopArray) {
            if (item.state == LJKCartItemStateSelected) {
                totalPrice += item.displayPrice * item.number;
                totalNumber += item.number;
                totalGoods++;
            }
        }
    }
    
    // 结算模式
    if (self.style == LJKCartEditStyleSettlement) {
        if (totalPrice) {
            
            self.totalLabel.text = [NSString stringWithFormat:@"合计 ：¥%.1f0", totalPrice];
            [self.settlementButton setTitle:[NSString stringWithFormat:@"结算(%zd)", totalNumber]
                                   forState:UIControlStateNormal];
        } else {
            self.totalLabel.text = [NSString stringWithFormat:@"合计 ：¥0.00"];
            [self.settlementButton setTitle:@"结算(0)" forState:UIControlStateNormal];
        }
    }
    // 删除模式
    else if (self.style == LJKCartEditStyleDelete) {
        [self.settlementButton setTitle:[NSString stringWithFormat:@"删除(%zd)", totalGoods]
                               forState:UIControlStateNormal];
    }
}

#pragma mark - 事件处理
- (void)selectedAllItems:(UIButton *)button {
    button.selected = !button.selected;
    !self.selectedAllItemBlock ? : self.selectedAllItemBlock(button.isSelected);
}

- (void)settleOrDeleteDidClicked:(UIButton *)button {
    !self.settleOrDeleteBlock ? : self.settleOrDeleteBlock();
}

@end
