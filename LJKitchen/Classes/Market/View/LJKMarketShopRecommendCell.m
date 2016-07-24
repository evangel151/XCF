//
//  LJKMarketShopRecommendCell.m
//  LJKitchen
//
//  Created by  a on 16/7/14.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  Done 

#import "LJKMarketShopRecommendCell.h"
#import "LJKShopRecommentView.h"

#import <Masonry.h>

@interface LJKMarketShopRecommendCell ()
@property (nonatomic, strong) UILabel *recommendTitle;
@property (nonatomic, strong) UIView *separtorLine;
@property (nonatomic, strong) UIView *recommendView;
@end

@implementation LJKMarketShopRecommendCell

#pragma mark - 懒加载
- (UIView *)recommendView {
    if (!_recommendView) {
        _recommendView = [[UIView alloc] init];
    }
    return _recommendView;
}


- (UIView *)separtorLine {
    if (!_separtorLine) {
        _separtorLine = [[UIView alloc] init];
        _separtorLine.backgroundColor = Color_DarkGray;
    }
    return _separtorLine;
}

- (UILabel *)recommendTitle {
    if (!_recommendTitle) {
        _recommendTitle = [UILabel labelWithTextColor:Color_TintBlack
                                      backgroundColor:Color_Clear
                                             fontSize:15
                                                lines:1
                                        textAlignment:NSTextAlignmentLeft];
        _recommendTitle.text = @"好店推荐";
    }
    return _recommendTitle;
}

#pragma mark - 构造方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.recommendTitle];
        [self.contentView addSubview:self.recommendView];
        [self.contentView addSubview:self.separtorLine];
        
        CGFloat margin = 20;
        CGFloat shopItemWidth  = (SCREEN_WIDTH - 4 * margin) / 3;
        CGFloat shopItemHeight = shopItemWidth + 60;
        NSArray *imageArray    = @[@"shopItem_left", @"shopItem_middle", @"shopItem_right"];
        NSArray *shopNameArray = @[@"老北京酸梅汤料", @"德运全脂奶粉", @"三色藜麦400g"];
        NSArray *priceArray    = @[@"￥ 1", @"￥ 58", @"￥ 36.9"];
        NSArray *detailArray   = @[@"更多优惠领券再减", @"澳洲奶源限时特价", @"健康主食营养丰富"];
        
        // FIXME:(已解决) 按钮点击无反应
        // 父视图(容器)size 设置与buttons 不符， 实际点击时超出了父视图范围，无法触发响应链条
        for (NSUInteger index = 0; index < imageArray.count; index++) {

            LJKShopRecommentView *shop =
            [LJKShopRecommentView createShopRecommentViewWithShopImageName:imageArray[index]
                                                                  shopName:shopNameArray[index]
                                                                     price:priceArray[index]
                                                                    detail:detailArray[index]];
            UITapGestureRecognizer *tapShop = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                      action:@selector(shopItemDidClicked:)];
            [shop addGestureRecognizer:tapShop];
            shop.frame = CGRectMake(margin + (shopItemWidth + margin) * index, 0, shopItemWidth, shopItemHeight);
            shop.tag = index + 10;
            [self.recommendView addSubview:shop];
        }
        
        
        [_recommendTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 40, 30));
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.top.equalTo(self.contentView.mas_top);
        }];
        
        [_recommendView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, shopItemHeight));
            make.top.equalTo(self.recommendTitle.mas_bottom).offset(5);
            make.centerX.equalTo(self.contentView.mas_centerX);
        }];
        
        [_separtorLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 1));
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.bottom.equalTo(self.contentView.mas_bottom);
        }];
        
    }
    return self;
}

#pragma mark - 点击事件
- (void)shopItemDidClicked:(id)sender {
    UITapGestureRecognizer *tap = (UITapGestureRecognizer *)sender;
    !self.clickedBlock ? : self.clickedBlock(tap.view.tag);
}

@end
