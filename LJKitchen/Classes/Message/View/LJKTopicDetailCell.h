//
//  LJKTopicDetailCell.h
//  LJKitchen
//
//  Created by  a on 16/6/24.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  主题 - 评论 (V)

#import <UIKit/UIKit.h>

@class LJKTopicComment;

@interface LJKTopicDetailCell : UITableViewCell

@property (nonatomic, strong) LJKTopicComment *comment;

@end
