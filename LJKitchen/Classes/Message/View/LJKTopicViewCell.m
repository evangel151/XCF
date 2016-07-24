//
//  LJKTopicViewCell.m
//  LJKitchen
//
//  Created by  a on 16/6/23.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKTopicViewCell.h"
#import "LJKTopic.h"
#import "LJKAuthor.h"

#import <Masonry.h>

@interface LJKTopicViewCell ()
/** 帖子(主体) - 头像 */
@property (nonatomic, strong) UIImageView *iconView;
/** 帖子(主体) - 置顶标志("顶") */
@property (nonatomic, strong) UIImageView *stickView;
/** 帖子(主体) - 用户名 */
@property (nonatomic, strong) UILabel *nameLabel;
/** 帖子(主体) - 帖子标题 */
@property (nonatomic, strong) UILabel *titleLabel;
/** 帖子(主体) - 评论数 */
@property (nonatomic, strong) UILabel *commentsCount;
/** 帖子(主体) - 最后回复时间 */
@property (nonatomic, strong) UILabel *latestCommentTimeLabel;

/** 分隔线 */
@property (nonatomic, strong) UIView *separatorLine;
@property (nonatomic, assign) CGFloat titleLabelWidth;

@end

@implementation LJKTopicViewCell

#pragma mark - 懒加载
- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
    }
    return _iconView;
}
- (UIImageView *)stickView {
    if (!_stickView) {
        _stickView = [[UIImageView alloc] init];
        _stickView.image = [UIImage imageNamed:@"stick"];
    }
    return _stickView;
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

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithTextColor:Color_TintBlack
                                  backgroundColor:Color_Clear
                                         fontSize:15
                                            lines:0
                                    textAlignment:NSTextAlignmentNatural];
    }
    return _titleLabel;
}

- (UILabel *)commentsCount {
    if (!_commentsCount) {
        _commentsCount = [UILabel labelWithTextColor:Color_DarkGray
                                     backgroundColor:Color_Clear
                                            fontSize:13
                                               lines:1
                                       textAlignment:NSTextAlignmentRight];
    }
    return _commentsCount;
}

- (UILabel *)latestCommentTimeLabel {
    if (!_latestCommentTimeLabel) {
        _latestCommentTimeLabel = [UILabel labelWithTextColor:Color_DarkGray
                                              backgroundColor:Color_Clear
                                                     fontSize:13
                                                        lines:1
                                                textAlignment:NSTextAlignmentLeft];
    }
    return _latestCommentTimeLabel;
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
        self.backgroundColor = Color_BackGround;
        
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.stickView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.commentsCount];
        [self.contentView addSubview:self.latestCommentTimeLabel];
        [self.contentView addSubview:self.separatorLine];
        
        [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(LJKAuthorIconWH, LJKAuthorIconWH));
            make.left.equalTo(self.contentView.mas_left).offset(LJKAuthorIcon2CellLeft);
            make.top.equalTo(self.contentView.mas_top).offset(LJKAuthorIcon2CellTop);
        }];
        
        [_separatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 1));
            make.left.equalTo(self.contentView.mas_left);
            make.bottom.equalTo(self.contentView.mas_bottom);
        }];
        
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(LJKAuthorIcon2CellTop);
            make.left.equalTo(self.iconView.mas_right).offset(LJKAuthorIcon2CellLeft);
            make.right.equalTo(self.contentView.mas_right).offset(-LJKAuthorIcon2CellLeft);
            make.height.equalTo(@(LJKAuthorIconWH * 0.5));
        }];
        
        [_stickView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(LJKAuthorIconWH * 0.5, LJKAuthorIconWH *0.5));
            make.left.equalTo(self.nameLabel.mas_left);
            make.top.equalTo(self.nameLabel.mas_bottom).offset(8);
        }];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nameLabel.mas_bottom);
            make.right.equalTo(self.contentView.mas_right).offset(-LJKAuthorIcon2CellLeft);
            make.left.equalTo(self.nameLabel.mas_left);
        }];
        
        [_commentsCount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-LJKAuthorIcon2CellLeft);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-LJKAuthorIcon2CellTop);
            make.top.equalTo(self.titleLabel.mas_bottom);
        }];
        
        [_latestCommentTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel.mas_left);
            make.top.equalTo(self.titleLabel.mas_bottom);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-LJKAuthorIcon2CellTop);
        }];
    }
    return self;
}

#pragma mark - 传入模型
- (void)setTopic:(LJKTopic *)topic {
    _topic = topic;
    // FIXME: (已解决)在此处赋值会导致 当置顶cell离开屏幕再回来时titleLabel位置错误
    // 修改约束条件 :1. titleView的left不再与iconView挂钩
    //             2. stickView存在(显示)时也更新对应约束
    if (topic.is_sticked) {
        self.stickView.hidden = NO;
        [_titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel.mas_left).offset(LJKAuthorIconWH * 0.5);
        }];
    } else {
        self.stickView.hidden = YES;
        [_titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel.mas_left);
        }];
    }
    
    NSURL *iconUrl = [NSURL URLWithString:topic.author.photo160];
    [self.iconView setCircleIconWithUrl:iconUrl
                            placeHolder:@"defaultUserHeader"
                             cornRadius:80];
    
    self.nameLabel.text = topic.author.name;
    self.titleLabel.text = topic.content;
    self.commentsCount.text = [NSString stringWithFormat:@"%@评论",topic.n_comments];
    self.latestCommentTimeLabel.text = [NSString stringWithFormat:@"最后回复:%@",topic.latest_comment_time];
}

@end
