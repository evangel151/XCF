//
//  LJKRecipeTipsCell.m
//  LJKitchen
//
//  Created by  a on 16/7/8.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKRecipeTipsCell.h"
#import "LJKRecipe.h"

#import <Masonry.h>

@interface LJKRecipeTipsCell ()
@property (nonatomic, strong) UILabel *tipsLabel;
@end

@implementation LJKRecipeTipsCell

#pragma mark - 懒加载
- (UILabel *)tipsLabel {
    if (!_tipsLabel) {
        _tipsLabel = [UILabel labelWithTextColor:Color_TintBlack
                                 backgroundColor:Color_Clear
                                        fontSize:15
                                           lines:0
                                   textAlignment:NSTextAlignmentLeft];
    }
    return _tipsLabel;
}

#pragma mark - 构造方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.tipsLabel];
        
        [_tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.width.equalTo(@(SCREEN_WIDTH - 2 * LJKAuthorIcon2CellLeft));
            make.top.equalTo(self.contentView.mas_top).offset(LJKAuthorIcon2CellTop);
        }];
    }
    return self;
}

#pragma mark - 传入模型
- (void)setRecipe:(LJKRecipe *)recipe {
    _recipe = recipe;
    self.tipsLabel.text = recipe.tips;
}

@end
