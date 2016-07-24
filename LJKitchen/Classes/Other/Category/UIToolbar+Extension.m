//
//  UIToolbar+Extension.m
//  LJKitchen
//
//  Created by  a on 16/6/30.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "UIToolbar+Extension.h"

@implementation UIToolbar (Extension)


+ (UIToolbar *)createToolBarWithTwoButtonsBtn1:(NSString *)button1_title
                                    btn1Action:(SEL)button1_action
                                          btn2:(NSString *)button2_title
                                    btn2Action:(SEL)button2_action
                                        target:(id)target {
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, TABBAR_HEIGHT)];
    UIBarButtonItem *btn1 = [[UIBarButtonItem alloc] initWithTitle:button1_title
                                                             style:UIBarButtonItemStylePlain
                                                            target:target
                                                            action:button1_action];
    
    UIBarButtonItem *btn2 = [[UIBarButtonItem alloc] initWithTitle:button2_title
                                                               style:UIBarButtonItemStylePlain
                                                              target:target
                                                              action:button2_action];
    UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    toolBar.items = @[flexible,btn2,btn1];
    toolBar.tintColor = Color_ThemeColor;
    
    return toolBar;
}


+ (UIToolbar *)createSingleButtonToolBarWithTitle:(NSString *)title
                                           action:(SEL)action
                                           target:(id)target {
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, TABBAR_HEIGHT)];
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:title
                                                               style:UIBarButtonItemStylePlain
                                                              target:target
                                                              action:action];
    UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                              target:nil action:nil];
    toolBar.items = @[flexible,button];
    toolBar.tintColor = Color_ThemeColor;
    return toolBar;
}

+ (UIToolbar *)createBasicToolBarWithDone:(SEL)doneAction
                             cancelAction:(SEL)cancelAction
                                   target:(id)target {
    
    return [UIToolbar createToolBarWithTwoButtonsBtn1:@"确定"
                                           btn1Action:doneAction
                                                 btn2:@"取消"
                                           btn2Action:cancelAction
                                               target:target];
}


@end
