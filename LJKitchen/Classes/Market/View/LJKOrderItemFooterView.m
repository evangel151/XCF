//
//  LJKOrderItemFooterView.m
//  LJKitchen
//
//  Created by  a on 16/7/13.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  Done

#import "LJKOrderItemFooterView.h"
#import "LJKCartItemTool.h"
#import "LJKCartItem.h"
#import "LJKGoods.h"

#import <Masonry.h>

@interface LJKOrderItemFooterView () <UITextFieldDelegate>

/** 订单详情 - 运费(容器) */
@property (nonatomic, strong) UIView *freightView;
/** 订单详情 - 运费(title) */
@property (nonatomic, strong) UILabel *freightTitle;
/** 订单详情 - 运费(实际价格) */
@property (nonatomic, strong) UILabel *freightPrice;

/** 订单详情 - 订购数量(容器) */
@property (nonatomic, strong) UIView *totalView;
/** 订单详情 - 订购数量(title) */
@property (nonatomic, strong) UILabel *totalTitle;
/** 订单详情 - 订购数量(实际价格) */
@property (nonatomic, strong) UILabel *totalPrice;
/** 订单详情 - 留言 */
@property (nonatomic, strong) UITextField *messageField;

/** 订单详情 - 分隔线 */
@property (nonatomic, strong) UIView *separtorLine1;
@property (nonatomic, strong) UIView *separtorLine2;
@end

@implementation LJKOrderItemFooterView

#pragma mark - 懒加载

- (UIView *)freightView {
    if (!_freightView) {
        _freightView = [[UIView alloc] init];
    }
    return _freightView;
}

- (UIView *)totalView {
    if (!_totalView) {
        _totalView = [[UIView alloc] init];
    }
    return _totalView;
}

- (UILabel *)freightTitle {
    if (!_freightTitle) {
        _freightTitle = [UILabel labelWithTextColor:Color_TintBlack
                                    backgroundColor:Color_Clear
                                           fontSize:15
                                              lines:1
                                      textAlignment:NSTextAlignmentLeft];
        _freightTitle.text = @"运费 :";
    }
    return _freightTitle;
}

- (UILabel *)freightPrice {
    if (!_freightPrice) {
        _freightPrice = [UILabel labelWithTextColor:Color_TintBlack
                                    backgroundColor:Color_Clear
                                           fontSize:15
                                              lines:1
                                      textAlignment:NSTextAlignmentRight];
    }
    return _freightPrice;
}

- (UILabel *)totalTitle {
    if (!_totalTitle) {
        _totalTitle = [UILabel labelWithTextColor:Color_TintBlack
                                  backgroundColor:Color_Clear
                                         fontSize:15
                                            lines:1
                                    textAlignment:NSTextAlignmentLeft];
        _totalTitle.text = @"合计 :";
    }
    return _totalTitle;
}

- (UILabel *)totalPrice {
    if (!_totalPrice) {
        _totalPrice = [UILabel labelWithTextColor:Color_TintBlack
                                  backgroundColor:Color_Clear
                                         fontSize:15
                                            lines:1
                                    textAlignment:NSTextAlignmentRight];
    }
    return _totalPrice;
}

- (UITextField *)messageField {
    if (!_messageField) {
        _messageField = [[UITextField alloc] init];
        _messageField.delegate = self;
        _messageField.font = [UIFont systemFontOfSize:15];
        _messageField.textAlignment = NSTextAlignmentCenter;
        _messageField.backgroundColor = Color_BackGround;
        _messageField.placeholder = @"写留言";
    }
    return _messageField;
}

- (UIView *)separtorLine1 {
    if (!_separtorLine1) {
        _separtorLine1 = [[UIView alloc] init];
        _separtorLine1.backgroundColor = Color_DarkGray;
    }
    return _separtorLine1;
}

- (UIView *)separtorLine2 {
    if (!_separtorLine2) {
        _separtorLine2 = [[UIView alloc] init];
        _separtorLine2.backgroundColor = Color_DarkGray;
    }
    return _separtorLine2;
}


#pragma mark - 构造方法
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.freightView];
        [self.freightView addSubview:self.freightTitle];
        [self.freightView addSubview:self.freightPrice];
        [self.contentView addSubview:self.totalView];
        [self.totalView addSubview:self.totalTitle];
        [self.totalView addSubview:self.totalPrice];
        [self.contentView addSubview:self.messageField];
        [self.freightView addSubview:self.separtorLine1];
        [self.totalView addSubview:self.separtorLine2];
        
        [_freightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top);
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20, 40));
        }];
        
        [_freightTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(self.freightView);
            make.width.equalTo(@(60));
        }];
        
        [_freightPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(self.freightView);
            make.left.equalTo(self.freightTitle.mas_right);
        }];
        
        [_separtorLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.freightView.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20, 1));
            make.bottom.equalTo(self.freightView.mas_bottom);
        }];
        
        [_totalView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(self.freightView);
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.top.equalTo(self.freightView.mas_bottom);
        }];
        
        [_totalTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(self.freightTitle);
            make.left.equalTo(self.totalView.mas_left);
            make.top.equalTo(self.totalView.mas_top);
        }];
        
        [_totalPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(self.freightPrice);
            make.top.equalTo(self.totalView.mas_top);
            make.right.equalTo(self.totalView.mas_right);
        }];
        
        [_separtorLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.totalView.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20, 1));
            make.bottom.equalTo(self.totalView.mas_bottom);
        }];
        
        [_messageField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(self.totalView);
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.top.equalTo(self.totalView.mas_bottom).offset(10);
        }];
    }
    return self;
}

#pragma mark - 传入模型 
- (void)setShopArray:(NSArray<LJKCartItem *> *)shopArray {
    _shopArray = shopArray;

    // 获取运费
    NSString *freight = [[shopArray[0] goods] freight];
    
    double totalOriginPrice = 0;      // 总原价格
    double totalPayPrice = 0;         // 总支付价格
    for (LJKCartItem *item in shopArray) {
        if (item.state == LJKCartItemStateSelected) {
            totalOriginPrice += item.displayOriginPrice * item.number;
            totalPayPrice    += item.displayPrice       * item.number;
        }
    }
    
    // 运费
    if (![freight isEqualToString:@"0"]) { // 有运费
        self.freightPrice.text = [NSString stringWithFormat:@"¥ %@.00", freight];
    } else {
        self.freightPrice.text = @"包邮";
    }
    
    NSString *sumPrice = [NSString stringWithFormat:@"¥ %.1f0", totalPayPrice + [freight doubleValue]];
    self.totalPrice.text = sumPrice;
    
//    // 店铺优惠价格 = 原价 - 实付
//    double promotionPrice = totalOriginPrice - totalPayPrice;
//    if (promotionPrice > 0) { // 有店铺优惠
//        self.totalView.hidden = NO;
//
//        self.shopPromotionLabel.text = [NSString stringWithFormat:@"店铺优惠：%.1f0 元", promotionPrice];
//    } else {
//        self.promotionHeightCon.constant = 0;
//        self.shopPromotionView.hidden = YES;
//    }
    
}

#pragma mark textField 代理
// 停止编辑 后调用
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    !self.leaveMessageBlock ? : self.leaveMessageBlock(textField.text);
    return YES;
}

@end
