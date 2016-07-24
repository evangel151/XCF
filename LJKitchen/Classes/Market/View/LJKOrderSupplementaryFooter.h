//
//  LJKOrderSupplementaryFooter.h
//  LJKitchen
//
//  Created by  a on 16/7/13.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  订单 支付支持(C) (支付、优惠)

#import <UIKit/UIKit.h>

@interface LJKOrderSupplementaryFooter : UITableViewHeaderFooterView

/** 优惠信息 点击回调 */
@property (nonatomic, copy) void (^promotionViewClickedBlock)();

@end
