//
//  LJKDish.m
//  LJKitchen
//
//  Created by  a on 16/6/15.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKDish.h"
#import "LJKAuthor.h"
#import "LJKPicture.h"
#import "LJKComment.h"
#import "LJKEvents.h"
#import <MJExtension.h>

@implementation LJKDish

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID" : @"id"};
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"extra_pic" : [LJKPicture class],
             @"events" : [LJKEvents class],
             @"latest_comments" : [LJKComment class]};
}

- (CGFloat)dishCellHeight {
    
    // (垂直方向)姓名栏maxY == 458
    CGFloat dishNameLabelMaxY = 350 + 2 * LJKAuthorIcon2CellTop + 2 * TABBAR_HEIGHT;
    
    // (水平方向)间距sum == 104
    CGFloat totalMarginWidth = LJKAuthorIcon2CellLeft * 3 + 44;
    
    // (垂直方向)底部总和
    CGFloat totalMarginHeight =  TABBAR_HEIGHT + 30 + 20;
    
    if (self.desc.length) {
        CGFloat descHeight = [self.desc boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - totalMarginWidth, MAXFLOAT)
                                                     options:NSStringDrawingUsesLineFragmentOrigin
                                                  attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]}
                                                     context:nil].size.height;
        
        _dishCellHeight = dishNameLabelMaxY + descHeight + totalMarginHeight + 10;
    } else {
        _dishCellHeight = dishNameLabelMaxY + totalMarginHeight;
    }
    
    return _dishCellHeight;
}

- (CGFloat)commentViewHeight {
    CGFloat commentCountH = 44;
    CGFloat marginTop = 10;
    CGFloat marginMid = 10;
    CGFloat marginBottom = 10;
    
    
    if (self.latest_comments.count) { // 如果有评论
        
        // 计算第一条评论高度
        LJKComment *firstComment = self.latest_comments[self.latest_comments.count - 1];
        NSString *firstCommentString = [NSString stringWithFormat:@"%@：%@", firstComment.author.name, firstComment.txt];
        CGFloat firstCommentHeight = [firstCommentString boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 104, MAXFLOAT)
                                                                      options:NSStringDrawingUsesLineFragmentOrigin
                                                                   attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]}
                                                                      context:nil].size.height;
        _commentViewHeight = marginTop + firstCommentHeight + marginBottom;
        
        // 如果有1条以上评论
        if (self.latest_comments.count > 1) {
            
            // 计算第二条评论高度
            LJKComment *secondComment = self.latest_comments[self.latest_comments.count - 2];
            NSString *secondCommentString = [NSString stringWithFormat:@"%@：%@", secondComment.author.name, secondComment.txt];
            // 104 == 头像(44) + 3 * padding(20)
            // 3 * padding == 头像左 + 头像右 + 评论右
            CGFloat secondCommentHeight = [secondCommentString boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 104, MAXFLOAT)
                                                                            options:NSStringDrawingUsesLineFragmentOrigin
                                                                         attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]}
                                                                            context:nil].size.height;
            _commentViewHeight = marginTop + firstCommentHeight + marginMid + secondCommentHeight + marginBottom;
            
            // 如果有2条以上评论
            if (self.latest_comments.count > 2) {
                
                // 加上评论总数Label高度
                _commentViewHeight = commentCountH + marginTop + firstCommentHeight + marginMid + secondCommentHeight + marginBottom;
            }
        }
        
    } else if(!self.latest_comments.count) { // 如果没有评论
        _commentViewHeight = marginBottom;
    }
    
    return _commentViewHeight;
}

@end
