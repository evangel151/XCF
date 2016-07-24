//
//  LJKRecipeAddToListCell.m
//  LJKitchen
//
//  Created by  a on 16/7/9.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  Done

#import "LJKRecipeAddToListCell.h"

#import "LJKRecipeList.h"
#import "LJKRecipe.h"
#import "LJKAuthor.h"

#import <Masonry.h>
#import <UIImageView+WebCache.h>

@interface LJKRecipeAddToListCell ()
/** 被加入菜单 - 封面 */
@property (nonatomic, strong) UIImageView *recipeListCover;
/** 被加入菜单 - 主题 */
@property (nonatomic, strong) UILabel *recipeListThemeLabel;
/** 被加入菜单 - 来自 */
@property (nonatomic, strong) UILabel *recipeListFromLabel;
/** 分隔线 */
@property (nonatomic, strong) UIView *separtorLine;
@end

@implementation LJKRecipeAddToListCell

#pragma mark - 懒加载
- (UIImageView *)recipeListCover {
    if (!_recipeListCover) {
        _recipeListCover = [[UIImageView alloc] init];
    }
    return _recipeListCover;
}

- (UILabel *)recipeListThemeLabel {
    if (!_recipeListThemeLabel) {
        _recipeListThemeLabel = [UILabel labelWithTextColor:Color_TintBlack
                                            backgroundColor:Color_Clear
                                                   fontSize:15
                                                      lines:0
                                              textAlignment:NSTextAlignmentLeft];
    }
    return _recipeListThemeLabel;
}

- (UILabel *)recipeListFromLabel {
    if (!_recipeListFromLabel) {
        _recipeListFromLabel = [UILabel labelWithTextColor:Color_DarkGray
                                           backgroundColor:Color_Clear
                                                  fontSize:13
                                                     lines:1
                                             textAlignment:NSTextAlignmentLeft];
    }
    return _recipeListFromLabel;
}

- (UIView *)separtorLine {
    if (!_separtorLine) {
        _separtorLine = [[UIView alloc] init];
        _separtorLine.backgroundColor = Color_DarkGray;
    }
    return _separtorLine;
}


#pragma mark - 构造方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.recipeListCover];
        [self.contentView addSubview:self.recipeListThemeLabel];
        [self.contentView addSubview:self.recipeListFromLabel];
        [self.contentView addSubview:self.separtorLine];
        
        [_recipeListCover mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(55, 70));
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.left.equalTo(self.contentView.mas_left).offset(LJKAuthorIcon2CellLeft);
        }];
        
        [_recipeListThemeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.recipeListCover.mas_top);
            make.left.equalTo(self.recipeListCover.mas_right).offset(LJKAuthorIcon2CellLeft);
            make.right.equalTo(self.contentView.mas_right).offset(-LJKAuthorIcon2CellLeft);
            make.bottom.equalTo(self.contentView.mas_centerY);
        }];
        
        [_recipeListFromLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(self.recipeListThemeLabel);
            make.top.equalTo(self.contentView.mas_centerY);
            make.left.equalTo(self.recipeListThemeLabel.mas_left);
        }];
        
        [_separtorLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.bottom.equalTo(self.contentView.mas_bottom);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 2 * LJKAuthorIcon2CellLeft, 1));
        }];
        
    }
    return self;
}

#pragma mark - 传入模型
- (void)setRecipeList:(LJKRecipeList *)recipeList {
    _recipeList = recipeList;
    
    if (recipeList.first_recipe.photo140.length) {
        [self.recipeListCover sd_setImageWithURL:[NSURL URLWithString:recipeList.first_recipe.photo140]];
    } else {
        self.recipeListCover.image = [UIImage imageNamed:@"defaultUserHeader"];
    }
    
    self.recipeListThemeLabel.text = recipeList.name;
    self.recipeListFromLabel.text = [NSString stringWithFormat:@"来自于:%@", recipeList.author.name];
}

@end
