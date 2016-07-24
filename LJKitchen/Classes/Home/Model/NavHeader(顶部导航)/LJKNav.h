//
//  LJKNav.h
//  LJKitchen
//
//  Created by  a on 16/6/15.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  导航(M)

#import <Foundation/Foundation.h>

@interface LJKNav : NSObject
/** 导航跳转URL */
@property (nonatomic, copy) NSString *url;
/** 导航标题 */
@property (nonatomic, copy) NSString *name;
/** 图片地址 */
@property (nonatomic, copy) NSString *picurl;
@end
