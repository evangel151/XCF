//
//  LJKOrderSupplementaryFooter.m
//  LJKitchen
//
//  Created by  a on 16/7/13.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKOrderSupplementaryFooter.h"

#import <Masonry.h>
@interface LJKOrderSupplementaryFooter ()

/** 支付、优惠 - 优惠(容器) */
@property (nonatomic, strong) UIView *promotionView;
/** 支付、优惠 - 图标 */
@property (nonatomic, strong) UIImageView *iconView;
/** 支付、优惠 - 说明 */
@property (nonatomic, strong) UILabel *iconDescLabel;
/** 支付、优惠 - 优惠券(数量) */
@property (nonatomic, strong) UILabel *promotionCountLabel;
/** 支付、优惠 - 优惠券(细节) */
@property (nonatomic, strong) UILabel *promotionDetailLabel;
/** 支付、优惠 - 箭头 */
@property (nonatomic, strong) UIImageView *arrow;

/** 支付、优惠 - "支付方式"(title) */
@property (nonatomic, strong) UILabel *payModeLabel;
/** 支付、优惠 - 支付方式(容器) */
@property (nonatomic, strong) UIView *payModeView;
/** 支付、优惠 - 支付宝图标 */
@property (nonatomic, strong) UIImageView *ZFB_icon;
/** 支付、优惠 - 微信支付图标 */
@property (nonatomic, strong) UIImageView *WX_icon;
/** 支付、优惠 - 支付宝 副标题 */
@property (nonatomic, strong) UILabel *ZFB_title;
/** 支付、优惠 - 微信支付 副标题 */
@property (nonatomic, strong) UILabel *WX_title;

/** 支付、优惠 - 确认 */
@property (nonatomic, strong) UIButton *ZFB_check;
@property (nonatomic, strong) UIButton *WX_check;

/** 支付、优惠 - 分隔线 */
@property (nonatomic, strong) UIView *separtorLine;
@end

@implementation LJKOrderSupplementaryFooter

#pragma mark - 懒加载
- (UIView *)promotionView {
    if (!_promotionView) {
        _promotionView = [[UIView alloc] init];
        UITapGestureRecognizer *tapPromotion = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                       action:@selector(promotionDidClick)];
        [_promotionView addGestureRecognizer:tapPromotion];
    }
    return _promotionView;
}


- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        _iconView.image = [UIImage imageNamed:@"myVoucher"];
    }
    return _iconView;
}

- (UILabel *)iconDescLabel {
    if (!_iconDescLabel) {
        _iconDescLabel = [UILabel labelWithTextColor:Color_TintBlack
                                     backgroundColor:Color_Clear
                                            fontSize:15
                                               lines:1
                                       textAlignment:NSTextAlignmentLeft];
        _iconDescLabel.text = @"优惠";
    }
    return _iconDescLabel;
}

- (UILabel *)promotionCountLabel {
    if (!_promotionCountLabel) {
        _promotionCountLabel = [UILabel labelWithTextColor:Color_TintWhite
                                           backgroundColor:Color_ThemeColor
                                                  fontSize:15
                                                     lines:1
                                             textAlignment:NSTextAlignmentCenter];
        _promotionCountLabel.layer.cornerRadius = 5;
        _promotionCountLabel.text = @"0张可用";
    }
    return _promotionCountLabel;
}

- (UILabel *)promotionDetailLabel {
    if (!_promotionDetailLabel) {
        _promotionDetailLabel = [UILabel labelWithTextColor:Color_TintBlack
                                            backgroundColor:Color_Clear
                                                   fontSize:15
                                                      lines:1
                                              textAlignment:NSTextAlignmentRight];
        _promotionDetailLabel.text = @"已抵扣￥0";
    }
    return _promotionDetailLabel;
}

- (UIImageView *)arrow {
    if (!_arrow) {
        _arrow = [[UIImageView alloc] init];
        _arrow.image = [UIImage imageNamed:@"CellArrow"];
    }
    return _arrow;
}

- (UILabel *)payModeLabel {
    if (!_payModeLabel) {
        _payModeLabel = [UILabel labelWithTextColor:Color_TintBlack
                                    backgroundColor:Color_BackGround
                                           fontSize:15
                                              lines:1
                                      textAlignment:NSTextAlignmentLeft];
        _payModeLabel.text = @"    支付方式";
    }
    return _payModeLabel;
}


- (UIView *)payModeView {
    if (!_payModeView) {
        _payModeView = [[UIView alloc] init];
    }
    return _payModeView;
}

- (UIView *)separtorLine {
    if (!_separtorLine) {
        _separtorLine = [[UIView alloc] init];
        _separtorLine.backgroundColor = Color_DarkGray;
    }
    return _separtorLine;
}

#pragma mark -  构造方法
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.promotionView];
        [self.promotionView addSubview:self.iconView];
        [self.promotionView addSubview:self.iconDescLabel];
        [self.promotionView addSubview:self.promotionCountLabel];
        [self.promotionView addSubview:self.promotionDetailLabel];
        [self.promotionView addSubview:self.arrow];
        [self.contentView addSubview:self.payModeLabel];
        [self.contentView addSubview:self.payModeView];
        
        _ZFB_icon = [[UIImageView alloc] init];
        _ZFB_icon.image = [UIImage imageNamed:@"paymentAlipay"];
        [self.payModeView addSubview:_ZFB_icon];
        
        _ZFB_title = [UILabel labelWithTextColor:Color_TintBlack
                                 backgroundColor:Color_Clear
                                        fontSize:15 lines:1
                                   textAlignment:NSTextAlignmentLeft];
        _ZFB_title.text = @"支付宝";
        [self.payModeView addSubview:_ZFB_title];
        
        _ZFB_check = [UIButton checkMarkButtonWithtarget:self action:@selector(ZFB_DidClick:)];
        _ZFB_check.selected = YES;
        [self.payModeView addSubview:_ZFB_check];
        
        [self.payModeView addSubview:self.separtorLine];
        
        _WX_icon = [[UIImageView alloc] init];
        _WX_icon.image = [UIImage imageNamed:@"paymentWechat"];
        [self.payModeView addSubview:_WX_icon];
        
        _WX_title = [UILabel labelWithTextColor:Color_TintBlack
                                 backgroundColor:Color_Clear
                                        fontSize:15 lines:1
                                   textAlignment:NSTextAlignmentLeft];
        _WX_title.text = @"微信支付";
        
        [self.payModeView addSubview:_WX_title];
        
        _WX_check = [UIButton checkMarkButtonWithtarget:self action:@selector(WX_DidClick:)];
        _WX_check.selected = NO;
        [self.payModeView addSubview:_WX_check];
        
        [_promotionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 40));
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.top.equalTo(self.contentView.mas_top);
        }];
        
        [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.promotionView.mas_centerY);
            make.left.equalTo(self.promotionView.mas_left).offset(10);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
        
        [_iconDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.promotionView.mas_centerY);
            make.left.equalTo(self.iconView.mas_right);
            make.size.mas_equalTo(CGSizeMake(50, 30));
        }];
        
        [_promotionCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(100, 30));
            make.centerY.equalTo(self.promotionView.mas_centerY);
            make.left.equalTo(self.iconDescLabel.mas_right);
        }];
        
        [_arrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(16, 24));
            make.centerY.equalTo(self.promotionView.mas_centerY);
            make.right.equalTo(self.promotionView.mas_right).offset(-10);
        }];
        
        [_promotionDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.promotionView.mas_centerY);
            make.right.equalTo(self.arrow.mas_left).offset(-10);
            make.height.equalTo(@(30));
            make.left.equalTo(self.promotionCountLabel.mas_right);
        }];
        
        [_payModeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 40));
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.top.equalTo(self.promotionView.mas_bottom);
        }];
        
        [_payModeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 100));
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.top.equalTo(self.payModeLabel.mas_bottom);
        }];
        
        [_separtorLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20 , 1));
            make.centerX.equalTo(self.payModeView.mas_centerX);
            make.centerY.equalTo(self.payModeView.mas_centerY);
        }];
        
        [_ZFB_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(40, 40));
            make.left.equalTo(self.payModeView.mas_left).offset(10);
            make.top.equalTo(self.payModeView.mas_top).offset(5);
        }];
        
        [_ZFB_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.ZFB_icon.mas_centerY);
            make.left.equalTo(self.ZFB_icon.mas_right).offset(20);
            
        }];
        
        [_ZFB_check mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(LJKCircleCheckMarkWH, LJKCircleCheckMarkWH));
            make.centerY.equalTo(self.ZFB_icon.mas_centerY);
            make.right.equalTo(self.payModeView.mas_right).offset(-10);
        }];
        
        [_WX_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(self.ZFB_icon);
            make.left.equalTo(self.ZFB_icon.mas_left);
            make.bottom.equalTo(self.payModeView.mas_bottom).offset(-5);
        }];
        
        [_WX_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.WX_icon.mas_centerY);
            make.left.equalTo(self.ZFB_title.mas_left);
        }];
        
        [_WX_check mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(self.ZFB_check);
            make.centerY.equalTo(self.WX_icon.mas_centerY);
            make.right.equalTo(self.payModeView.mas_right).offset(-10);
        }];
        
    }
    return self;
}


#pragma mark - 点击事件 
// FIXME: (未解决) 按钮点击取反
// so stupid......
- (void)ZFB_DidClick:(UIButton *)button {
    button.selected = YES;
    self.WX_check.selected = NO;
}

- (void)WX_DidClick:(UIButton *)button {
    button.selected = YES;
    self.ZFB_check.selected = NO;
}

- (void)promotionDidClick {
    !self.promotionViewClickedBlock ? : self.promotionViewClickedBlock();
}

@end
