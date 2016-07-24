//
//  UIToolbar+Extension.h
//  LJKitchen
//
//  Created by  a on 16/6/30.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIToolbar (Extension)

/** 确定\取消 ToolBar */
+ (UIToolbar *)createBasicToolBarWithDone:(SEL)doneAction
                             cancelAction:(SEL)cancelAction
                                   target:(id)target;

/** Basic ToolBar (双按钮) */
+ (UIToolbar *)createToolBarWithTwoButtonsBtn1:(NSString *)button1_title
                                    btn1Action:(SEL)button1_action
                                          btn2:(NSString *)button2_title
                                    btn2Action:(SEL)button2_action
                                        target:(id)target;

/** Basic ToolBar (单按钮) */
+ (UIToolbar *)createSingleButtonToolBarWithTitle:(NSString *)title
                                           action:(SEL)action
                                           target:(id)target;

@end
