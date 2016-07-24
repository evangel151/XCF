//
//  LJKRecipeList.h
//  LJKitchen
//
//  Created by  a on 16/7/5.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  菜单 list (M)

#import <Foundation/Foundation.h>
@class LJKAuthor,LJKRecipe;
@interface LJKRecipeList : NSObject
/** 菜单作者 */
@property (nonatomic, strong) LJKAuthor *author;
/** 菜谱id数组 */
@property (nonatomic, strong) NSArray<NSString *> *recipes;
/** 菜谱详情数组 */
@property (nonatomic, strong) NSArray<LJKRecipe *> *sample_recipes;
/** 第一个菜谱 */
@property (nonatomic, strong) LJKRecipe *first_recipe;

/** 创建时间 */
@property (nonatomic, copy) NSString *create_time;
/** 更新时间 */
@property (nonatomic, copy) NSString *update_time;
/** 标题 */
@property (nonatomic, copy) NSString *name;
/** 菜单id */
@property (nonatomic, copy) NSString *ID;
/** 菜单描述 */
@property (nonatomic, copy) NSString *desc;
/** 菜单网页url */
@property (nonatomic, copy) NSString *url;
/** 图片 */
@property (nonatomic, copy) NSString *photo;
/** 缩略图 */
@property (nonatomic, copy) NSString *thumbnail;
/** 收藏此菜单的人数 */
@property (nonatomic, copy) NSString *ncollects;
/** 菜单内菜谱数 */
@property (nonatomic, copy) NSString *nrecipes;

/** 是否由我收集 */
@property (nonatomic, assign) BOOL collected_by_me;
/** 未知 */
@property (nonatomic, assign) NSInteger pv;


/** 菜单headerHeight */
@property (nonatomic, assign) CGFloat headerheight;
/** 菜单作者名字承载view宽度 */
@property (nonatomic, assign) CGFloat authorNameViewWidth;
@end
