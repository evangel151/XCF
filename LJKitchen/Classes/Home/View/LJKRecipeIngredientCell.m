//
//  LJKRecipeIngredientCell.m
//  LJKitchen
//
//  Created by  a on 16/7/8.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  Done 

#import "LJKRecipeIngredientCell.h"
#import "LJKRecipeIngredient.h"

#import <Masonry.h>

@interface LJKRecipeIngredientCell ()
/** 菜谱用料 - 名称 */
@property (nonatomic, strong) UILabel *nameLabel;
/** 菜谱用料 - 用料数量 */
@property (nonatomic, strong) UILabel *amountLabel;
@end

@implementation LJKRecipeIngredientCell
#pragma mark - 懒加载
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel labelWithTextColor:Color_TintBlack
                                 backgroundColor:Color_Clear
                                        fontSize:17
                                           lines:1
                                   textAlignment:NSTextAlignmentLeft];
    }
    return _nameLabel;
}

- (UILabel *)amountLabel {
    if (!_amountLabel) {
        _amountLabel = [UILabel labelWithTextColor:Color_TintBlack
                                   backgroundColor:Color_Clear
                                          fontSize:17
                                             lines:1
                                     textAlignment:NSTextAlignmentRight];
    }
    return _amountLabel;
}


#pragma mark - 构造方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.amountLabel];
        
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(7);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-7);
            make.left.equalTo(self.contentView.mas_left).offset(LJKAuthorIcon2CellLeft);
            make.right.equalTo(self.contentView.mas_centerX);
        }];
        
        [_amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(self.nameLabel);
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.right.equalTo(self.contentView.mas_right).offset(-LJKAuthorIcon2CellLeft);
        }];
    }
    return self;
}

#pragma mark - 传入模型
- (void)setIngredient:(LJKRecipeIngredient *)ingredient {
    _ingredient = ingredient;
    
    self.nameLabel.text = ingredient.name;
    self.amountLabel.text = ingredient.amount;
    
    if (ingredient.state == LJKIngredientStatePurchased) {
        self.nameLabel.textColor = Color_DarkGray;
        self.amountLabel.textColor = Color_DarkGray;
    }
}

#pragma mark - cell点击回调
- (void)cellDidClicked {
    !self.cellDidClickedBlock ? : self.cellDidClickedBlock();
}

@end
