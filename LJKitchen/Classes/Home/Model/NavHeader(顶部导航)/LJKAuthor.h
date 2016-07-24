//
//  LJKAuthor.h
//  LJKitchen
//
//  Created by  a on 16/6/15.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  用户(M)

#import <Foundation/Foundation.h>

@interface LJKAuthor : NSObject <NSCoding>
// 本地头像
@property (nonatomic, strong) UIImage *image;
/** 头像 (尺寸60）*/
@property (nonatomic, copy) NSString *photo;
/** 头像（尺寸60）*/
@property (nonatomic, copy) NSString *photo60;
/** 头像（尺寸160）*/
@property (nonatomic, copy) NSString *photo160;
/** 昵称 */
@property (nonatomic, copy) NSString *name;
/** 是否专家 */
@property (nonatomic, assign) BOOL is_expert;
/** 当前地址 */
@property (nonatomic, copy) NSString *current_location;
/** 家乡 */
@property (nonatomic, copy) NSString *hometown_location;
/** 邮箱 */
@property (nonatomic, copy) NSString *mail;
/** 用户id */
@property (nonatomic, copy) NSString *ID;

/** 登录用户(self)信息 */
+ (instancetype)me;
@end
