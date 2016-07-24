//
//  LJKBLSViewHeader.m
//  LJKitchen
//
//  Created by  a on 16/6/21.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKBLSViewHeader.h"
#import "LJKBLSHeaderData.h"
#import <Masonry.h>

@interface LJKBLSViewHeader ()
/** 三餐分类 + 日期 */
@property (nonatomic, strong) UILabel *mainLabel;
/** 作品数 */
@property (nonatomic, strong) UILabel *countLabel;
/** 细节描述 */
@property (nonatomic, strong) UILabel *descLabel;

@end

@implementation LJKBLSViewHeader

- (UILabel *)mainLabel {
    if (!_mainLabel) {
        self.mainLabel = [UILabel labelWithTextColor:[UIColor blackColor]
                                     backgroundColor:[UIColor clearColor]
                                            fontSize:15
                                               lines:1
                                       textAlignment:NSTextAlignmentCenter];
    }
    return _mainLabel;
}

- (UILabel *)countLabel {
    if (!_countLabel) {
        self.countLabel = [UILabel labelWithTextColor:Color_DarkGray
                                      backgroundColor:[UIColor clearColor]
                                             fontSize:13
                                                lines:1
                                        textAlignment:NSTextAlignmentCenter];
    }
    return _countLabel;
}

- (UILabel *)descLabel {
    if (!_descLabel) {
        self.descLabel = [UILabel labelWithTextColor:[UIColor blackColor]
                                     backgroundColor:[UIColor clearColor]
                                            fontSize:15
                                               lines:1
                                       textAlignment:NSTextAlignmentCenter];
    }
    return _descLabel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.descLabel];
        [self addSubview:self.countLabel];
        [self addSubview:self.mainLabel];
        

        
        [_mainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(15);
            make.centerX.equalTo(self.mas_centerX);
            make.height.equalTo(@(20));
        }];
        
        [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mainLabel.mas_bottom);
            make.centerX.equalTo(self.mas_centerX);
            make.height.equalTo(@(20));
        }];
        
        [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.countLabel.mas_bottom);
            make.centerX.equalTo(self.mas_centerX);
            make.height.equalTo(@(35));
        }];
    }
    return self;
}

- (void)setData:(LJKBLSHeaderData *)data {
    _data = data;
    
    self.mainLabel.text = data.name;
    self.countLabel.text = [NSString stringWithFormat:@"%@道菜肴",data.n_dishes];
    self.descLabel.text = data.desc;
    
    if (!data) { // 测试数据
        self.mainLabel.text = @"早餐.6月21日";
        self.countLabel.text = @"999道菜肴";
        self.descLabel.text = @"早上好，今天是星期二";
    }
}

@end
