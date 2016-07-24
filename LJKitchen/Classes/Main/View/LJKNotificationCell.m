//
//  LJKNotificationCell.m
//  LJKitchen
//
//  Created by  a on 16/6/11.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKNotificationCell.h"
#import <Masonry.h>

@interface LJKNotificationCell ()

@end

@implementation LJKNotificationCell

- (UISwitch *)switchView {
    if (!_switchView) {
        _switchView = [[UISwitch alloc] init];
    }
    return _switchView;
}

- (UILabel *)statusLabel {
    if (!_statusLabel) {
        _statusLabel = [UILabel labelWithTextColor:Color_TintBlack
                                   backgroundColor:Color_Clear
                                          fontSize:17
                                             lines:1
                                     textAlignment:NSTextAlignmentRight];
        _statusLabel.bounds = CGRectMake(0, 0, 100, 44);
    }
    return _statusLabel;
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"NotificationCell";
    LJKNotificationCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[LJKNotificationCell alloc] initWithStyle:UITableViewCellStyleValue1
                                          reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self addSubview:self.switchView];
        [self addSubview:self.statusLabel];
    }
    return self;
}

@end
