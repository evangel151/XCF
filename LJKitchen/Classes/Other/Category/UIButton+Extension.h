//
//  UIButton+Extension.h
//  LJKitchen
//
//  Created by  a on 16/6/9.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extension)

/** (自定义)基础样式 */
+ (UIButton *)buttonWithTitle:(NSString *)title
                   titleColor:(UIColor *)titleColor
              backgroundColor:(UIColor *)backgroundColor
                     fontSize:(CGFloat)fontSize
                       target:(id)target
                       action:(SEL)action;

/** (自定义)选中后改变标题&BG按钮 */
+ (UIButton *)buttonWithTitle:(NSString *)title
                   titleColor:(UIColor *)titleColor
           selectedTitleColor:(UIColor *)selectedTitleColor
                     fontSize:(CGFloat)fontSize
            selectedImageName:(NSString *)imageName
                       target:(id)target
                       action:(SEL)action;

/** (自定义)选中后改变图片按钮 */
+ (UIButton *)buttonWithImageName:(NSString *)normal
                selectedImageName:(NSString *)selected
                           target:(id)target
                           action:(SEL)action;

/** (自定义)选中后改变标题&BG格式 */
+ (UIButton *)buttonWithTitleNormal:(NSString *)normalTitle
                      titleSelected:(NSString *)selectedTitle
                         titleColor:(UIColor *)titleColor
          normalBackgroundImageName:(NSString *)normalImage
        selectedBackgroundImageName:(NSString *)selectedImage
                             target:(id)target
                             action:(SEL)action;

/** (自定义)可用\不可用按钮 */
+ (UIButton *)buttonWithImageName:(NSString *)enabled
                 disableImageName:(NSString *)disabled
                           target:(id)target
                           action:(SEL)action;

/** (自定义)圆角格式 */
+ (UIButton *)buttonWithBackgroundColor:(UIColor *)backgroundColor
                                  title:(NSString *)title
                               fontSize:(CGFloat)fontSize
                             titleColor:(UIColor *)titleColor
                                 target:(id)target
                                 action:(SEL)action
                          clipsToBounds:(BOOL)clipsToBounds;

/** 圆形勾选框(全选)  */
+ (UIButton *)checkMarkButtonWithtarget:(id)target
                                 action:(SEL)action;

/** "独家"按钮 */
+ (UIButton *)createExclusiveButton;

@end
