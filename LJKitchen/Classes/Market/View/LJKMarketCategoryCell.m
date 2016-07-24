//
//  LJKMarketCategoryCell.m
//  LJKitchen
//
//  Created by  a on 16/7/14.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKMarketCategoryCell.h"
#import "LJKHomeHeaderNavButton.h"

#import <Masonry.h>

@interface LJKMarketCategoryCell ()
@property (nonatomic, strong) UIView *marketCategoryView; // 容器
@property (nonatomic, strong) UIView *separtorLine;
@end

@implementation LJKMarketCategoryCell
#pragma mark - 懒加载
- (UIView *)separtorLine {
    if (!_separtorLine) {
        _separtorLine = [[UIView alloc] init];
        _separtorLine.backgroundColor = Color_DarkGray;
    }
    return _separtorLine;
}


- (UIView *)marketCategoryView {
    if (!_marketCategoryView) {
        _marketCategoryView = [[UIView alloc] init];
        _marketCategoryView.backgroundColor = [UIColor whiteColor];
    }
    return _marketCategoryView;
}

#pragma mark - 构造方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.marketCategoryView];
        [self.contentView addSubview:self.separtorLine];
        
        [_marketCategoryView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 180));
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.top.equalTo(self.contentView.mas_top);
        }];
        
        [_separtorLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 1));
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.bottom.equalTo(self.contentView.mas_bottom);
        }];
        
        [self setupNavibuttons];

    }
    return self;
}

- (void)setupNavibuttons {
    
    NSArray *imageArray = @[@"market_cure", @"market_fresh", @"market_tableware", @"market_promotion",@"market_fastFood", @"market_importFood", @"market_condiment", @"market_all"];
    NSArray *titleArray = @[@"烘焙", @"果蔬生鲜", @"器具", @"领券中心",@"方便食品", @"进口食品", @"调味品", @"全部分类"];
    
    // 九宫格布局
    NSUInteger maxCol = 4;
    CGFloat buttonWidth = SCREEN_WIDTH / maxCol ;
    CGFloat buttonHeight = LJKHomeHeader_CenterNav_Height;
    
    for (NSUInteger index = 0; index < titleArray.count; index++) {
        LJKHomeHeaderNavButton *button = [LJKHomeHeaderNavButton buttonWithLargeImageName:imageArray[index]
                                                                                    title:titleArray[index]
                                                                                   target:self
                                                                                   action:@selector(navButtonDidClick:)];
        
        NSUInteger row = index / maxCol;
        NSUInteger col = index % maxCol;
        button.frame = CGRectMake(col * buttonWidth, row * buttonHeight, buttonWidth, buttonHeight);
        button.tag = index + 20;
        [self.marketCategoryView addSubview:button];
    }
}

#pragma mark - 点击事件
- (void)navButtonDidClick:(LJKHomeHeaderNavButton *)button {
    !self.clickBlock ? : self.clickBlock(button.tag);
}

@end
