//
//  LJKMarketHotItem.m
//  LJKitchen
//
//  Created by  a on 16/7/15.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKMarketHotItem.h"

#import <Masonry.h>

@interface LJKMarketHotItem ()

@end

@implementation LJKMarketHotItem

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = Color_BackGround;
        
        _mainImage = [[UIImageView alloc] init];
        _mainImage.layer.cornerRadius = 5;
        [self.contentView addSubview:_mainImage];
        
        _titleLabel = [UILabel labelWithTextColor:Color_TintWhite
                                  backgroundColor:Color_Clear
                                         fontSize:13 lines:1
                                    textAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:_titleLabel];
        
        [_mainImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.height.equalTo(@(20));
        }];
    }
    return self;
}

@end
