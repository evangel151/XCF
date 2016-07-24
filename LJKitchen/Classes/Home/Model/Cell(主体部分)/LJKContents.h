//
//  LJKContents.h
//  LJKitchen
//
//  Created by  a on 16/6/17.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  首页(M)模板主体

#import <Foundation/Foundation.h>

@class LJKImage,LJKAuthor;
@interface LJKContents : NSObject
//模板1、2、4、5、6
/** 图片内容 */
@property (nonatomic, strong) LJKImage *image;

//模板1、5
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 描述 */
@property (nonatomic, copy) NSString *desc;

//模板2
/** 大标题 */
@property (nonatomic, copy) NSString *title_1st;
/** 小标题 */
@property (nonatomic, copy) NSString *title_2nd;

//模板4
/** 标题 */
@property (nonatomic, copy) NSString *whisper;

//模板5
/** 视频地址 */
@property (nonatomic, copy) NSString *video_url;
/** 作者 */
@property (nonatomic, strong) LJKAuthor *author;
/** 做过的人数 */
@property (nonatomic, assign) NSUInteger n_cooked;
/** 未知 */
@property (nonatomic, assign) NSUInteger n_dishes;
/** 分数 */
@property (nonatomic, assign) NSUInteger score;
/** 食谱id */
@property (nonatomic, strong) NSString *recipe_id;

@end
