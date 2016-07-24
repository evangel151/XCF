//
//  LJKFeeds.h
//  LJKitchen
//
//  Created by  a on 16/6/17.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  关注动态（M）来源

#import <Foundation/Foundation.h>
@class LJKDish;
@interface LJKFeeds : NSObject
/** 菜单详情 */
@property (nonatomic, strong) LJKDish *dish;
/** 类型 */
@property (nonatomic, assign) NSInteger kind;
/** id */
@property (nonatomic, copy) NSString *ID;
/** 评论数 */
@property (nonatomic, assign) NSInteger ncomment;
@end
