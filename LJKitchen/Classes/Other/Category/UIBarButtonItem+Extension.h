//
//  UIBarButtonItem+Extension.h
//  LJKitchen
//
//  Created by  a on 16/7/12.
//  Copyright © 2016年 ycdsq. All rights reserved.
//



#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)


/** 导航按钮 (选中后改变title) */
+ (instancetype)barButtonItemWithTitle:(NSString *)title
                         selectedTitle:(NSString *)selTitle
                                target:(id)target
                                action:(SEL)action;


/** 返回导航按钮组 */
+ (NSArray <UIBarButtonItem *> *)createShareButtonsWith:(UIViewController *)controller
                                                target:(id)target
                                     firstButtonAction:(SEL)action1
                                    secondButtonAction:(SEL)action2
                                     thirdButtonAction:(SEL)action3
                                    fourthButtonAction:(SEL)action4;


//typedef void(^LJKBarButtonHandler)(void);
//@property (nonatomic, copy) void (^navigationBarDidClickedBlock)(NSInteger);

/**
 *  按钮以block样式返回的触发方法
 *
 *  @param controlEvents UIControlEvents
 *  @param completion    响应的回调
 */
//- (void)addActionforControlEvents:(UIControlEvents)controlEvents respond:(LJKBarButtonHandler)completion;
@end
