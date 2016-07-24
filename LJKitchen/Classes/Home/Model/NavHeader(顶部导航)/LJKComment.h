//
//  LJKComment.h
//  LJKitchen
//
//  Created by  a on 16/6/16.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  评论(M)

#import <Foundation/Foundation.h>
@class LJKAuthor;
@interface LJKComment : NSObject
/** 作者 */
@property (nonatomic, strong) LJKAuthor *author;
/** 作者数组 */
@property (nonatomic, strong) NSArray <LJKAuthor *> *at_users;
/** 事件id */
@property (nonatomic, copy) NSString *target_id;
/** 评论创建时间 */
@property (nonatomic, copy) NSString *create_time;
/** 评论内容 */
@property (nonatomic, copy) NSString *txt;
/** id */
@property (nonatomic, copy) NSString *ID;
@end
