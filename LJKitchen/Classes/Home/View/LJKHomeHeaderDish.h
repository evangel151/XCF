//
//  LJKHomeHeaderDish.h
//  LJKitchen
//
//  Created by  a on 16/6/13.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
// 首页三餐scrollView 单页View (V)

#import <UIKit/UIKit.h>
@class LJKPopEvent;
@interface LJKHomeHeaderDish : UIView

@property (nonatomic, strong, nonnull) LJKPopEvent *popEvent;

/** 类方法:根据模型快速返回scrollView单页 */
+ (nonnull LJKHomeHeaderDish *)viewWithPopEvent:(nonnull LJKPopEvent *)popEvent
                                        target:(nullable id)target
                                        action:(nullable SEL)action;


@end
