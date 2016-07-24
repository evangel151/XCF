//
//  LJKBasic2Cell.h
//  LJKitchen
//
//  Created by  a on 16/6/11.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LJKBasic2Cell : UITableViewCell
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *nameLabelTop;
@property (nonatomic, strong) UILabel *talkLabelBottom;
@property (nonatomic, strong) UILabel *timeLabel;



+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
