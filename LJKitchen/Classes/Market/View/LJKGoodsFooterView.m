//
//  LJKGoodsFooterView.m
//  LJKitchen
//
//  Created by  a on 16/7/16.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKGoodsFooterView.h"

#import <Masonry.h>

@interface LJKGoodsFooterView ()
/** 商品 - 底部视图 - 提示拖动 */
@property (nonatomic, strong) UILabel *promptDargLabel;
/** 分隔线 */
@property (nonatomic, strong) UIView *separtorLineLeft;
@property (nonatomic, strong) UIView *separtorLineRight;
@end

@implementation LJKGoodsFooterView

#pragma mark - 构造方法
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _promptDargLabel = [UILabel labelWithTextColor:Color_DarkGray
                                       backgroundColor:Color_Clear
                                              fontSize:15
                                                 lines:1
                                         textAlignment:NSTextAlignmentCenter];
        _promptDargLabel.text = @"继续拖动，查看详情";
        [self.contentView addSubview:_promptDargLabel];
        
        _separtorLineLeft = [[UIView alloc] init];
        _separtorLineLeft.backgroundColor = Color_DarkGray;
        [self.contentView addSubview:_separtorLineLeft];
        
        _separtorLineRight = [[UIView alloc] init];
        _separtorLineRight.backgroundColor = Color_DarkGray;
        [self.contentView addSubview:_separtorLineRight];
        
        CGFloat separtorLineWidth = (SCREEN_WIDTH - 20 * 2) / 4;
        
        [_promptDargLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.equalTo(self.contentView);
            make.height.equalTo(@(30));
        }];
        
        [_separtorLineLeft mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(separtorLineWidth, 1));
            make.left.equalTo(self.contentView.mas_left).offset(20);
        }];
        
        [_separtorLineRight mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(separtorLineWidth, 1));
            make.right.equalTo(self.contentView.mas_right).offset(-20);
        }];
    }
    return self;
}

@end
