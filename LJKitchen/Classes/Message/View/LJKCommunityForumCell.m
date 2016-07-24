//
//  LJKCommunityForumCell.m
//  LJKitchen
//
//  Created by  a on 16/6/22.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKCommunityForumCell.h"
#import "LJKForum.h"
#import "LJKAuthor.h"

#import <Masonry.h>
#import <UIImageView+WebCache.h>

@interface LJKCommunityForumCell ()
/** 社区 - 头像(容器) */
@property (nonatomic, strong) UIView *iconContainer;
/** 社区 - title */
@property (nonatomic, strong) UILabel *mainLabel;
/** 社区 - 最后一条发言 */
@property (nonatomic, strong) UILabel *descLabel;

@property (nonatomic, strong) UIImageView *icon1;
@property (nonatomic, strong) UIImageView *icon2;
@property (nonatomic, strong) UIImageView *icon3;
@property (nonatomic, strong) UIImageView *icon4;

@end


@implementation LJKCommunityForumCell

#pragma mark - 懒加载

- (UIView *)iconContainer {
    if (!_iconContainer) {
        _iconContainer = [[UIView alloc] init];
    }
    return _iconContainer;
}


- (UIImageView *)icon1 {
    if (!_icon1) {
        _icon1 = [[UIImageView alloc] init];
    }
    return _icon1;
}

- (UIImageView *)icon2 {
    if (!_icon2) {
        _icon2 = [[UIImageView alloc] init];
    }
    return _icon2;
}
- (UIImageView *)icon3 {
    if (!_icon3) {
        _icon3 = [[UIImageView alloc] init];
    }
    return _icon3;
}
- (UIImageView *)icon4 {
    if (!_icon4) {
        _icon4 = [[UIImageView alloc] init];
    }
    return _icon4;
}

- (UILabel *)mainLabel {
    if (!_mainLabel) {
        _mainLabel = [UILabel labelWithTextColor:Color_TintBlack
                                 backgroundColor:Color_Clear
                                        fontSize:17
                                           lines:1
                                   textAlignment:NSTextAlignmentLeft];
    }
    return _mainLabel;
}

- (UILabel *)descLabel {
    if (!_descLabel) {
        _descLabel = [UILabel labelWithTextColor:Color_DarkGray
                                  backgroundColor:Color_Clear
                                         fontSize:13
                                            lines:1
                                    textAlignment:NSTextAlignmentLeft];
    }
    return _descLabel;
}


#pragma mark - 构造方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.iconContainer];
        [self.iconContainer addSubview:self.icon1];
        [self.iconContainer addSubview:self.icon2];
        [self.iconContainer addSubview:self.icon3];
        [self.iconContainer addSubview:self.icon4];
        
        [self.contentView addSubview:self.mainLabel];
        [self.contentView addSubview:self.descLabel];
        
        [_iconContainer mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(LJKAuthorIconsWH, LJKAuthorIconsWH));
            make.top.equalTo(self.contentView.mas_top).offset(LJKAuthorIcon2CellTop);
            make.left.equalTo(self.contentView.mas_left).offset(LJKAuthorIcon2CellLeft);
        }];
        
        [_icon1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconContainer.mas_left);
            make.top.equalTo(self.iconContainer.mas_top);
            make.size.mas_equalTo(CGSizeMake(LJKAuthorIconsWH * 0.5, LJKAuthorIconsWH * 0.5));
        }];
        
        [_icon2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(self.icon1);
            make.right.equalTo(self.iconContainer.mas_right);
            make.top.equalTo(self.iconContainer.mas_top);
        }];
        
        [_icon3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(self.icon1);
            make.left.equalTo(self.iconContainer.mas_left);
            make.bottom.equalTo(self.iconContainer.mas_bottom);
        }];
        
        [_icon4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(self.icon1);
            make.right.equalTo(self.iconContainer.mas_right);
            make.bottom.equalTo(self.iconContainer.mas_bottom);
        }];
        
        [_mainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconContainer.mas_right).offset(20);
            make.top.equalTo(self.contentView.mas_top).offset(LJKAuthorIcon2CellTop);
            make.right.equalTo(self.contentView.mas_right).offset(-LJKAuthorIcon2CellLeft);
            make.bottom.equalTo(self.contentView.mas_centerY);
        }];
        
        [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mainLabel.mas_left);
            make.top.equalTo(self.mainLabel.mas_bottom);
            make.right.equalTo(self.mainLabel.mas_right);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-LJKAuthorIcon2CellTop);
        }];
    }
    return self;
}

#pragma mark - 传入模型
- (void)setForum:(LJKForum *)forum {
    _forum = forum;
    
    self.mainLabel.text = forum.name;
    self.descLabel.text = forum.desc;
    
    for (int i = 0; i < forum.latest_authors.count; i++) {
        UIImageView *icon = self.iconContainer.subviews[i];
        
        [icon sd_setImageWithURL:[NSURL URLWithString:[forum.latest_authors[i] photo60]]
                placeholderImage:[UIImage imageNamed:@"defaultUserHeader"]];
        // 不适合加圆角
        //        [icon setCircleIconWithUrl:[NSURL URLWithString:[forum.latest_authors[i] photo60]]
        //                       placeHolder:@"defaultUserHeader"
        //                        cornRadius:0];
    }
}

@end
