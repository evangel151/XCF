//
//  LJKAuthorDetail.h
//  LJKitchen
//
//  Created by  a on 16/6/15.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  用户 信息详情(M)


typedef NS_ENUM (NSInteger,LJKAuthorType){
    LJKAuthorTypeMe,
    LJKAuthorTypeOther
};

#import <Foundation/Foundation.h>

@interface LJKAuthorDetail : NSObject <NSCoding>
// 类型(他人/自己)
@property (nonatomic, assign) LJKAuthorType type;
// 本地头像（自己）
@property (nonatomic, strong) UIImage *image;
/** 头像 (尺寸60）*/
@property (nonatomic, copy) NSString *photo;
/** 头像（尺寸60）*/
@property (nonatomic, copy) NSString *photo60;
/** 头像（尺寸160）*/
@property (nonatomic, copy) NSString *photo160;
/** 关注数 */
@property (nonatomic, copy) NSString *nfollow;
/** 粉丝数 */
@property (nonatomic, copy) NSString *nfollowed;
/** 描述 */
@property (nonatomic, copy) NSString *desc;
/** 加入时间 */
@property (nonatomic, copy) NSString *create_time;

/** 昵称 */
@property (nonatomic, copy) NSString *name;
/** 性别 */
@property (nonatomic, copy) NSString *gender;
/** 工作 */
@property (nonatomic, copy) NSString *profession;
/** 生日 */
@property (nonatomic, copy) NSString *birthday;
/** 当前地址 */
@property (nonatomic, copy) NSString *current_location;
/** 家乡 */
@property (nonatomic, copy) NSString *hometown_location;
/** 邮箱 */
@property (nonatomic, copy) NSString *mail;
/** 用户id */
@property (nonatomic, copy) NSString *ID;
/** 是否专家 */
@property (nonatomic, assign) BOOL is_expert;

/** 作品数 */
@property (nonatomic, copy) NSString *ndishes;
/** 菜谱数 */
@property (nonatomic, copy) NSString *nrecipes;
/** 收藏数 */
@property (nonatomic, copy) NSString *ncollects;

/** 描述高度 */
@property (nonatomic, assign) CGFloat descHeight;
/** header高度 */
@property (nonatomic, assign) CGFloat headerHeight;
@end
