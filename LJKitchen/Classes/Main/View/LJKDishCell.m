//
//  LJKDishCell.m
//  LJKitchen
//
//  Created by  a on 16/7/10.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  Done

#import "LJKDishCell.h"

#import "LJKDish.h"
#import "LJKAuthor.h"
#import "LJKReview.h"
#import "LJKReviewPhoto.h"

#import <Masonry.h>
#import <UIImageView+WebCache.h>

@interface LJKDishCell ()
/** 展示 - 主图 */
@property (nonatomic, strong) UIImageView *mainImageView;
/** 展示 - 作者头像 */
@property (nonatomic, strong) UIImageView *authorIconView;
/** 展示 - 作者姓名 */
@property (nonatomic, strong) UILabel *authorNameLabel;
/** 展示 - 描述:(作品描述 or 商品评论) */
@property (nonatomic, strong) UILabel *descLabel;
/** 展示 - 点赞按钮 (仅供作品展示时使用) */
@property (nonatomic, strong) UIButton *diggsButton;
/** 展示 - 创建时间 */
@property (nonatomic, strong) UIButton *createdTimeButton;

@end

@implementation LJKDishCell

- (UIImageView *)mainImageView {
    if (!_mainImageView) {
        _mainImageView = [[UIImageView alloc] init];
        _mainImageView.layer.cornerRadius = 5; // 图片也设置和cell一样的圆角
    }
    return _mainImageView;
}

- (UIImageView *)authorIconView {
    if (!_authorIconView) {
        _authorIconView = [[UIImageView alloc] init];
        _authorIconView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapIcon = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(authorIconDidClicked)];
        [_authorIconView addGestureRecognizer:tapIcon];
    }
    return _authorIconView;
}

- (UILabel *)authorNameLabel {
    if (!_authorNameLabel) {
        _authorNameLabel = [UILabel labelWithTextColor:Color_DarkGray
                                       backgroundColor:Color_Clear
                                              fontSize:13
                                                 lines:1
                                         textAlignment:NSTextAlignmentLeft];
    }
    return _authorNameLabel;
}

- (UILabel *)descLabel {
    if (!_descLabel) {
        _descLabel = [UILabel labelWithTextColor:Color_TintBlack
                                 backgroundColor:Color_Clear
                                        fontSize:15
                                           lines:0
                                   textAlignment:NSTextAlignmentLeft];
    }
    return _descLabel;
}

- (UIButton *)createdTimeButton {
    if (!_createdTimeButton) {
        _createdTimeButton = [UIButton buttonWithBackgroundColor:Color_Black_Alpha
                                                           title:@"Time"
                                                        fontSize:10
                                                      titleColor:Color_TintWhite
                                                          target:self
                                                          action:nil
                                                   clipsToBounds:YES];
    }
    return _createdTimeButton;
}

- (UIButton *)diggsButton {
    if (!_diggsButton) {
        _diggsButton = [UIButton buttonWithImageName:@"dishPagerLike"
                                   selectedImageName:@"dishPagerLiked"
                                              target:self
                                              action:@selector(diggsBUttonDidClicked:)];
        [_diggsButton setTitleColor:Color_DarkGray forState:UIControlStateNormal];
        [_diggsButton setTitleColor:Color_ThemeColor forState:UIControlStateSelected];
        
    }
    return _diggsButton;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self.contentView addSubview:self.mainImageView];
        [self.mainImageView addSubview:self.createdTimeButton];
        [self.contentView addSubview:self.authorNameLabel];
        [self.contentView addSubview:self.descLabel];
        [self.contentView addSubview:self.diggsButton];
        [self.contentView addSubview:self.authorIconView];
        
        CGFloat tempCellWidth = SCREEN_WIDTH * 0.6;
        CGFloat mainImageWH = tempCellWidth - 20;
        [_mainImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(LJKAuthorIcon2CellTop);
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(mainImageWH, mainImageWH));
        }];
        
        [_createdTimeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mainImageView.mas_top).offset(LJKAuthorIcon2CellTop);
            make.left.equalTo(self.mainImageView.mas_left).offset(LJKAuthorIcon2CellLeft);
            make.height.equalTo(@(15));
        }];
        
        [_authorNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mainImageView.mas_left);
            make.top.equalTo(self.mainImageView.mas_bottom).offset(LJKAuthorIcon2CellLeft);
            make.right.equalTo(self.mainImageView.mas_right);
            make.height.equalTo(@(20));
        }];
        
        [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.authorNameLabel.mas_bottom).offset(LJKAuthorIcon2CellTop);
            make.left.equalTo(self.mainImageView.mas_left);
            make.right.equalTo(self.mainImageView.mas_right);
        }];
        
        [_diggsButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(80, 40));
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
        }];
        
        [_authorIconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(LJKAuthorIconWH, LJKAuthorIconWH));
            make.centerY.equalTo(self.mainImageView.mas_bottom);
            make.right.equalTo(self.mainImageView.mas_right).offset(-30);
        }];
        
        
    }
    return self;
}

#pragma mark - 传入模型
- (void)setDish:(LJKDish *)dish {
    _dish = dish;
    
    [self.mainImageView sd_setImageWithURL:[NSURL URLWithString:dish.thumbnail_160]
                          placeholderImage:[UIImage imageNamed:@"loading"]];
    
    [self.createdTimeButton setTitle:dish.friendly_create_time forState:UIControlStateNormal];
    CGFloat timeBtnWidth = [NSString getSizeWithString:dish.friendly_create_time height:15 font:10].width + 10;
    [_createdTimeButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(timeBtnWidth));
    }];
    
    if (dish.author.hometown_location.length) {
        self.authorNameLabel.text = [NSString stringWithFormat:@"%@(%@)",dish.author.name,dish.author.hometown_location];
    } else {
        self.authorNameLabel.text = dish.author.name;
    }
    
    [self.authorIconView setCircleIconWithUrl:[NSURL URLWithString:dish.author.photo]
                                  placeHolder:@"defaultUserHeader"
                                   cornRadius:85];
    
    self.descLabel.text = dish.desc;
    // 20 == padding
    CGFloat descLabelWidth = SCREEN_WIDTH * 0.6 - 20;
    CGFloat descLabelHeight = [NSString getSizeWithString:dish.desc width:descLabelWidth font:15].height;
    CGFloat descMaxH = (SCREEN_HEIGHT * 0.5 + 25) - (descLabelWidth + 10) - 50 - 45;
    if (descLabelHeight < descMaxH) {
        [_descLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(descLabelHeight));
        }];
    } else {
        [_descLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(descMaxH - 20));
        }];
    }
    
    if (dish.digged_by_me) {
        self.diggsButton.selected = dish.digged_by_me;
    }
    
    [self.diggsButton setTitle:dish.ndiggs forState:UIControlStateNormal];
    [self.diggsButton setTitle:[NSString stringWithFormat:@"%zd", ([dish.ndiggs integerValue] + 1)]
                      forState:UIControlStateSelected];
    
    
}


- (void)setReview:(LJKReview *)review {
    _review = review;
    
    [self.mainImageView sd_setImageWithURL:[NSURL URLWithString:review.photos[0].url]];
    
    CGFloat timeBtnWidth = [NSString getSizeWithString:review.friendly_create_time height:15 font:10].width + 10;
    [_createdTimeButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(timeBtnWidth));
    }];
    [self.createdTimeButton setTitle:review.friendly_create_time forState:UIControlStateNormal];
    
    [self.authorIconView setCircleIconWithUrl:[NSURL URLWithString:review.author.photo60]
                                  placeHolder:@"defaultUserHeader"
                                   cornRadius:85];
    
    // 如果是商品展示 -> 更新用户头像 + 姓名栏 布局
    // update会报警告……暂时没找到是哪约束重复了 改用remake后正常了
    [_authorIconView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(LJKAuthorIconWH, LJKAuthorIconWH));
        make.centerY.equalTo(self.mainImageView.mas_bottom);
        make.centerX.equalTo(self.mainImageView.mas_centerX);
    }];
    
    
    [_authorNameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(20));
        make.top.equalTo(self.authorIconView.mas_bottom).offset(10);
        make.left.right.equalTo(self.mainImageView);
    }];
    
    self.authorNameLabel.text = review.author.name;
    self.authorNameLabel.textColor = Color_TintBlack;
    self.authorNameLabel.textAlignment = NSTextAlignmentCenter;
    
    self.descLabel.numberOfLines = 3; // 最多三行
    self.descLabel.text = review.review;
    
    self.diggsButton.hidden = YES;
}

#pragma mark - 点击事件
- (void)authorIconDidClicked {
    !self.authorIconClickedBlock ? : self.authorIconClickedBlock();
}

- (void)diggsBUttonDidClicked:(UIButton *)button {
    button.selected = !button.selected;
    !self.diggsButtonClickedBlock ? : self.diggsButtonClickedBlock(button);
}
@end
