//
//  LJKGoodsAttrs.h
//  LJKitchen
//
//  Created by  a on 16/7/11.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  商品属性(M)

#import <Foundation/Foundation.h>

@interface LJKGoodsAttrs : NSObject

/** 下标 */
@property (nonatomic, assign) NSInteger index;
/** 说明 */
@property (nonatomic, copy) NSString *value;
/** 属性 */
@property (nonatomic, copy) NSString *name;
/** cellHeight */
@property (nonatomic, assign) CGFloat cellHeight;

@end
