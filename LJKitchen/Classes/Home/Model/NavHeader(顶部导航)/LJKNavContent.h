//
//  LJKNavContent.h
//  LJKitchen
//
//  Created by  a on 16/6/15.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  导航内容(M)

#import <Foundation/Foundation.h>
@class LJKPopEvents, LJKNav;

@interface LJKNavContent : NSObject
/** 早餐午餐晚餐数据 */
@property (nonatomic, strong) LJKPopEvents *pop_events;
/** 导航按钮数据 */
@property (nonatomic, strong) NSArray <LJKNav *> *navs;
/** 菜谱导航图片 */
@property (nonatomic, copy) NSString *pop_recipe_picurl;
@end
