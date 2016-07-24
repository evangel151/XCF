//
//  LJKBasicCell.h
//  LJKitchen
//
//  Created by  a on 16/6/10.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  Basic TableViewCell - (自定义标题 + 箭头)
//  后来发现基本没啥用……

#import <UIKit/UIKit.h>

@interface LJKBasicCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabelView;
@property (weak, nonatomic) IBOutlet UIImageView *arrowView;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
