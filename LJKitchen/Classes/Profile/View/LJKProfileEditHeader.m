//
//  LJKProfileEditHeader.m
//  LJKitchen
//
//  Created by  a on 16/6/28.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKProfileEditHeader.h"

#import <Masonry.h>
@interface LJKProfileEditHeader ()
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UIButton *uploadIcon;
@end


@implementation LJKProfileEditHeader
#pragma mark - 懒加载
- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        _iconView.userInteractionEnabled = YES;
        [_iconView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(upload)]];
    }
    return _iconView;
}

- (UIButton *)uploadIcon {
    if (!_uploadIcon) {
        _uploadIcon = [UIButton buttonWithTitle:@"上传我的头像"
                                     titleColor:Color_TintWhite
                                backgroundColor:[UIColor clearColor]
                                       fontSize:15
                                         target:self
                                         action:@selector(upload)];
        [_uploadIcon setBackgroundImage:[UIImage imageNamed:@"exit_Button"] forState:UIControlStateNormal];
    }
    return _uploadIcon;
}


#pragma mark - 构造方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.iconView];
        [self addSubview:self.uploadIcon];
        
        [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(LJKAuthorIconsWH, LJKAuthorIconsWH));
            make.top.equalTo(self.mas_top).offset(20);
            make.centerX.equalTo(self.mas_centerX);
        }];
        
        [_uploadIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.iconView.mas_bottom).offset(LJKAuthorIcon2CellTop);
            make.centerX.equalTo(self.mas_centerX);
            make.width.equalTo(@(SCREEN_WIDTH * 0.3));
            make.height.equalTo(@(30));
        }];
    }
    return self;
}

#pragma mark - 传入新头像 
- (void)setDisplayIcon:(UIImage *)displayIcon {
    if (displayIcon) {
        self.iconView.image = displayIcon;
    } else {
        self.iconView.image = [UIImage imageNamed:@"defaultUserHeader"];
    }
}

#pragma mark - 点击事件
- (void)upload {
    !self.uploadIconBlock ? : self.uploadIconBlock();
}


@end
