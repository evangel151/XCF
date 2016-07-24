//
//  LJKGoodsKind.h
//  LJKitchen
//
//  Created by  a on 16/7/11.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  商品种类 (M)

#import <Foundation/Foundation.h>

@interface LJKGoodsKind : NSObject <NSCoding>

/** 原价格 */
@property (nonatomic, assign) NSInteger original_price;
/** 现价 */
@property (nonatomic, assign) double price;
/** 库存 */
@property (nonatomic, assign) NSInteger stock;
/** 名称 */
@property (nonatomic, copy) NSString *name;
/** ID */
@property (nonatomic, copy) NSString *ID;
/** 未知 */
@property (nonatomic, copy) NSString *serial_number;

@end
