//
//  LJKHomeHeaderDish.m
//  LJKitchen
//
//  Created by  a on 16/6/13.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKHomeHeaderDish.h"
#import "LJKPopEvent.h"

#import <Masonry.h>
#import <UIImageView+WebCache.h>

@interface LJKHomeHeaderDish ()
/** 三餐 - 左侧主题图片(早/中/晚) */
@property (nonatomic, strong) UIImageView *imageView_Back;
/** 三餐 - 右侧描述图片(小图) */
@property (nonatomic, strong) UIImageView *imageView_Right;
/** 三餐 - 标题栏 */
@property (nonatomic, strong) UILabel *titleLabel;
/** 三餐 - 菜谱数量(早/中/晚) */
@property (nonatomic, strong) UILabel *numberLabel;

@end

@implementation LJKHomeHeaderDish

#pragma mark - 懒加载
- (UIImageView *)imageView_Back {
    if (!_imageView_Back) {
        self.imageView_Back = [[UIImageView alloc] init];
    }
    return _imageView_Back;
}

- (UIImageView *)imageView_Right {
    if (!_imageView_Right) {
        self.imageView_Right = [[UIImageView alloc] init];
    }
    return _imageView_Right;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithTextColor:Color_TintBlack
                                  backgroundColor:Color_Clear
                                         fontSize:17
                                            lines:1
                                    textAlignment:NSTextAlignmentCenter];
    }
    return _titleLabel;
}

- (UILabel *)numberLabel {
    if (!_numberLabel) {
        _numberLabel = [UILabel labelWithTextColor:Color_DarkGray
                                   backgroundColor:Color_Clear
                                          fontSize:13
                                             lines:1
                                     textAlignment:NSTextAlignmentCenter];
    }
    return _numberLabel;
}

#pragma mark - 构造方法
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.imageView_Back];
        [self addSubview:self.imageView_Right];
        [self addSubview:self.titleLabel];
        [self addSubview:self.numberLabel];
        
        [self.imageView_Back mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        [self.imageView_Right mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(10);
            make.bottom.equalTo(self.mas_bottom).offset(-10);
            make.right.equalTo(self.mas_right).offset(-20);
            make.width.equalTo(@(60));
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.bottom.equalTo(self.mas_centerY).offset(-5);
        }];
        
        [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.mas_centerY).offset(5);
        }];
        
    }
    return self;
}

#pragma mark - 模型传入
- (void)setPopEvent:(LJKPopEvent *)popEvent {
    _popEvent = popEvent;
    
    [self.imageView_Right sd_setImageWithURL:[NSURL URLWithString:popEvent.thumbnail_280]];
    
    NSString *name = [popEvent.name substringToIndex:2];
    self.titleLabel.text = [NSString stringWithFormat:@"— %@ —", name];
    self.numberLabel.text = [NSString stringWithFormat:@"%@作品", popEvent.n_dishes];
    
    if ([name isEqualToString:@"早餐"]) {
        self.imageView_Back.image = [UIImage imageNamed:@"themeSmallPicForBreakfast"];
    } else if ([name isEqualToString:@"午餐"]) {
        self.imageView_Back.image = [UIImage imageNamed:@"themeSmallPicForLaunch"];
    } else if ([name isEqualToString:@"晚餐"]) {
        self.imageView_Back.image = [UIImage imageNamed:@"themeSmallPicForSupper"];
    }

}

#pragma mark - init 
+ (nonnull LJKHomeHeaderDish *)viewWithPopEvent:(nonnull LJKPopEvent *)popEvent
                                         target:(nullable id)target
                                         action:(nullable SEL)action {
    LJKHomeHeaderDish *dish = [[LJKHomeHeaderDish alloc] init];
    dish.popEvent = popEvent;
    [dish addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:target action:action]];
    return dish;
}

@end
