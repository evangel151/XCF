//
//  LJKOrderPayView.h
//  LJKitchen
//
//  Created by  a on 16/7/13.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  订单 - 支付工具条 (V)

#import <UIKit/UIKit.h>

@interface LJKOrderPayView : UIView
@property (nonatomic, strong) NSArray *buyItems; // 购买商品数据

/** 点击付款按钮 回调 */
@property (nonatomic, copy) void (^payButtonDidClickedBlock)();

@end
