//
//  LJKMarketSpreadCell.m
//  LJKitchen
//
//  Created by  a on 16/7/14.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKMarketSpreadCell.h"

#import <Masonry.h>

@interface LJKMarketSpreadCell ()
/** 推广图片 */
@property (nonatomic, strong) UIImageView *spreadImage;
@property (nonatomic, strong) UIView *separtorLine;

@end

@implementation LJKMarketSpreadCell

#pragma mark - 懒加载
- (UIImageView *)spreadImage {
    if (!_spreadImage) {
        _spreadImage = [[UIImageView alloc] init];
        _spreadImage.image = [UIImage imageNamed:@"marketSpread"];
    }
    return _spreadImage;
}


- (UIView *)separtorLine {
    if (!_separtorLine) {
        _separtorLine = [[UIView alloc] init];
        _separtorLine.backgroundColor = Color_DarkGray;
    }
    return _separtorLine;
}

#pragma mark - 构造方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.spreadImage];
        [self.contentView addSubview:self.separtorLine];
        
        [_spreadImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH * 0.6));
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.top.equalTo(self.contentView.mas_top);
        }];
        
        [_separtorLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 1));
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.bottom.equalTo(self.contentView.mas_bottom);
        }];
        
    }
    return self;
}

@end
