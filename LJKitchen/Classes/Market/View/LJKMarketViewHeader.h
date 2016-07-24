//
//  LJKMarketViewHeader.h
//  LJKitchen
//
//  Created by  a on 16/7/14.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  市集 - header (V)

#import <UIKit/UIKit.h>
@class LJKAuthorDetail;
@interface LJKMarketViewHeader : UIView
/** 用户信息 */
@property (nonatomic, strong) LJKAuthorDetail *authorDetail;
/** 更改定位信息 回调 */
@property (nonatomic, copy) void(^changeLocationBlock)();

@end
