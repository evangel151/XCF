//
//  LJKDiggUsers.h
//  LJKitchen
//
//  Created by  a on 16/7/5.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  点赞/支持 (M)

#import <Foundation/Foundation.h>
@class LJKAuthor;
@interface LJKDiggUsers : NSObject
/** 显示的点赞用户数 默认返回5个 */
@property (nonatomic, assign) NSInteger count;
/** 点赞总人数 */
@property (nonatomic, copy) NSString *total;
/** 点赞用户数组 */
@property (nonatomic, strong) NSArray <LJKAuthor *> *users;
@end
