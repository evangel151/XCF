//
//  LJKOrderPayView.m
//  LJKitchen
//
//  Created by  a on 16/7/13.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKOrderPayView.h"

#import "LJKCartItemTool.h"
#import "LJKCartItem.h"
#import "LJKGoods.h"

#import <Masonry.h>

@interface LJKOrderPayView ()
/** 支付工具条 - 支付按钮 */
@property (nonatomic, strong) UIButton *payButton;
/** 支付工具条 - 总支付价格 */
@property (nonatomic, strong) UILabel *totalPriceLabel;
@end

@implementation LJKOrderPayView

#pragma mark - 懒加载
- (UIButton *)payButton {
    if (!_payButton) {
        _payButton = [UIButton buttonWithBackgroundColor:Color_ThemeColor
                                                   title:@"付款"
                                                fontSize:17
                                              titleColor:Color_TintWhite
                                                  target:self
                                                  action:@selector(payButtonDidClick:)
                                           clipsToBounds:YES];
    }
    return _payButton;
}

- (UILabel *)totalPriceLabel {
    if (!_totalPriceLabel) {
        _totalPriceLabel = [UILabel labelWithTextColor:Color_ThemeColor
                                       backgroundColor:Color_Clear
                                              fontSize:17
                                                 lines:1
                                         textAlignment:NSTextAlignmentRight];
    }
    return _totalPriceLabel;
}

#pragma mark - 构造方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = Color_BackGround;
        
        [self addSubview:self.payButton];
        [self addSubview:self.totalPriceLabel];
        
        [_payButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.right.equalTo(self.mas_right).offset(-10);
            make.size.mas_equalTo(CGSizeMake(100, 40));
        }];
        
        [_totalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.payButton.mas_top);
            make.bottom.equalTo(self.payButton.mas_bottom);
            make.right.equalTo(self.payButton.mas_left).offset(-10);
            make.left.equalTo(self.mas_left).offset(LJKAuthorIcon2CellLeft);
        }];
    }
    return self;
}

#pragma mark - 赋值
- (void)setBuyItems:(NSArray *)buyItems {
    _buyItems = buyItems;
    
    if (!buyItems.count) {
        _buyItems = [LJKCartItemTool totalBuyItems];
    }
    
    double totalPrice = 0;   // 总价格
    double totalFreight = 0; // 总运费
    for (NSArray *shopArray in buyItems) {
        totalFreight += [[[shopArray[0] goods] freight] doubleValue];
        for (LJKCartItem *item in shopArray) {
            totalPrice += item.displayPrice * item.number;
        }
    }
    
    double sumPrice = totalPrice + totalFreight;
    self.totalPriceLabel.text = [NSString stringWithFormat:@"合计付款 : ¥%.1f0",sumPrice];
}

#pragma mark - 点击事件
- (void)payButtonDidClick:(UIButton *)button {
    !self.payButtonDidClickedBlock ? : self.payButtonDidClickedBlock();
}

@end
