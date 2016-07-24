//
//  LJKShop.h
//  LJKitchen
//
//  Created by  a on 16/7/11.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  店铺(M)

#import <Foundation/Foundation.h>

@interface LJKShop : NSObject <NSCoding>

/** 公告 */
@property (nonatomic, copy) NSString *announcement;
/** 店铺logoURL */
@property (nonatomic, copy) NSString *shop_logo_url;
/** 店铺名称 */
@property (nonatomic, copy) NSString *name;
/** 商品数 */
@property (nonatomic, copy) NSString *goods_count;
/** 店铺url 直接跳转 */
@property (nonatomic, copy) NSString *url;
/** 店铺促销活动 */
@property (nonatomic, strong) NSArray<NSString *> *promotion_text_list;
/** 包邮描述 */
@property (nonatomic, copy) NSString *free_delivery_desc;
/** 电话 */
@property (nonatomic, copy) NSString *phone;
/** 店铺ID */
@property (nonatomic, copy) NSString *ID;
/** 店铺iconURL */
@property (nonatomic, copy) NSString *shop_icon_url;

@end
