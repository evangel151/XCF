//
//  LJKBasic2Cell.m
//  LJKitchen
//
//  Created by  a on 16/6/11.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKBasic2Cell.h"
#import <Masonry.h>

@interface LJKBasic2Cell ()

@end

@implementation LJKBasic2Cell

- (UIImageView *)iconView {
    if (!_iconView) {
        self.iconView = [[UIImageView alloc] init];
    }
    return _iconView;
}

- (UILabel *)nameLabelTop {
    if (!_nameLabelTop) {
        self.nameLabelTop = [[UILabel alloc] init];
        self.nameLabelTop.textAlignment = NSTextAlignmentLeft;
        self.nameLabelTop.font = [UIFont systemFontOfSize:17];
    }
    return _nameLabelTop;
}

- (UILabel *)talkLabelBottom {
    if (!_talkLabelBottom) {
        self.talkLabelBottom = [[UILabel alloc] init];
        self.talkLabelBottom.textAlignment = NSTextAlignmentLeft;
        self.talkLabelBottom.font = [UIFont systemFontOfSize:13];
        self.talkLabelBottom.textColor = Color_DarkGray;
    }
    return _talkLabelBottom;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        self.timeLabel = [[UILabel alloc] init];
        self.timeLabel.textAlignment = NSTextAlignmentRight;
        self.timeLabel.font = [UIFont systemFontOfSize:12];
        self.timeLabel.textColor = Color_DarkGray;
    }
    return _timeLabel;
}


#pragma mark - 构造方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.nameLabelTop];
        [self.contentView addSubview:self.talkLabelBottom];
        
        [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.width.equalTo(self.contentView.mas_height).offset(-LJKAuthorIcon2CellLeft);
//            make.bottom.equalTo(self.contentView).offset(-LJKAuthorIcon2CellTop);
            make.left.equalTo(self.contentView.mas_left).offset(LJKAuthorIcon2CellLeft);
            make.top.equalTo(self.contentView.mas_top).offset(LJKAuthorIcon2CellTop);
            make.size.mas_equalTo(CGSizeMake(LJKAuthorIconWH, LJKAuthorIconWH));
        }];
        
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(LJKAuthorIcon2CellTop);
            make.right.equalTo(self.contentView.mas_right).offset(-LJKAuthorIcon2CellLeft);
//            make.size.mas_equalTo(CGSizeMake(100, 0.5 * LJKAuthorIconWH));
            make.bottom.equalTo(self.contentView.mas_centerY);
        }];
        
        [_nameLabelTop mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(LJKAuthorIcon2CellTop);
            make.bottom.equalTo(self.contentView.mas_centerY);
            make.left.equalTo(self.iconView.mas_right).offset(20);
            make.right.equalTo(self.contentView.mas_right).offset(-LJKAuthorIcon2CellLeft);
        }];
        
        [_talkLabelBottom mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_centerY);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-LJKAuthorIcon2CellTop);
            make.left.equalTo(self.nameLabelTop.mas_left);
            make.right.equalTo(self.contentView.mas_right).offset(-LJKAuthorIcon2CellLeft);
        }];
        
    }
    return self;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"Basic2Cell";
    LJKBasic2Cell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[LJKBasic2Cell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    return cell;
}

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
