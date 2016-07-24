//
//  LJKTopic.h
//  LJKitchen
//
//  Created by  a on 16/6/23.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
// 讨论区-帖子 (M)

#import <Foundation/Foundation.h>

@class LJKAuthor;

@interface LJKTopic : NSObject
/** 帖子id */
@property (nonatomic, copy) NSString *ID;
/** 作者信息 */
@property (nonatomic, strong) LJKAuthor *author;
/** 主题内容(标题) */
@property (nonatomic, copy) NSString *content;
/** 更新时间 */
@property (nonatomic, copy) NSString *update_time;
/** 最后回复时间 */
@property (nonatomic, copy) NSString *latest_comment_time;
/** 创建时间  */
@property (nonatomic, copy) NSString *create_time;
/** 评论数 */
@property (nonatomic, copy) NSString *n_comments;
/** 置顶(BOOL) */
@property (nonatomic, assign) BOOL is_sticked;

/** 主题Cell的高度(置顶 、非置顶) */
@property (nonatomic, assign) CGFloat cellHeight;
/** 主题详情的高度 */
@property (nonatomic, assign) CGFloat detailHeaderHeight;

@end
