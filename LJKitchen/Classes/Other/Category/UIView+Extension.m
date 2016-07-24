//
//  UIView+Extension.m
//  LJKitchen
//
//  Created by  a on 16/7/15.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "UIView+Extension.h"
#import <Masonry.h>


@implementation UIView (Extension)


+ (UIView *)createVerticalIconViewWithImage:(UIImage *)image
                                      title:(NSString *)title {
    
    UIView *iconView = [[UIView alloc] init];
    UIImageView *icon = [[UIImageView alloc] init];
    icon.image = image;
    
    UILabel *titleLabel = [UILabel labelWithTextColor:Color_DarkGray
                                      backgroundColor:Color_Clear
                                             fontSize:10
                                                lines:1
                                        textAlignment:NSTextAlignmentCenter];
    titleLabel.text = title;
    [iconView addSubview:icon];
    [iconView addSubview:titleLabel];
    
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(iconView).insets(UIEdgeInsetsMake(10, 17, 24, 17));
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(icon.mas_bottom).offset(3);
        make.centerX.equalTo(iconView.mas_centerX);
        make.bottom.equalTo(iconView.mas_bottom).offset(-3);
    }];
    
    return iconView;
}

+ (UIView *)createVerticalIconViewWithImage:(UIImage *)image
                                      title:(NSString *)title
                                     target:(id)target
                                     action:(SEL)action {
    UIView *iconView = [UIView createVerticalIconViewWithImage:image title:title];
    UITapGestureRecognizer *tapIcon = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [iconView addGestureRecognizer:tapIcon];
    
    return iconView;
}

@end
