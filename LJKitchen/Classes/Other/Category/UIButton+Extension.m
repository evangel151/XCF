//
//  UIButton+Extension.m
//  LJKitchen
//
//  Created by  a on 16/6/9.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)

+ (UIButton *)buttonWithTitle:(NSString *)title
                   titleColor:(UIColor *)titleColor
              backgroundColor:(UIColor *)backgroundColor
                     fontSize:(CGFloat)fontSize
                       target:(id)target
                       action:(SEL)action {
    
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setBackgroundColor:backgroundColor];
    button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}


+ (UIButton *)buttonWithTitle:(NSString *)title
                   titleColor:(UIColor *)titleColor
           selectedTitleColor:(UIColor *)selectedTitleColor
                     fontSize:(CGFloat)fontSize
            selectedImageName:(NSString *)imageName
                       target:(id)target
                       action:(SEL)action {
    
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setTitleColor:selectedTitleColor forState:UIControlStateSelected];
    button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateSelected];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

+ (UIButton *)buttonWithImageName:(NSString *)normal
                selectedImageName:(NSString *)selected
                       target:(id)target
                       action:(SEL)action {
    
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:normal] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selected] forState:UIControlStateSelected];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

+ (UIButton *)buttonWithImageName:(NSString *)enabled
                 disableImageName:(NSString *)disabled
                           target:(id)target
                           action:(SEL)action {
    
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:enabled] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:disabled] forState:UIControlStateDisabled];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}


+ (UIButton *)buttonWithTitleNormal:(NSString *)normalTitle
                      titleSelected:(NSString *)selectedTitle
                         titleColor:(UIColor *)titleColor
          normalBackgroundImageName:(NSString *)normalImage
        selectedBackgroundImageName:(NSString *)selectedImage
                           target:(id)target
                           action:(SEL)action {
    
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:normalTitle forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setTitle:selectedTitle forState:UIControlStateSelected];
    [button setBackgroundImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

+ (UIButton *)buttonWithBackgroundColor:(UIColor *)backgroundColor
                                  title:(NSString *)title
                               fontSize:(CGFloat)fontSize
                             titleColor:(UIColor *)titleColor
                                 target:(id)target
                                 action:(SEL)action
                          clipsToBounds:(BOOL)clipsToBounds {
    
    UIButton *button = [[UIButton alloc] init];
    button.backgroundColor = backgroundColor;
    button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    if (clipsToBounds) {
        button.layer.cornerRadius = 5;
    }
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}


+ (UIButton *)checkMarkButtonWithtarget:(id)target
                                 action:(SEL)action {
    return [UIButton buttonWithImageName:@"singleSelectDefaultMark"
                       selectedImageName:@"yesMarkSmall"
                                  target:target
                                  action:action];
}

+ (UIButton *)createExclusiveButton {
    UIButton *button =[UIButton buttonWithTitle:@"独家"
                                     titleColor:Color_TintWhite
                                backgroundColor:[UIColor orangeColor]
                                       fontSize:12
                                         target:nil
                                         action:nil];
    button.userInteractionEnabled = NO;
    return button;
}


@end
