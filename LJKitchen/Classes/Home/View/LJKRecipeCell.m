//
//  LJKRecipeCell.m
//  LJKitchen
//
//  Created by  a on 16/6/19.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  Done

#import "LJKRecipeCell.h"

#import "LJKRecipe.h"
#import "LJKItems.h"
#import "LJKImage.h"
#import "LJKContent.h"
#import "LJKContents.h"
#import "LJKRecipeStats.h"
#import "LJKAuthor.h"

#import <Masonry.h>
#import <UIImageView+WebCache.h>

@interface LJKRecipeCell ()

/** 首页的主体Cell - 图片 */
@property (nonatomic, strong) UIImageView *image;
/** 首页的主体Cell - 分隔线 */
@property (nonatomic, strong) UIView *separator;
/** 首页的主体Cell - 视频播放按钮 */
@property (nonatomic, strong) UIImageView *videoIcon;
/** 首页的主体Cell - 模板1描述 */
@property (nonatomic, strong) UILabel *descLabel;
/** 首页的主体Cell - 模板1标题 */
@property (nonatomic, strong) UILabel *titleLabel;
/** 首页的主体Cell - 底部描述view(容器) */
@property (nonatomic, strong) UIView *bottomView;

/** 首页的主体Cell - 模板2大标题 */
@property (nonatomic, strong) UILabel *firstTitleLabel;
/** 首页的主体Cell - 模板2小标题 */
@property (nonatomic, strong) UILabel *secondTitleLabel;
/** 首页的主体Cell - 模板4标题 */
@property (nonatomic, strong) UILabel *whisperLabel;
/** 首页的主体Cell - coverView */
@property (nonatomic, strong) UIView *coverView;
/** 首页的主体Cell - 模板5作者头像 */
@property (nonatomic, strong) UIImageView *authorIcon;
/** 首页的主体Cell - 模板5 - 做过该菜谱的人数 */
@property (nonatomic, strong) UILabel *cookedLabel;
/** 首页的主体Cell - 评分 */
@property (nonatomic, strong) UILabel *scoreLabel;
/** 首页的主体Cell - 菜谱作者昵称 */
@property (nonatomic, strong) UILabel *authorName;

/** 独家图标 */
@property (nonatomic, strong) UIButton *exclusiveButton;
/** recipeCell 专用分隔线 */
@property (nonatomic, strong) UIView *separatorLine;

@end

@implementation LJKRecipeCell
#pragma mark - 懒加载
- (UIImageView *)image {
    if (!_image) {
        _image = [[UIImageView alloc] init];
    }
    return _image;
}

- (UIImageView *)videoIcon {
    if (!_videoIcon) {
        _videoIcon = [[UIImageView alloc] init];
        _videoIcon.image = [UIImage imageNamed:@"playButton"];
    }
    return _videoIcon;
}

- (UIView *)coverView {
    if (!_coverView) {
        _coverView = [[UIView alloc] init];
        _coverView.backgroundColor = Color_Cover_Alpha; // 图片半透明遮罩
    }
    return _coverView;
}

- (UILabel *)firstTitleLabel {
    if (!_firstTitleLabel) {
        _firstTitleLabel = [UILabel labelWithTextColor:Color_TintWhite
                                       backgroundColor:Color_Clear
                                              fontSize:20
                                                 lines:0
                                         textAlignment:NSTextAlignmentCenter];
    }
    return _firstTitleLabel;
}

- (UILabel *)secondTitleLabel {
    if (!_secondTitleLabel) {
        _secondTitleLabel = [UILabel labelWithTextColor:Color_TintWhite
                                       backgroundColor:Color_Clear
                                              fontSize:15
                                                 lines:0
                                         textAlignment:NSTextAlignmentCenter];
    }
    return _secondTitleLabel;
}

- (UILabel *)whisperLabel {
    if (!_whisperLabel) {
        _whisperLabel = [UILabel labelWithTextColor:Color_TintWhite
                                    backgroundColor:Color_Clear
                                           fontSize:17
                                              lines:0
                                      textAlignment:NSTextAlignmentCenter];
    }
    return _whisperLabel;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.hidden = YES;
    }
    return _bottomView;
}

- (UIView *)separator {
    if (!_separator) {
        _separator = [[UIView alloc] init];
        _separator.backgroundColor = Color_BackGround;
    }
    return _separator;
}



- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithTextColor:Color_TintBlack
                                   backgroundColor:Color_Clear
                                          fontSize:17
                                             lines:0
                                     textAlignment:NSTextAlignmentLeft];
        
    }
    return _titleLabel;
}

- (UILabel *)descLabel {
    if (!_descLabel) {
        _descLabel = [UILabel labelWithTextColor:Color_TintBlack
                                 backgroundColor:Color_Clear
                                        fontSize:13
                                           lines:0
                                   textAlignment:NSTextAlignmentLeft];
    }
    return _descLabel;
}

- (UILabel *)scoreLabel {
    if (!_scoreLabel) {
        _scoreLabel = [UILabel labelWithTextColor:Color_DarkGray
                                  backgroundColor:Color_Clear
                                         fontSize:12
                                            lines:0
                                    textAlignment:NSTextAlignmentLeft];
    }
    return _scoreLabel;
}

- (UILabel *)authorName {
    if (!_authorName) {
        _authorName = [UILabel labelWithTextColor:Color_DarkGray
                                  backgroundColor:Color_Clear
                                         fontSize:12
                                            lines:1
                                    textAlignment:NSTextAlignmentRight];
    }
    return _authorName;
}

- (UIImageView *)authorIcon {
    if (!_authorIcon) {
        _authorIcon = [[UIImageView alloc] init];
        _authorIcon.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(authorIconClick)];
        [_authorIcon addGestureRecognizer:tap];
    }
    return _authorIcon;
}


- (UILabel *)cookedLabel {
    if (!_cookedLabel) {
        _cookedLabel = [UILabel labelWithTextColor:Color_DarkGray
                                   backgroundColor:Color_Clear
                                          fontSize:12
                                             lines:1
                                     textAlignment:NSTextAlignmentLeft];
    }
    return _cookedLabel;
}

- (UIButton *)exclusiveButton {
    if (!_exclusiveButton) {
        _exclusiveButton = [UIButton createExclusiveButton];
    }
    return _exclusiveButton;
}

- (UIView *)separatorLine {
    if (!_separatorLine) {
        _separatorLine = [[UIView alloc] init];
        _separatorLine.backgroundColor = Color_DarkGray;
    }
    return _separatorLine;
}


#pragma mark - 构造
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
//        self.backgroundColor = Color_BackGround;
        
        // 大图组件
        [self.image addSubview:self.coverView];
        [self.image addSubview:self.videoIcon];
        [self.image addSubview:self.firstTitleLabel];
        [self.image addSubview:self.secondTitleLabel];
        [self.image addSubview:self.whisperLabel];
        [self.image addSubview:self.exclusiveButton];
        
        // 底部视图
        [self.bottomView addSubview:self.descLabel];
        [self.bottomView addSubview:self.titleLabel];
        [self.bottomView addSubview:self.scoreLabel];
        [self.bottomView addSubview:self.authorName];
        [self.bottomView addSubview:self.cookedLabel];
        [self.bottomView addSubview:self.separatorLine];
        
        // 整体构成
        [self.contentView addSubview:self.image];
        [self.contentView addSubview:self.separator];
        [self.contentView addSubview:self.bottomView];
        [self.contentView addSubview:self.authorIcon]; // 头像添加顺序靠后可以防止被其他组件遮掩
        
        
        // Cell 分隔符 （图片距离cell顶部的灰色分隔符）
        [_separator mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top);
            make.left.equalTo(self.contentView.mas_left);
            make.right.equalTo(self.contentView.mas_right);
            make.height.equalTo(@(5));
        }];
        
        
        // Cell主体大图
        [_image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(5);
            make.left.equalTo(self.contentView.mas_left);
            make.right.equalTo(self.contentView.mas_right);
            make.height.equalTo(@(230));
        }];
        
        
        // 大图遮罩
        [_coverView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.image);
        }];
        
        // 大图center 视频Play按钮 (有的话……)
        [_videoIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.image);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
        
        // 独家标志
        [_exclusiveButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(50, 22));
            make.top.equalTo(self.image.mas_top).offset(LJKAuthorIcon2CellTop);
            make.left.equalTo(self.image.mas_left).offset(LJKAuthorIcon2CellLeft);
        }];
        
        // 大图一级标题
        [_firstTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self.image.mas_width).offset(-LJKRecipeCellMarginFirstTitle * 2);
            make.centerX.equalTo(self.image.mas_centerX);
            make.bottom.equalTo(self.image.mas_centerY).offset(-10);
        }];
        
        // 大图二级标题
        [_secondTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self.firstTitleLabel);
            make.centerX.equalTo(self.image.mas_centerX);
            make.top.equalTo(self.firstTitleLabel.mas_bottom).offset(20);
        }];
        
        // 模板4 标题
        [_whisperLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.image);
        }];
        
        // 头像
        [_authorIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(LJKAuthorIconWH, LJKAuthorIconWH));
            make.top.equalTo(self.image.mas_bottom).offset(- LJKAuthorIconWH * 0.35);
            make.right.equalTo(self.contentView.mas_right).offset(-35);
        }];
        
        // 底部视图 (主体)
        [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left);
            make.right.equalTo(self.contentView.mas_right);
            make.top.equalTo(self.image.mas_bottom);
            make.bottom.equalTo(self.descLabel.mas_bottom).offset(LJKRecipeCellMarginTitle);
        }];
        
        // 底部视图 (主标题)
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bottomView.mas_left).offset(LJKRecipeCellMarginTitle);
            make.right.equalTo(self.bottomView.mas_right).offset(-LJKRecipeCellMarginTitle);
            make.top.top.equalTo(self.bottomView.mas_top).offset(LJKRecipeCellMarginTitle2Top);
        }];
        
        // 底部视图 (副标题)
        [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel.mas_left);
            make.right.equalTo(self.titleLabel.mas_right);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(LJKRecipeCellMarginTitle2Desc+5);
        }];
        
        // 底部视图 (评分)
        [_scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(self.cookedLabel);
            make.top.equalTo(self.cookedLabel.mas_top);
            make.left.equalTo(self.cookedLabel.mas_right);
        }];
        
        // 底部视图 (菜谱作者)
        [_authorName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.authorIcon.mas_right);
            make.top.equalTo(self.authorIcon.mas_bottom).offset(1);
        }];
        
        // cooked count （做过的人）
        [_cookedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.descLabel.mas_bottom).offset(5);
            make.left.equalTo(self.descLabel.mas_left);
            make.height.equalTo(@(22));
            // FIXME:(已解决) 布局发生重叠
            // 调整 _cookedLabel & authorName 的位置 已修正
        }];
        
        [_separatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.cookedLabel.mas_bottom).offset(5);
            make.left.equalTo(self.titleLabel.mas_left);
            make.right.equalTo(self.authorName.mas_right);
            make.height.equalTo(@(1));
        }];
    }
    return self;
}


#pragma mark - 传入模型 & 更新布局
- (void)setItem:(LJKItems *)item {
    _item = item;
    
    if (item.contents.image.url) {
        [self.image sd_setImageWithURL:[NSURL URLWithString:item.contents.image.url] placeholderImage:nil];
    }
    
    [self.image mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(item.contents.image.height));
    }];
    
    
    // 隐藏所有控件
    self.firstTitleLabel.hidden = YES;
    self.secondTitleLabel.hidden = YES;
    self.bottomView.hidden = YES;
    self.authorIcon.hidden = YES;
    self.whisperLabel.hidden = YES;
    self.cookedLabel.hidden = YES;
    self.videoIcon.hidden = YES;
    self.descLabel.hidden = YES;
    self.scoreLabel.hidden = YES;
    self.authorName.hidden = YES;
    self.exclusiveButton.hidden = YES;
    self.separatorLine.hidden = YES;

    
    // 根据模板设置控件
    if (item.template == LJKCellTemplateTopic || item.template == LJKCellTemplateRecipe) { // 模板1帖子 或者 模板5菜谱
        self.bottomView.hidden = NO;
        self.descLabel.hidden = NO;
        
        self.descLabel.text = item.contents.desc;
        self.titleLabel.text =  item.contents.title;
        
        
        if (item.template == LJKCellTemplateRecipe) { // 模板5菜谱
            self.videoIcon.hidden = !item.contents.video_url.length;
            self.cookedLabel.hidden = NO;
            self.authorIcon.hidden = NO;
            self.authorName.hidden = NO;
            // FIXME: (已解决）圆形头像 （
            // JSON中虽然有3种不同的头像规格，但是目前只有这一种返回正确的url 尺寸为 160 * 160
            
            [self.authorIcon setCircleIconWithUrl:[NSURL URLWithString:item.contents.author.photo]
                                      placeHolder:@"defaultUserHeader"
                                       cornRadius:80];
            self.authorName.text = item.contents.author.name;
            
            NSString *displayCooked = [NSString stringWithFormat:@"%zd人做过", item.contents.n_cooked];
            CGFloat cookedWidth = [NSString getSizeWithString:displayCooked height:25 font:12].width;
            self.cookedLabel.text = displayCooked;
            [_cookedLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(@(cookedWidth + 5));
            }];
        }
        
    } else if (item.template == LJKCellTemplateRecipeList) { // 模板2菜单
        self.firstTitleLabel.hidden = NO;
        self.secondTitleLabel.hidden = NO;
        self.firstTitleLabel.text = item.contents.title_1st;
        self.secondTitleLabel.text = item.contents.title_2nd;
        
        
    } else if (item.template == LJKCellTemplateDish) { // 模板4作品
        self.whisperLabel.hidden = NO;
        self.whisperLabel.text = item.contents.whisper;
        
    } else if (item.template == LJKCellTemplateWeeklyMagazine) { // 模板6杂志
//        self.bottomView.hidden = YES;
    }
}

- (void)setRecipe:(LJKRecipe *)recipe {
    _recipe = recipe;
    
    self.firstTitleLabel.hidden = YES;
    self.secondTitleLabel.hidden = YES;
    self.whisperLabel.hidden = YES;
    self.separatorLine.hidden = YES;
    self.descLabel.hidden = YES;
    self.authorIcon.hidden = YES;
    self.cookedLabel.hidden = YES;
    self.scoreLabel.hidden= YES;
    self.exclusiveButton.hidden = !recipe.is_exclusive;
    self.videoIcon.hidden = !recipe.video_url.length;
    
    self.bottomView.hidden = NO;
    
    self.titleLabel.text = recipe.name;
    self.authorName.text = recipe.author.name;
    
    if (recipe.stats.n_cooked) {
        self.cookedLabel.hidden = NO;
        self.separatorLine.hidden = NO;
        
        // FIXME:(已解决) 都是n_cooked 一个返回字符串一个返回整型闹哪样啊……
        NSString *displayCooked = [NSString stringWithFormat:@"%@人做过",recipe.stats.n_cooked];
        CGFloat cookedWidth = [NSString getSizeWithString:displayCooked height:25 font:12].width;
        self.cookedLabel.text = displayCooked;
        [_cookedLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(cookedWidth + 5));
        }];

    }
    
    if (recipe.score) {
        self.scoreLabel.hidden = NO;
        self.scoreLabel.text = [NSString stringWithFormat:@" · %@分",recipe.score];
    }
    
    if (recipe.photo80.length) {
        [self.image sd_setImageWithURL:[NSURL URLWithString:recipe.photo80] placeholderImage:nil];
    }
    
    if (recipe.author.photo.length) {
        self.authorIcon.hidden = NO;
        [self.authorIcon setCircleIconWithUrl:[NSURL URLWithString:recipe.author.photo]
                                  placeHolder:@"defaultUserHeader"
                                   cornRadius:80];
    }
    
}


#pragma mark - 头像点击事件block
- (void)authorIconClick {
    !self.authorIconClickedBlock ? : self.authorIconClickedBlock();
};

#pragma mark - useless 
/*
//- (void)setRecipe:(LJKRecipe *)recipe {
//    _recipe = recipe;
//
//    self.firstTitleLabel.hidden = YES;
//    self.secondTitleLabel.hidden = YES;
//    self.whisperLabel.hidden = YES;
//    self.descLabel.hidden = YES;
//    self.bottomView.hidden = NO;
//    self.videoIcon.hidden = !recipe.video_url.length;
////    self.exclusiveButton.hidden = !recipe.is_exclusive;
//
//    // 图片、头像
//    self.image.contentMode = UIViewContentModeScaleToFill;
//    if (recipe.photo80.length) {
//        [self.image sd_setImageWithURL:[NSURL URLWithString:recipe.photo80]];
//    }
//    self.authorIcon.hidden = NO;
//    [self.authorIcon setCircleIconWithUrl:[NSURL URLWithString:recipe.author.photo]
//                              placeHolder:@"defaultUserHeader"
//                               cornRadius:80];
//
//    // 标题、标题行数、设置图片标题右边约束
//    self.titleLabel.text = recipe.name;
//    self.titleLabel.numberOfLines = 1;
//
//    // 作者名称
//    self.authorName.text = recipe.author.name;
//
//    // 做过的人数、调整位置
//    self.cookedLabel.textColor = [UIColor grayColor];
//    self.cookedLabel.text = [NSString stringWithFormat:@"%@人做过", recipe.stats.n_cooked];
//
//    self.scoreLabel.hidden = YES;
//    // 分数、如果没有更新约束
//    if (recipe.score.length) {
//        self.scoreLabel.hidden = NO;
//        self.scoreLabel.text = [NSString stringWithFormat:@"%@分", recipe.score];
//    } else {
//        // 未知情况
//    }
//}
*/
@end
