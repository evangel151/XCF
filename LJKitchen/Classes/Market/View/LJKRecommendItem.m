//
//  LJKRecommendItem.m
//  LJKitchen
//
//  Created by  a on 16/7/16.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  Done

#import "LJKRecommendItem.h"
#import <Masonry.h>

@implementation LJKRecommendItem

#pragma mark - 构造方法
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        _mainImage = [[UIImageView alloc] init];
        [self.contentView addSubview:_mainImage];
        
        _goodsNameLabel = [UILabel labelWithTextColor:Color_TintBlack
                                      backgroundColor:Color_Clear
                                             fontSize:13
                                                lines:2
                                    textAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:_goodsNameLabel];
        
        _priceLabel = [UILabel labelWithTextColor:Color_ThemeColor
                                  backgroundColor:Color_Clear
                                         fontSize:13
                                            lines:1
                                    textAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:_priceLabel];
        
        CGFloat imageWH = (SCREEN_WIDTH - 80) / 3;
        [_mainImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self.contentView);
            make.height.equalTo(@(imageWH));
        }];
        
        [_goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(5);
            make.right.equalTo(self.contentView.mas_right).offset(-5);
            make.top.equalTo(self.mainImage.mas_bottom).offset(5);
            make.height.equalTo(@(30));
        }];
        
        [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.goodsNameLabel);
            make.top.equalTo(self.goodsNameLabel.mas_bottom).offset(5);
            make.height.equalTo(@(20));
        }];
    }
    return self;
}

@end
