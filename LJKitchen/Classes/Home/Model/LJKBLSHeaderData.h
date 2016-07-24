//
//  LJKBLSHeaderData.h
//  LJKitchen
//
//  Created by  a on 16/6/21.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  三餐Controller - header(M)

#import <Foundation/Foundation.h>

@interface LJKBLSHeaderData : NSObject
/** 标题 */
@property (nonatomic, copy) NSString *name;
/** 作品数 */
@property (nonatomic, copy) NSString *n_dishes;
/** 细节描述 */
@property (nonatomic, copy) NSString *desc;
@end
