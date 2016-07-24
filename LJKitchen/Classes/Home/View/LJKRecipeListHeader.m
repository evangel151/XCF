//
//  LJKRecipeListHeader.m
//  LJKitchen
//
//  Created by  a on 16/7/5.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKRecipeListHeader.h"
#import "LJKRecipeList.h"
#import "LJKAuthor.h"

#import <Masonry.h>

@interface LJKRecipeListHeader ()
/** 菜单(专辑) - header - 标题 */
@property (nonatomic, strong) UILabel *recipeTitleLabel;
/** 菜单(专辑) - header - (专辑)作者 */
@property (nonatomic, strong) UILabel *recipeMakerLabel;
/** 菜单(专辑) - header - 菜单描述 */
@property (nonatomic, strong) UILabel *recipeDescLabel;
/** 菜单(专辑) - header - “收藏”按钮 */
@property (nonatomic, strong) UIButton *collectButton;
@end

@implementation LJKRecipeListHeader


#pragma mark - 懒加载
- (UILabel *)recipeTitleLabel {
    if (!_recipeTitleLabel) {
        _recipeTitleLabel = [UILabel labelWithTextColor:Color_TintBlack
                                        backgroundColor:Color_Clear
                                               fontSize:17
                                                  lines:0
                                          textAlignment:NSTextAlignmentCenter];
    }
    return _recipeTitleLabel;
}

- (UILabel *)recipeMakerLabel {
    if (!_recipeMakerLabel) {
        _recipeMakerLabel = [UILabel labelWithTextColor:Color_ThemeColor
                                        backgroundColor:Color_Clear
                                               fontSize:13
                                                  lines:1
                                          textAlignment:NSTextAlignmentCenter];
        UITapGestureRecognizer *tapAuhor = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                   action:@selector(auhorNameLabelDidClicked)];
        [_recipeMakerLabel addGestureRecognizer:tapAuhor];
    }
    return _recipeMakerLabel;
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

- (UIButton *)collectButton {
    if (!_collectButton) {
        _collectButton = [UIButton buttonWithTitleNormal:@"收藏"
                                           titleSelected:@"取消收藏"
                                              titleColor:Color_TintWhite
                               normalBackgroundImageName:@"exit_Button"
                             selectedBackgroundImageName:@"cancel_Button"
                                                  target:self
                                                  action:@selector(collectButtonDidClicked:)];
        }
    return _collectButton;
}

#pragma mark - 构造方法

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.collectButton];
        [self addSubview:self.recipeTitleLabel];
        [self addSubview:self.recipeMakerLabel];
        [self addSubview:self.recipeDescLabel];
        
        [_recipeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(LJKAuthorIcon2CellLeft);
            make.top.equalTo(self.mas_top).offset(LJKAuthorIcon2CellTop * 2);
            make.right.equalTo(self.mas_right).offset(-LJKAuthorIcon2CellLeft);
        }];
        
        [_recipeMakerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.recipeTitleLabel.mas_centerX);
            make.top.equalTo(self.recipeTitleLabel.mas_bottom).offset(LJKAuthorIcon2CellTop);
            make.height.equalTo(@(25));
        }];
        
        [_recipeDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.recipeTitleLabel.mas_centerX);
            make.width.equalTo(self.recipeTitleLabel.mas_width);
            make.top.equalTo(self.recipeMakerLabel).offset(4 * LJKAuthorIcon2CellTop);
        }];
        
        [_collectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.recipeTitleLabel.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH / 3, 30));
            make.top.equalTo(self.recipeDescLabel.mas_bottom).offset(20);
        }];
    }
    return self;
}

#pragma mark - 模型传入
- (void)setRecipeList:(LJKRecipeList *)recipeList {
    _recipeList = recipeList;

    self.recipeTitleLabel.text = recipeList.name;
    NSString *displayAuthorName = [NSString stringWithFormat:@"来自：%@", recipeList.author.name];
    [self.recipeMakerLabel setAttributeTextWithString:displayAuthorName
                                                range:NSMakeRange(3, recipeList.author.name.length)];

    CGFloat titleHeight = [NSString getSizeWithString:recipeList.name width:SCREEN_WIDTH - 40 font:17].height;
    CGFloat descHeight  = [NSString getSizeWithString:recipeList.desc width:SCREEN_WIDTH - 40 font:15].height;
    
    if (recipeList.desc.length) {
        self.recipeDescLabel.text = recipeList.desc;
    } else {
        [_collectButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.recipeMakerLabel.mas_bottom).offset(10);
        }];
    }
    
    [_recipeTitleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(titleHeight + 5));
    }];
    
    [_recipeDescLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(descHeight + 5));
    }];
}

#pragma mark - 点击事件 
- (void)collectButtonDidClicked:(UIButton *)button {
    button.selected = !button.selected;
    !self.recipeHeaderActionBlock ? : self.recipeHeaderActionBlock(RecipeHeaderActionCollected);
}

- (void)auhorNameLabelDidClicked {
    !self.recipeHeaderActionBlock ? : self.recipeHeaderActionBlock(RecipeHeaderActionAuthorName);
}

@end
