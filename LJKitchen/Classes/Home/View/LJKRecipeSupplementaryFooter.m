//
//  LJKRecipeSupplementaryFooter.m
//  LJKitchen
//
//  Created by  a on 16/7/9.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  Done

#import "LJKRecipeSupplementaryFooter.h"
#import "LJKRecipeStats.h"
#import "LJKRecipe.h"

#import <Masonry.h>

@interface LJKRecipeSupplementaryFooter ()

/** 菜谱追加描述 - 评论数 */
@property (nonatomic, strong) UILabel *commentsLabel;
/** 菜谱追加描述 - 相同喜好(喜欢这道菜的人还喜欢) */
@property (nonatomic, strong) UILabel *sameHobbyLabel;
/** 菜谱追加描述 - 举报 */
@property (nonatomic, strong) UILabel *reportLabel;

/** 菜谱追加描述 - 分隔线 */
@property (nonatomic, strong) UIView *separtorLine1;
@property (nonatomic, strong) UIView *separtorLine2;

@end

@implementation LJKRecipeSupplementaryFooter

- (UILabel *)commentsLabel {
    if (!_commentsLabel) {
        _commentsLabel = [UILabel labelWithTextColor:Color_ThemeColor
                                     backgroundColor:Color_Clear
                                            fontSize:17
                                               lines:1
                                       textAlignment:NSTextAlignmentLeft];
        _commentsLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapComment = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(comments)];
        [_commentsLabel addGestureRecognizer:tapComment];
        _commentsLabel.text = @"测试数据:999条留言"; // 测试数据
    }
    return _commentsLabel;
}

- (UILabel *)sameHobbyLabel {
    if (!_sameHobbyLabel) {
        _sameHobbyLabel = [UILabel labelWithTextColor:Color_ThemeColor
                                      backgroundColor:Color_Clear
                                             fontSize:17
                                                lines:1
                                        textAlignment:NSTextAlignmentLeft];
        UITapGestureRecognizer *tapHobby = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                   action:@selector(hobby)];
        [_sameHobbyLabel addGestureRecognizer:tapHobby];
        _sameHobbyLabel.userInteractionEnabled = YES;
        _sameHobbyLabel.text = @"喜欢这道菜的人也喜欢";
    }
    return _sameHobbyLabel;
}

- (UILabel *)reportLabel {
    if (!_reportLabel) {
        _reportLabel = [UILabel labelWithTextColor:Color_DarkGray
                                   backgroundColor:Color_Clear
                                          fontSize:15
                                             lines:1
                                     textAlignment:NSTextAlignmentLeft];
        UITapGestureRecognizer *tapReport = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(report)];
        [_reportLabel addGestureRecognizer:tapReport];
        _reportLabel.userInteractionEnabled = YES;
        _reportLabel.text = @"举报此菜谱";
    }
    return _reportLabel;
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
        // !!!: HeaderFooter 背景颜色设置已调整
        // Setting the background color on UITableViewHeaderFooterView has been deprecated. Please use contentView.backgroundColor instead.
        self.contentView.backgroundColor = Color_TintWhite;
        
        [self.contentView addSubview:self.commentsLabel];
        [self.contentView addSubview:self.separtorLine1];
        [self.contentView addSubview:self.sameHobbyLabel];
        [self.contentView addSubview:self.separtorLine2];
        [self.contentView addSubview:self.reportLabel];
        
        [_commentsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(LJKAuthorIcon2CellLeft);
            make.right.equalTo(self.mas_right).offset(-LJKAuthorIcon2CellLeft);
            make.top.equalTo(self.mas_top).offset(LJKAuthorIcon2CellTop);
            make.height.equalTo(@(30));
        }];
        
        [_separtorLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 2 * LJKAuthorIcon2CellLeft, 1));
            make.top.equalTo(self.commentsLabel.mas_bottom).offset(LJKAuthorIcon2CellTop);
            make.centerX.equalTo(self.mas_centerX);
        }];
        
        [_sameHobbyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(self.commentsLabel);
            make.top.equalTo(self.separtorLine1.mas_bottom).offset(LJKAuthorIcon2CellTop);
            make.centerX.equalTo(self.mas_centerX);
        }];
        
        [_separtorLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(self.separtorLine1);
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(self.sameHobbyLabel.mas_bottom).offset(LJKAuthorIcon2CellTop);
        }];
        
        [_reportLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(self.commentsLabel);
            make.top.equalTo(self.separtorLine2.mas_bottom).offset(LJKAuthorIcon2CellTop);
            make.centerX.equalTo(self.mas_centerX);
        }];
    }
    return self;
}

#pragma mark - 传入模型
- (void)setRecipe:(LJKRecipe *)recipe {
    _recipe = recipe;
    
    if ([recipe.stats.n_comments isEqualToString:@"0"] || !recipe.stats.n_comments) { // 无留言
        self.commentsLabel.text = @"暂时还没有留言哦";
    } else { // 有留言
        self.commentsLabel.text = [NSString stringWithFormat:@"%@条留言",recipe.stats.n_comments];
    }
    
}

#pragma mark - 点击事件
- (void)comments {
    !self.footerActionBlock ? : self.footerActionBlock(SupplementaryFooterActionComment);
}


- (void)hobby {
    !self.footerActionBlock ? : self.footerActionBlock(SupplementaryFooterActionSameHobby);
}

- (void)report {
    !self.footerActionBlock ? : self.footerActionBlock(SupplementaryFooterActionReport);
}

// useless
//- (void)comments:(id)sender {
//    UITapGestureRecognizer *tap = (UITapGestureRecognizer *)sender;
//    !self.footerActionBlock ? : self.footerActionBlock(tap.view.tag);
//}

@end
