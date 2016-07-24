//
//  LJKTopicDetailCell.m
//  LJKitchen
//
//  Created by  a on 16/6/24.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKTopicDetailCell.h"
#import "LJKTopicComment.h"
#import "LJKAuthor.h"
#import <Masonry.h>

@interface LJKTopicDetailCell ()
/** 帖子(评论) - 头像  */
@property (nonatomic, strong) UIImageView *iconView;
/** 帖子(评论) - 名称  */
@property (nonatomic, strong) UILabel *nameLabel;
/** 帖子(评论) - 评论  */
@property (nonatomic, strong) UILabel *commentLabel;
/** 帖子(评论) - 时间戳 */
@property (nonatomic, strong) UILabel *timeLabel;
/** 分隔线 */
@property (nonatomic, strong) UIView *separatorLine;
@end

@implementation LJKTopicDetailCell

#pragma mark - 懒加载
- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
    }
    return _iconView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel labelWithTextColor:Color_DarkGray
                                 backgroundColor:Color_Clear
                                        fontSize:13
                                           lines:1
                                   textAlignment:NSTextAlignmentLeft];
    }
    return _nameLabel;
}

- (UILabel *)commentLabel {
    if (!_commentLabel) {
        _commentLabel = [UILabel labelWithTextColor:Color_TintBlack
                                    backgroundColor:Color_Clear
                                           fontSize:15
                                              lines:0
                                      textAlignment:NSTextAlignmentLeft];
    }
    return _commentLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [UILabel labelWithTextColor:Color_DarkGray
                                 backgroundColor:Color_Clear
                                        fontSize:13
                                           lines:1
                                   textAlignment:NSTextAlignmentRight];
    }
    return _timeLabel;
}

- (UIView *)separatorLine {
    if (!_separatorLine) {
        _separatorLine = [[UIView alloc] init];
        _separatorLine.backgroundColor = Color_DarkGray;
    }
    return _separatorLine;
}

#pragma mark - 构造方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.commentLabel];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.separatorLine];
        
        
        [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(LJKAuthorIconWH, LJKAuthorIconWH));
            make.top.equalTo(self.contentView.mas_top).offset(LJKAuthorIcon2CellTop);
            make.left.equalTo(self.contentView.mas_left).offset(LJKAuthorIcon2CellLeft);
        }];
        
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconView.mas_right).offset(LJKAuthorIcon2CellLeft);
            make.top.equalTo(self.iconView.mas_top);
            make.right.equalTo(self.contentView.mas_right).offset(-LJKAuthorIcon2CellLeft);
            make.height.equalTo(@(LJKAuthorIconWH * 0.5));
        }];
        
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(self.nameLabel.mas_height);
            make.right.equalTo(self.contentView.mas_right).offset(-LJKAuthorIcon2CellLeft);
            make.top.equalTo(self.iconView.mas_top);
        }];
        
        [_commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel.mas_left);
            make.right.equalTo(self.contentView.mas_right).offset(-LJKAuthorIcon2CellLeft);
            make.top.equalTo(self.nameLabel.mas_bottom).offset(10);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-LJKAuthorIcon2CellTop);
        }];
        
        [_separatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 1));
            make.left.equalTo(self.contentView.mas_left);
            make.bottom.equalTo(self.contentView.mas_bottom);
        }];
    }
    return self;
}

#pragma mark - 传入模型
- (void)setComment:(LJKTopicComment *)comment {
    _comment = comment;
    
    self.nameLabel.text = comment.author.name;
    self.timeLabel.text = comment.create_time;
    self.commentLabel.text = comment.txt;
    [self.iconView setCircleIconWithUrl:[NSURL URLWithString:comment.author.photo160]
                            placeHolder:@"defaultUserHeader"
                             cornRadius:80];
}


@end
