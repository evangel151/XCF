//
//  LJKBasicIconCell.h
//  LJKitchen
//
//  Created by  a on 16/6/11.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  Basic TableView cell - (带头像 + 姓名栏 + 对话框 + 时间戳)

#import <UIKit/UIKit.h>

@interface LJKBasicIconCell : UITableViewCell
/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
/** 姓名栏 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** 最后一句对话 */
@property (weak, nonatomic) IBOutlet UILabel *talkLabel;
/** 时间戳 */
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

/** 快速创建 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
