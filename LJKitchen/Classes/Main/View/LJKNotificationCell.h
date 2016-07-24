//
//  LJKNotificationCell.h
//  LJKitchen
//
//  Created by  a on 16/6/11.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  通知 cell (V)

#import <UIKit/UIKit.h>

@interface LJKNotificationCell : UITableViewCell
/** 通知 cell - switch */
@property (nonatomic, strong) UISwitch *switchView;
/** 通知 cell - 信息 */
@property (nonatomic, strong) UILabel *statusLabel;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
