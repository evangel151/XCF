//
//  LJKBasicIconCell.m
//  LJKitchen
//
//  Created by  a on 16/6/11.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKBasicIconCell.h"

@implementation LJKBasicIconCell

- (void)awakeFromNib {

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"BasicCell";
    LJKBasicIconCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LJKBasicIconCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

@end
