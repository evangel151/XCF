//
//  UILabel+Extension.m
//  LJKitchen
//
//  Created by  a on 16/6/19.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)
+ (UILabel *)labelWithTextColor:(UIColor *)textColor
                backgroundColor:(UIColor *)backgroundColor
                       fontSize:(CGFloat)fontSize
                          lines:(NSUInteger)lines
                  textAlignment:(NSTextAlignment)textAlignment {
    
    UILabel *label = [[UILabel alloc] init];
    label.textColor = textColor;
    label.backgroundColor = backgroundColor;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.numberOfLines = lines;
    label.textAlignment = textAlignment;
    return label;
}

- (void)setAttributeTextWithString:(NSString *)string range:(NSRange)range {
    NSMutableAttributedString *attrsString = [[NSMutableAttributedString alloc] initWithString:string];
    [attrsString addAttribute:NSForegroundColorAttributeName value:Color_ThemeColor range:range];
    self.attributedText = attrsString;
}

- (void)setAttributeTextWithString:(NSString *)string range:(NSRange)range color:(id)color {
    NSMutableAttributedString *attrsString = [[NSMutableAttributedString alloc] initWithString:string];
    [attrsString addAttribute:NSForegroundColorAttributeName value:color range:range];
    self.attributedText = attrsString;
}


+ (void)showMessage:(NSString *)string atNavController:(UINavigationController *)navController {
    
    
    UILabel *label = [UILabel labelWithTextColor:Color_TintWhite
                                 backgroundColor:[UIColor orangeColor]
                                         fontSize:15
                                            lines:1
                                    textAlignment:NSTextAlignmentCenter];
    

    label.top = 20;
    label.width = SCREEN_WIDTH;
    label.height = TABBAR_HEIGHT;
    label.text = string;
    
    // 添加label到导航条  below to 导航栏
    [navController.view insertSubview:label belowSubview:navController.navigationBar];
    // 动画显示
    // * 如果一个动画执行完毕后需要返回原本的样子 -> 使用transform属性(使用identity属性可以恢复原有属性 -> 方便)
    CGFloat duration = 1.0;
    CGFloat delay = 1.0;
    [UIView animateWithDuration:duration animations:^{ // 动画1: 提示框出现
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
    } completion:^(BOOL finished) {
        
        // 动画2: 停留1秒 + 恢复原始状态
        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveLinear animations:^{
            // label.y -= label.height;
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
}

@end
