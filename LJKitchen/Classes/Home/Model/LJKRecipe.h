//
//  LJKRecipe.h
//  LJKitchen
//
//  Created by  a on 16/6/20.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  菜谱(M)

#import <Foundation/Foundation.h>

@class LJKAuthor,LJKRecipeInstruction,LJKRecipeIngredient,LJKRecipeStats;

@interface LJKRecipe : NSObject
/** 菜谱制作步骤介绍数组 */
@property (nonatomic, strong) NSArray<LJKRecipeInstruction *> *instruction;
/** 菜谱用料数组 */
@property (nonatomic, strong) NSMutableArray<LJKRecipeIngredient *> *ingredient;
/** 菜谱状态 */
@property (nonatomic, strong) LJKRecipeStats *stats;
/** 作品作者数组（未知） */
@property (nonatomic, strong) NSArray<LJKAuthor *> *dish_author;
/** 菜谱作者 */
@property (nonatomic, strong) LJKAuthor *author;

/** 视频地址 */
@property (nonatomic, copy) NSString *video_url;
/** 视频页面url */
@property (nonatomic, copy) NSString *video_page_url;
/** 创建时间(关系) */
@property (nonatomic, copy) NSString *friendly_create_time;
/** 创建时间(菜谱) */
@property (nonatomic, copy) NSString *create_time;
/** 是否为独家 */
@property (nonatomic, assign) BOOL is_exclusive;
/** 菜谱id */
@property (nonatomic, copy) NSString *ID;
/** 分数 */
@property (nonatomic, copy) NSString *score;
/** 小贴士(有则显示) */
@property (nonatomic, copy) NSString *tips;
/** 一键购买url（直接跳转） */
@property (nonatomic, copy) NSString *purchase_url;
/** 菜谱url */
@property (nonatomic, copy) NSString *url;
/** 菜谱描述 */
@property (nonatomic, copy) NSString *desc;
/** 菜谱简述 */
@property (nonatomic, copy) NSString *summary;
/** 标识（图片名字） */
@property (nonatomic, copy) NSString *ident;
/** 菜谱标题 */
@property (nonatomic, copy) NSString *name;

/** 缩略图 */
@property (nonatomic, copy) NSString *thumb;

/** 菜谱图片 - 多种规格 */
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, copy) NSString *photo80;
@property (nonatomic, copy) NSString *photo90;
@property (nonatomic, copy) NSString *photo140;
@property (nonatomic, copy) NSString *photo280;
@property (nonatomic, copy) NSString *photo340;
@property (nonatomic, copy) NSString *photo526;
@property (nonatomic, copy) NSString *photo580;
@property (nonatomic, copy) NSString *photo640;


/** 菜谱 - headerHeight */
@property (nonatomic, assign) CGFloat headerHeight;
/** 菜谱 - 小贴士Height */
@property (nonatomic, assign) CGFloat tipsHeight;


@end
