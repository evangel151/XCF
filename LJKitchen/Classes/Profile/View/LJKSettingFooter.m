//
//  LJKSettingFooter.m
//  LJKitchen
//
//  Created by  a on 16/6/10.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKSettingFooter.h"
#import <Masonry.h>

@interface LJKSettingFooter ()


@end

@implementation LJKSettingFooter

#pragma mark - 懒加载
- (UIButton *)exit {
    if (!_exit) {
        _exit = [[UIButton alloc] init];
        _exit.titleLabel.textColor = [UIColor whiteColor];
        [_exit setTitle:@"退出LJKitchen" forState:UIControlStateNormal];
        [_exit setBackgroundImage:[UIImage imageNamed:@"exit_Button"]
                         forState:UIControlStateNormal];
    }
    return _exit;
}

- (UILabel *)version {
    if (!_version) {
        _version = [[UILabel alloc] init];
        _version.textColor = Color_DarkGray;
        _version.font = [UIFont systemFontOfSize:21];
        _version.textAlignment = NSTextAlignmentCenter;
    }
    return _version;
}

#pragma mark - 构造方法
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 120);
        [self addSubview:self.version];
        [self addSubview:self.exit];
    }
    return self;
}

+ (instancetype)settingFooter {
    return [[self alloc] init];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.exit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(30);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH * 0.7, 50));
    }];
    
    [self.version mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(_exit);
        make.top.equalTo(_exit.mas_bottom);
        make.centerX.equalTo(self);
    }];
}

@end
