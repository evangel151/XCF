//
//  LJKContent.h
//  LJKitchen
//
//  Created by  a on 16/6/17.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  首页(M) cell

#import <Foundation/Foundation.h>
@class LJKIssues;

@interface LJKContent : NSObject

/** 菜谱组数 */
@property (nonatomic, assign) NSUInteger count;
/** 菜谱数据 */
@property (nonatomic, strong) NSArray <LJKIssues *> *issues;

@end
