//
//  LJKReviewCommodity.h
//  LJKitchen
//
//  Created by  a on 16/7/5.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  商品评价  

#import <Foundation/Foundation.h>
@class LJKGoods;
@interface LJKReviewCommodity : NSObject
/** 商品 */
@property (nonatomic, strong) LJKGoods *goods;
/** 种类 */
@property (nonatomic, copy) NSString *kind_name;
/** 数量 */
@property (nonatomic, copy) NSString *number;
@end
