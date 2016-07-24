//
//  LJKHomeHeaderNavButton.m
//  LJKitchen
//
//  Created by  a on 16/6/12.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKHomeHeaderNavButton.h"
#import "LJKNav.h"

#import <Masonry.h>
#import <UIImageView+WebCache.h>

@interface LJKHomeHeaderNavButton ()

/** 按钮图片 */
@property (nonatomic, strong) UIImageView *imageV;
/** 按钮背景图片 */
@property (nonatomic, strong) UIImageView *imageB;
/** 按钮标题 */
@property (nonatomic, strong) UILabel *titleL;
/** 跳转url */
@property (nonatomic, copy) NSString *url;

@end

@implementation LJKHomeHeaderNavButton

#pragma mark - 懒加载
- (UIImageView *)imageV {
    if (!_imageV) {
        _imageV = [[UIImageView alloc] init];
    }
    return _imageV;
}

- (UILabel *)titleL  {
    if (!_titleL) {
        _titleL = [[UILabel alloc] init];
        _titleL.font = [UIFont systemFontOfSize:13];
        _titleL.textColor = Color_TintBlack;
    }
    return _titleL;
}


#pragma mark - 构造方法 & 模型传入
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.titleL];
        [self addSubview:self.imageV];
        
        [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self).offset(-15);
            make.size.mas_equalTo(CGSizeMake(45, 45));
        }];
        
        [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self).offset(15);
        }];
        
    }
    return self;
}

/** 从网络（模型中）获取导航按钮的图标及标题 */
+ (nonnull LJKHomeHeaderNavButton *)buttonWithNav:(nonnull LJKNav *)nav
                                           target:(nullable id)target
                                           action:(nullable SEL)action {
    
    LJKHomeHeaderNavButton *button = [[LJKHomeHeaderNavButton alloc] init];
    [button.imageV sd_setImageWithURL:[NSURL URLWithString:nav.picurl]];
    button.titleL.text = nav.name;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}





/** 没有网络的时候再考虑从本地加载按钮图片及文字 */
+ (nonnull LJKHomeHeaderNavButton *)buttonWithImageName:(nonnull NSString *)imageName
                                                  title:(nonnull NSString *)title
                                                 target:(nullable id)target
                                                 action:(nullable SEL)action {
    
    LJKHomeHeaderNavButton *button = [[LJKHomeHeaderNavButton alloc] init];
    button.imageV.image = [UIImage imageNamed:imageName];
    button.titleL.text = title;
//    button.imageV.contentMode = UIViewContentModeScaleAspectFit;
    
    // 当传入的是固定的图片时，更新原有约束 
    [button.imageV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(button);
        make.top.equalTo(button).offset(10);
        make.size.mas_equalTo(CGSizeMake(30, 30));
        // Market 界面中导航按钮不适用该约束 -> 应该略微大图片
    }];
    
    [button.titleL mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(button);
        make.top.equalTo(button.imageV.mas_bottom).offset(20);
    }];
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

// 大图模式
+ (nonnull LJKHomeHeaderNavButton *)buttonWithLargeImageName:(nonnull NSString *)imageName
                                                       title:(nonnull NSString *)title
                                                      target:(nullable id)target
                                                      action:(nullable SEL)action {
    
    LJKHomeHeaderNavButton *button = [[LJKHomeHeaderNavButton alloc] init];
    button.imageV.image = [UIImage imageNamed:imageName];
    button.titleL.text = title;
    
    // 修改约束 (配合大图)
    [button.imageV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(button);
        make.top.equalTo(button).offset(5);
        make.size.mas_equalTo(CGSizeMake(55, 55));
    }];
    
    [button.titleL mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(button);
        make.top.equalTo(button.imageV.mas_bottom).offset(5);
    }];
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}


@end
