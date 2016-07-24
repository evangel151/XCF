//
//  LJKPopEvent.h
//  LJKitchen
//
//  Created by  a on 16/6/15.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  导航(M)single

#import <Foundation/Foundation.h>

@interface LJKPopEvent : NSObject
/** 作品数 */
@property (nonatomic, copy) NSString *n_dishes;
/** 导航id */
@property (nonatomic, copy) NSString *ID;
/** 导航标题 */
@property (nonatomic, copy) NSString *name;
/** 图片地址 */
@property (nonatomic, copy) NSString *thumbnail_280;
@end
