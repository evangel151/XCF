//
//  UIView+Extension.h
//  LJKitchen
//
//  Created by  a on 16/7/15.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

/** 快速创建一个垂直的 图文 item */
+ (UIView *)createVerticalIconViewWithImage:(UIImage *)image
                                      title:(NSString *)title;

/** 快速创建一个垂直的 图文 item & action  */
+ (UIView *)createVerticalIconViewWithImage:(UIImage *)image
                                      title:(NSString *)title
                                     target:(id)target
                                     action:(SEL)action;
@end
