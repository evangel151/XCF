//
//  LJKTopicComment.h
//  LJKitchen
//
//  Created by  a on 16/6/24.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
// 主题评论 (M)

#import <Foundation/Foundation.h>
@class LJKAuthor;
@interface LJKTopicComment : NSObject

/** 用户 */
@property (nonatomic, strong) LJKAuthor *author;
/** 评论ID */
@property (nonatomic, copy) NSString *ID;
/** 评论 */
@property (nonatomic, copy) NSString *txt;                      // 内容
/** 主题ID */
@property (nonatomic, copy) NSString *target_id;                // 主题id
/** 创建时间 */
@property (nonatomic, copy) NSString *create_time;              // 创建时间

/** 每条评论对应的高度 */
@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, strong) NSArray <LJKAuthor *> *at_users;   // @的用户数组

@end
