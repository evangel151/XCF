//
//  LJKDish.h
//  LJKitchen
//
//  Created by  a on 16/6/15.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LJKComment, LJKAuthor, LJKPicture, LJKDiggUsers, LJKEvents;
@interface LJKDish : NSObject

/** 最后评论 */
@property (nonatomic, strong) NSArray<LJKComment *> *latest_comments;
/** 分享才有的数据 */
@property (nonatomic, strong) NSArray<LJKComment *> *events;
/** 附加图 */
@property (nonatomic, strong) NSArray<LJKComment *> *extra_pics;

/** 标识（图片名字） */
@property (nonatomic, copy) NSString *ident;
/** 图片地址（尺寸600） */
@property (nonatomic, copy) NSString *photo;
/** 缩略图 */
@property (nonatomic, copy) NSString *thumbnail;
/** 缩略图（尺寸160） */
@property (nonatomic, copy) NSString *thumbnail_160;
/** 缩略图（尺寸280） */
@property (nonatomic, copy) NSString *thumbnail_280;

/** 显示时间 */
@property (nonatomic, copy) NSString *friendly_create_time;
/** 创建时间 */
@property (nonatomic, copy) NSString *create_time;
/** 图片总数 */
@property (nonatomic, assign) NSInteger npics;
/** 评论数 */
@property (nonatomic, assign) NSInteger ncomments;
/** 发表动态的作者 */
@property (nonatomic, strong) LJKAuthor *author;
/** 菜谱名称\要显示的标题 */
@property (nonatomic, copy) NSString *name;
/** 文字描述 */
@property (nonatomic, copy) NSString *desc;
/** 主图 */
@property (nonatomic, strong) LJKPicture *main_pic;
/** 菜谱id */
@property (nonatomic, copy) NSString *ID;

/** 点赞数 */
@property (nonatomic, copy) NSString *ndiggs;
/** 点赞用户 */
@property (nonatomic, strong) LJKDiggUsers *digg_users;
/** 菜谱id */
@property (nonatomic, copy) NSString *recipe_id;
/** 是否为分享的内容 */
@property (nonatomic, assign) BOOL is_orphan;
/** 是否为用户点赞 */
@property (nonatomic, assign) BOOL digged_by_me;

/** 作品cellHeight */
@property (nonatomic, assign) CGFloat dishCellHeight;
/** 作品commentViewHeight */
@property (nonatomic, assign) CGFloat commentViewHeight;

@end
