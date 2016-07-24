//
//  LJKRecipeViewHeader.m
//  LJKitchen
//
//  Created by  a on 16/7/7.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  Done 

#import "LJKRecipeViewHeader.h"

#import "LJKRecipe.h"
#import "LJKAuthor.h"
#import "LJKRecipeStats.h"

#import <UIImageView+WebCache.h>
#import <Masonry.h>

@interface LJKRecipeViewHeader ()
/** header - 顶部图片 */
@property (nonatomic, strong) UIImageView *mainImageView;
/** header - 菜谱名称 */
@property (nonatomic, strong) UILabel *recipeNameLabel;
/** header - 用户独家菜谱(图标) */
@property (nonatomic, strong) UIButton *exclusiveButton;
/** header - 综合评分 */
@property (nonatomic, strong) UILabel *scoreLabel;
/** header - 做过的人(7天内) */
@property (nonatomic, strong) UILabel *cookedLabel;
/** header - 分割线 */
@property (nonatomic, strong) UIView *separtorLine;
/** header - 菜谱详情 */
@property (nonatomic, strong) UILabel *recipeDescLabel;
/** header - 用户头像 */
@property (nonatomic, strong) UIImageView *authorIconView;
/** header - 用户姓名 */
@property (nonatomic, strong) UILabel *authorNameLabel;
/** 认证厨师标志 */
@property (nonatomic, strong) UIButton *cookMasterIcon;
/** header - 菜谱创建时间 */
@property (nonatomic, strong) UILabel *recipeCreatedTimeLabel;
/** header - 收藏(取消收藏)按钮 */
@property (nonatomic, strong) UIButton *collectButton;
/** header - 丢进菜篮子(取消)按钮 */
@property (nonatomic, strong) UIButton *putInBasketButton;



@end

@implementation LJKRecipeViewHeader

- (UIImageView *)mainImageView {
    if (!_mainImageView) {
        _mainImageView = [[UIImageView alloc] init];
    }
    return _mainImageView;
}

- (UILabel *)recipeNameLabel {
    if (!_recipeNameLabel) {
        _recipeNameLabel = [UILabel labelWithTextColor:Color_TintBlack
                                       backgroundColor:Color_Clear
                                              fontSize:20
                                                 lines:0
                                         textAlignment:NSTextAlignmentCenter];
    }
    return _recipeNameLabel;
}

- (UIButton *)exclusiveButton {
    if (!_exclusiveButton) {
        _exclusiveButton = [UIButton createExclusiveButton];
    }
    return _exclusiveButton;
}

- (UILabel *)scoreLabel {
    if (!_scoreLabel) {
        _scoreLabel = [UILabel labelWithTextColor:Color_DarkGray
                                  backgroundColor:Color_Clear
                                         fontSize:12
                                            lines:1
                                    textAlignment:NSTextAlignmentCenter];
    }
    return _scoreLabel;
}

- (UILabel *)cookedLabel {
    if (!_cookedLabel) {
        _cookedLabel = [UILabel labelWithTextColor:Color_DarkGray
                                   backgroundColor:Color_Clear
                                          fontSize:12
                                             lines:1
                                     textAlignment:NSTextAlignmentCenter];
    }
    return _cookedLabel;
}

- (UIView *)separtorLine {
    if (!_separtorLine) {
        _separtorLine = [[UIView alloc] init];
        _separtorLine.backgroundColor = Color_DarkGray;
    }
    return _separtorLine;
}

- (UILabel *)recipeDescLabel {
    if (!_recipeDescLabel) {
        _recipeDescLabel = [UILabel labelWithTextColor:Color_TintBlack
                                       backgroundColor:Color_Clear
                                              fontSize:15
                                                 lines:0
                                         textAlignment:NSTextAlignmentLeft];
    }
    return _recipeDescLabel;
}

- (UIImageView *)authorIconView {
    if (!_authorIconView) {
        _authorIconView = [[UIImageView alloc] init];
        _authorIconView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapAuthorIcon = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                        action:@selector(authorIconDidClicked:)];
        [_authorIconView setTag:11];
        [_authorIconView addGestureRecognizer:tapAuthorIcon];
        
    }
    return _authorIconView;
}

- (UILabel *)authorNameLabel {
    if (!_authorNameLabel) {
        _authorNameLabel = [UILabel labelWithTextColor:Color_TintBlack
                                       backgroundColor:Color_Clear
                                              fontSize:12
                                                 lines:1
                                         textAlignment:NSTextAlignmentCenter];
    }
    return _authorNameLabel;
}

- (UIButton *)cookMasterIcon {
    if (!_cookMasterIcon) {
        _cookMasterIcon = [UIButton buttonWithImageName:@"userIsExpertIcon28x28"
                                       disableImageName:@"userIsExpertIcon28x28"
                                                 target:nil
                                                 action:nil];
    }
    return _cookMasterIcon;
}



- (UILabel *)recipeCreatedTimeLabel {
    if (!_recipeCreatedTimeLabel) {
        _recipeCreatedTimeLabel = [UILabel labelWithTextColor:Color_DarkGray
                                              backgroundColor:Color_Clear
                                                     fontSize:12
                                                        lines:1
                                                textAlignment:NSTextAlignmentCenter];
    }
    return _recipeCreatedTimeLabel;
}

- (UIButton *)collectButton {
    if (!_collectButton) {
        _collectButton = [UIButton buttonWithTitleNormal:@"收藏"
                                           titleSelected:@"取消收藏"
                                              titleColor:Color_TintWhite
                               normalBackgroundImageName:@"exit_Button"
                             selectedBackgroundImageName:@"cancel_Button"
                                                  target:self
                                                  action:@selector(collectButtonDidClicked:)];
        _collectButton.tag = 12;
    }
    return _collectButton;
}

- (UIButton *)putInBasketButton {
    if (!_putInBasketButton) {
        _putInBasketButton = [UIButton buttonWithTitleNormal:@"丢进菜篮子"
                                               titleSelected:@"取消"
                                                  titleColor:Color_TintWhite
                                   normalBackgroundImageName:@"exit_Button"
                                 selectedBackgroundImageName:@"cancel_Button"
                                                      target:self
                                                      action:@selector(basketButtonDidClicked:)];
        _putInBasketButton.tag = 13;
    }
    return _putInBasketButton;
}


#pragma mark - 构造方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = Color_TintWhite;
        
        [self addSubview:self.mainImageView];
        [self addSubview:self.recipeNameLabel];
        [self addSubview:self.exclusiveButton];
        [self addSubview:self.scoreLabel];
        [self addSubview:self.cookedLabel];
        [self addSubview:self.separtorLine];
        [self addSubview:self.recipeDescLabel];
        [self addSubview:self.authorIconView];
        [self addSubview:self.authorNameLabel];
        [self addSubview:self.cookMasterIcon];
        [self addSubview:self.recipeCreatedTimeLabel];
        [self addSubview:self.collectButton];
        [self addSubview:self.putInBasketButton];
        
        // 顶部图片
        [_mainImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.left.equalTo(self.mas_left);
            // 按照250宽度基数进行计算图片size (适配)
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH * 0.6));
        }];
        
        // 菜谱名称
        [_recipeNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(self.mainImageView.mas_bottom).offset(2 * LJKAuthorIcon2CellTop);
        }];
        
        // “独家标志”
        [_exclusiveButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(self.recipeNameLabel.mas_bottom).offset(LJKAuthorIcon2CellTop);
            make.size.mas_equalTo(CGSizeMake(40, 20));
        }];
        
        // 综合评分
        [_scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.exclusiveButton.mas_bottom).offset(LJKAuthorIcon2CellTop);
            make.right.equalTo(self.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH * 0.5 - 50, LJKRecipeListViewHeightAuthorName));
        }];
        
        // 做过的人(7天内)
        [_cookedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.scoreLabel.mas_top);
            make.size.mas_equalTo(self.scoreLabel);
            make.left.equalTo(self.scoreLabel.mas_right);
        }];
        
        // 分割线
        [_separtorLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 2 * LJKAuthorIcon2CellLeft, 1));
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(self.scoreLabel.mas_bottom).offset(LJKAuthorIcon2CellTop);
        }];
        
        // 菜谱简介
        [_recipeDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.separtorLine.mas_bottom).offset(LJKAuthorIcon2CellTop);
            make.left.equalTo(self.mas_left).offset(LJKAuthorIcon2CellLeft);
            make.right.equalTo(self.mas_right).offset(-LJKAuthorIcon2CellLeft);
        }];
        
        // 作者头像
        [_authorIconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(self.recipeDescLabel.mas_bottom).offset(2 * LJKAuthorIcon2CellTop);
            make.size.mas_equalTo(CGSizeMake(LJKAuthorIconsWH, LJKAuthorIconsWH));
        }];
        
        // 作者姓名
        [_authorNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.authorIconView.mas_bottom).offset(LJKAuthorIcon2CellTop);
            make.centerX.equalTo(self.mas_centerX);
            make.height.equalTo(@(LJKRecipeListViewHeightAuthorName));
        }];
        
        // 认证厨师标志
        [_cookMasterIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(LJKRecipeListViewHeightAuthorName, LJKRecipeListViewHeightAuthorName));
            make.centerY.equalTo(self.authorNameLabel.mas_centerY);
            make.left.equalTo(self.authorNameLabel.mas_right).offset(3);
        }];
        
        // 菜谱创建时间
        [_recipeCreatedTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.authorNameLabel.mas_bottom).offset(LJKAuthorIcon2CellTop);
            make.centerX.equalTo(self.mas_centerX);
            make.height.equalTo(@(LJKRecipeListViewHeightAuthorName));
        }];
        
        // 收藏按钮
        CGFloat buttonW = (SCREEN_WIDTH - 3 * LJKAuthorIcon2CellLeft) / 2;
        [_collectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(buttonW, LJKRecipeListViewHeightCollectButton));
            make.top.equalTo(self.recipeCreatedTimeLabel.mas_bottom).offset(30);
            make.left.equalTo(self.mas_left).offset(LJKAuthorIcon2CellLeft);
        }];
        
        // 丢进菜篮子
        [_putInBasketButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(self.collectButton);
            make.top.equalTo(self.collectButton.mas_top);
            make.right.equalTo(self.mas_right).offset(-LJKAuthorIcon2CellLeft);
        }];
        
        
    }
    return self;
}

#pragma mark - 传入模型
- (void)setRecipe:(LJKRecipe *)recipe {
    _recipe = recipe;
    self.recipeNameLabel.text = recipe.name;
    self.recipeDescLabel.text = recipe.desc;
    self.authorNameLabel.text = recipe.author.name;
    self.recipeCreatedTimeLabel.text = [NSString stringWithFormat:@"创建于%@",recipe.create_time];
    [self.mainImageView sd_setImageWithURL:[NSURL URLWithString:recipe.photo]];
    self.scoreLabel.text = [NSString stringWithFormat:@"%@综合评分",recipe.score];
    [self.authorIconView setCircleIconWithUrl:[NSURL URLWithString:recipe.author.photo]
                                 placeHolder:@"defaultUserHeader"
                                  cornRadius:85];
    
    if (recipe.stats.n_cooked.length) {
        self.cookedLabel.text = [NSString stringWithFormat:@"%@人做过",recipe.stats.n_cooked];
    } else {
        self.cookedLabel.hidden = YES;
        [_scoreLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.exclusiveButton.mas_bottom).offset(LJKAuthorIcon2CellTop);
            make.centerX.equalTo(self.mas_centerX);
            make.height.equalTo(@(LJKRecipeListViewHeightAuthorName));
        }];
    }
    
    if (!recipe.is_exclusive) { // 非独家菜谱
        // 暂时先不更新 BOOL is_exclusive 的布局了
//        self.exclusiveButton.hidden = YES;
//        [_scoreLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.authorIconView.mas_bottom).offset(LJKAuthorIcon2CellTop);
//            make.centerX.equalTo(self.mas_centerX);
//            make.height.equalTo(@(LJKRecipeListViewHeightAuthorName));
//        }];
    }
    
    if (!recipe.author.is_expert) {
        self.cookMasterIcon.hidden = YES;
    }
    

    
}

#pragma mark - 点击事件
// !!!:因为一开始block不回传，所以写的麻烦了一点用来测试……万幸能用，先凑合用
- (void)authorIconDidClicked:(id)sender {
    UITapGestureRecognizer *tap = (UITapGestureRecognizer *)sender;
    !self.clickedBlock ? : self.clickedBlock(tap.view.tag);
}

- (void)collectButtonDidClicked:(UIButton *)button {
    button.selected = !button.selected;
    !self.clickedBlock ? : self.clickedBlock(button.tag);
}

- (void)basketButtonDidClicked:(UIButton *)button {
    button.selected = !button.selected;
    !self.clickedBlock ? : self.clickedBlock(button.tag);
}
@end
