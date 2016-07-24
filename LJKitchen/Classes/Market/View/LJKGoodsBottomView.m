//
//  LJKGoodsBottomView.m
//  LJKitchen
//
//  Created by  a on 16/7/15.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKGoodsBottomView.h"
#import <Masonry.h>

@interface LJKGoodsBottomView ()
/** 底部工具条 - 前往店铺 */
@property (nonatomic, strong) UIView *shopIcon;
/** 底部工具条 - 联系卖家 */
@property (nonatomic, strong) UIView *contactIcon;
/** 底部工具条 - (将该商品)加入购物车 */
@property (nonatomic, strong) UIButton *addToCart;
/** 底部工具条 - 立即购买 */
@property (nonatomic, strong) UIButton *buyNow;
@end

@implementation LJKGoodsBottomView

#pragma mark - 构造方法
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = Color_BackGround;

        _shopIcon = [UIView createVerticalIconViewWithImage:[UIImage imageNamed:@"tabBSelected"]
                                                      title:@"店铺"];
        UITapGestureRecognizer *tapShop = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(iconDidClicked:)];
        _shopIcon.tag = 20;
        [_shopIcon addGestureRecognizer:tapShop];
        
        _contactIcon = [UIView createVerticalIconViewWithImage:[UIImage imageNamed:@"tabCSelected"]
                                                         title:@"联系卖家"];
        UITapGestureRecognizer *tapContact = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(iconDidClicked:)];
        _contactIcon.tag = 21;
        [_contactIcon addGestureRecognizer:tapContact];
        
        _addToCart = [UIButton buttonWithTitle:@"加入购物车"
                                    titleColor:Color_TintWhite
                               backgroundColor:Color_ThemeColor
                                      fontSize:15 target:self
                                        action:@selector(buttonDidClicked:)];
        _addToCart.tag = 22;
        
        _buyNow = [UIButton buttonWithTitle:@"立即购买"
                                 titleColor:Color_TintWhite
                            backgroundColor:Color_ThemeColor
                                   fontSize:15 target:self
                                     action:@selector(buttonDidClicked:)];
        _buyNow.tag = 23;
        
        [self addSubview:_shopIcon];
        [self addSubview:_contactIcon];
        [self addSubview:_addToCart];
        [self addSubview:_buyNow];
        
        CGFloat iconWidth = 60;
        CGFloat buttonWidth = (SCREEN_WIDTH -  iconWidth *2 - 1) / 2;
        
        [_shopIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(60, 60));
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(self.mas_left);
        }];
        
        [_contactIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(60, 60));
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(self.shopIcon.mas_right);
        }];
        
        [_addToCart mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(buttonWidth, 60));
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(self.contactIcon.mas_right);
        }];
        
        [_buyNow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(buttonWidth, 60));
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(self.addToCart.mas_right).offset(1);
        }];
    }
    return self;
}

#pragma - 点击事件 
// 左侧图标点击 (联系卖家 、 前往店铺)
- (void)iconDidClicked:(id)sender {
    UITapGestureRecognizer *tap = (UITapGestureRecognizer *)sender;
    !self.clickBlock ? : self.clickBlock(tap.view.tag);
}

// 右侧按钮点击 (立即购买 、 加入购物车)
- (void)buttonDidClicked:(UIButton *)button {
    !self.clickBlock ? : self.clickBlock(button.tag);
}

//- (void)shopIconDidClicked:(id)sender {
//    UITapGestureRecognizer *tap = (UITapGestureRecognizer *)sender;
//    !self.clickBlock ? : self.clickBlock(tap.view.tag);
//}
//
//- (void)contactIconDidClicked:(id)sender {
//    UITapGestureRecognizer *tap = (UITapGestureRecognizer *)sender;
//    !self.clickBlock ? : self.clickBlock(tap.view.tag);
//}

//- (void)buyNowDidClicked:(UIButton *)button {
//    !self.clickBlock ? : self.clickBlock(button.tag);
//}

@end
