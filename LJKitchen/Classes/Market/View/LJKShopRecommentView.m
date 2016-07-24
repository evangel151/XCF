//
//  LJKShopRecommentView.m
//  LJKitchen
//
//  Created by  a on 16/7/14.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKShopRecommentView.h"

#import <Masonry.h>

@interface LJKShopRecommentView ()
@property (nonatomic, strong) UIView *shopView;

//@property (nonatomic, strong) UIImageView *shopImage;
//@property (nonatomic, strong) UILabel *shopName;
//@property (nonatomic, strong) UILabel *priceLabel;
//@property (nonatomic, strong) UILabel *detailLabel;

@end

@implementation LJKShopRecommentView

/** 快速创建 */
+ (instancetype)createShopRecommentViewWithShopImageName:(NSString *)imageName
                                                shopName:(NSString *)shopName
                                                   price:(NSString *)price
                                                  detail:(NSString *)detail {
    
    LJKShopRecommentView *shopView = [[LJKShopRecommentView alloc] init];
    shopView.shopImage.image = [UIImage imageNamed:imageName];
    shopView.shopName.text = shopName;
    shopView.priceLabel.text = price;
    shopView.detailLabel.text = detail;
    return shopView;
}

#pragma mark - 构造方法
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        _shopView = [[UIView alloc] init];
        [self addSubview:_shopView];
        
        _shopImage = [[UIImageView alloc] init];
        [self.shopView addSubview:_shopImage];
        
        _shopName = [UILabel labelWithTextColor:Color_TintBlack
                                backgroundColor:Color_Clear
                                       fontSize:13
                                          lines:1
                                  textAlignment:NSTextAlignmentLeft];
        [self.shopView  addSubview:_shopName];
        
        _priceLabel = [UILabel labelWithTextColor:Color_ThemeColor
                                  backgroundColor:Color_Clear
                                         fontSize:13
                                            lines:1
                                    textAlignment:NSTextAlignmentLeft];
        [self.shopView  addSubview:_priceLabel];
        
        _detailLabel = [UILabel labelWithTextColor:Color_DarkGray
                                   backgroundColor:Color_Clear
                                          fontSize:13
                                             lines:1
                                     textAlignment:NSTextAlignmentLeft];
        [self.shopView  addSubview:self.detailLabel];
        
        CGFloat shopViewWidth = (SCREEN_WIDTH - 80) / 3;
        
        [_shopView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        [_shopImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(shopViewWidth, shopViewWidth));
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(self.mas_top);
        }];
        
        [_shopName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(shopViewWidth, 20));
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(self.shopImage.mas_bottom);;
        }];
        
        [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(self.shopName);
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(self.shopName.mas_bottom);;
        }];
        
        [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(self.shopName);
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(self.priceLabel.mas_bottom);;
        }];
    }
    return self;
}



@end
