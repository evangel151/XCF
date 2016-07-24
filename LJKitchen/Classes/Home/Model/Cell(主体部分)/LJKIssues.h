//
//  LJKIssues.h
//  LJKitchen
//
//  Created by  a on 16/6/17.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LJKItems;
@interface LJKIssues : NSObject
/** 菜谱数量 */
@property (nonatomic, assign) NSUInteger items_count;
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 菜谱数组 */
@property (nonatomic, strong) NSArray <LJKItems *> *items;
/** 当天菜谱id */
@property (nonatomic, copy) NSString *issue_id;
/** 菜谱发布日期 */
@property (nonatomic, copy) NSString *publish_date;
@end
