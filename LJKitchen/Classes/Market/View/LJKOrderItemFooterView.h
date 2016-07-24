//
//  LJKOrderItemFooterView.h
//  LJKitchen
//
//  Created by  a on 16/7/13.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  订单 - 商品支付信息 (V)

#import <UIKit/UIKit.h>

@class LJKCartItem;

@interface LJKOrderItemFooterView : UITableViewHeaderFooterView
/** 订单 - 商品支付信息 - 模型数据 */
@property (nonatomic, strong) NSArray <LJKCartItem *> *shopArray; // 模型数据
/** 订单 - 商品支付信息 - 留言回调 */
@property (nonatomic, copy) void (^leaveMessageBlock)(NSString *);

@end
