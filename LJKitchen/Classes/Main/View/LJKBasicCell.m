//
//  LJKBasicCell.m
//  LJKitchen
//
//  Created by  a on 16/6/10.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  Done

#import "LJKBasicCell.h"
#import <Masonry.h>

@interface LJKBasicCell ()


@end

@implementation LJKBasicCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"BasicCell";
    LJKBasicCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[LJKBasicCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LJKBasicCell" owner:nil options:nil] firstObject];
    }
    return cell;
}



@end
