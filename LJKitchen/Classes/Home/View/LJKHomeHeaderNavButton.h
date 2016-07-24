//
//  LJKHomeHeaderNavButton.h
//  LJKitchen
//
//  Created by  a on 16/6/12.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  自定义导航按钮(V)

#import <UIKit/UIKit.h>
@class LJKNav;

@interface LJKHomeHeaderNavButton : UIButton

/** 导航按钮(图片为网络获取) */
+ (nonnull LJKHomeHeaderNavButton *)buttonWithNav:(nonnull LJKNav *)nav
                                           target:(nullable id)target
                                           action:(nullable SEL)action;

/** 导航按钮(图片为本地获取) */
+ (nonnull LJKHomeHeaderNavButton *)buttonWithImageName:(nonnull NSString *)imageName
                                                  title:(nonnull NSString *)title
                                                 target:(nullable id)target
                                                 action:(nullable SEL)action;

/** 导航按钮(图片为本地获取) - 大图标模式 */
+ (nonnull LJKHomeHeaderNavButton *)buttonWithLargeImageName:(nonnull NSString *)imageName
                                                       title:(nonnull NSString *)title
                                                      target:(nullable id)target
                                                      action:(nullable SEL)action;

@end
