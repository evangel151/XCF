//
//  LJKOrderPromotionCell.m
//  LJKitchen
//
//  Created by  a on 16/7/13.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  订单 - 优惠信息

#import "LJKOrderPromotionCell.h"
#import <Masonry.h>

@interface LJKOrderPromotionCell ()

/** 优惠信息 - logo */
@property (nonatomic, strong) UIImageView *iconView;
/** 优惠信息 - 说明 */
@property (nonatomic, strong) UILabel *iconDescLabel;
/** 优惠信息 - 优惠券数量 */
@property (nonatomic, strong) UILabel *promotionCountLabel;
/** 优惠信息 - 优惠券细节 */
@property (nonatomic, strong) UILabel *promotionDetailLabel;
/** 优惠信息 - 指示 >  */
@property (nonatomic, strong) UIImageView *arrow;

@end

@implementation LJKOrderPromotionCell

#pragma mark - 懒加载
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
                                            fontSize:15 lines:1
                                       textAlignment:NSTextAlignmentLeft];
        _iconDescLabel.text = @"优惠";
    }
    return _iconDescLabel;
}

- (UILabel *)promotionCountLabel {
    if (!_promotionCountLabel) {
        _promotionCountLabel = [UILabel labelWithTextColor:Color_TintWhite
                                           backgroundColor:Color_ThemeColor
                                                  fontSize:15 lines:1
                                             textAlignment:NSTextAlignmentCenter];
        _promotionCountLabel.text = @"0张可用";
    }
    return _promotionCountLabel;
}

- (UILabel *)promotionDetailLabel {
    if (!_promotionDetailLabel) {
        _promotionDetailLabel = [UILabel labelWithTextColor:Color_TintBlack
                                            backgroundColor:Color_Clear
                                                   fontSize:15 lines:1
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

#pragma mark - 构造方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.iconDescLabel];
        [self.contentView addSubview:self.promotionCountLabel];
        [self.contentView addSubview:self.promotionDetailLabel];
        [self.contentView addSubview:self.arrow];
        
        [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
        
        [_iconDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.left.equalTo(self.iconView.mas_right);
            make.size.mas_equalTo(CGSizeMake(50, 30));
        }];
        
        [_promotionCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(100, 30));
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.left.equalTo(self.iconDescLabel.mas_right);
        }];
        
        [_arrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(16, 24));
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
        }];
        
        [_promotionDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.right.equalTo(self.arrow.mas_left).offset(-10);
            make.height.equalTo(@(30));
            make.left.equalTo(self.promotionCountLabel.mas_right);
        }];
    }
    return self;
}
@end
