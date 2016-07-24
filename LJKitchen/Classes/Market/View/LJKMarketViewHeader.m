//
//  LJKMarketViewHeader.m
//  LJKitchen
//
//  Created by  a on 16/7/14.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  Done

#import "LJKMarketViewHeader.h"
#import "LJKAuthor.h"
#import "LJKAuthorDetail.h"

#import <Masonry.h>

@interface LJKMarketViewHeader ()
/** 市集header - 位置 (容器) */
@property (nonatomic, strong) UIView *locationView;
/** 市集header - 位置 */
@property (nonatomic, strong) UILabel *locationLabel;
/** 市集header - 分隔线 */
@property (nonatomic, strong) UIView *separtorLine;
@end

@implementation LJKMarketViewHeader

#pragma mark - 懒加载
- (UIView *)locationView {
    if (!_locationView) {
        _locationView = [[UIView alloc] init];
        UITapGestureRecognizer *tapLocation = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                      action:@selector(changeLocation)];
        [_locationView addGestureRecognizer:tapLocation];
    }
    return _locationView;
}

- (UILabel *)locationLabel {
    if (!_locationLabel) {
        _locationLabel = [UILabel labelWithTextColor:Color_ThemeColor
                                     backgroundColor:Color_Clear
                                            fontSize:15
                                               lines:1
                                       textAlignment:NSTextAlignmentCenter];
    }
    return _locationLabel;
}

- (UIView *)separtorLine {
    if (!_separtorLine) {
        _separtorLine = [[UIView alloc] init];
        _separtorLine.backgroundColor = Color_DarkGray;
    }
    return _separtorLine;
}



#pragma mark - 构造方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = Color_TintWhite;
        
        [self addSubview:self.locationView];
        [self.locationView addSubview:self.locationLabel];
        [self.locationView addSubview:self.separtorLine];
        
        [_locationView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 40));
            make.top.equalTo(self.mas_top);
            make.centerX.equalTo(self.mas_centerX);
        }];
        
        [_locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.locationView);
        }];
        
        [_separtorLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 1));
            make.centerX.equalTo(self.mas_centerX);
            make.bottom.equalTo(self.mas_bottom);
        }];
        
    }
    return self;
}

#pragma mark - 传入模型
- (void)setAuthorDetail:(LJKAuthorDetail *)authorDetail {
    _authorDetail = authorDetail;
    
    NSString *frontDesc = @"所在地区:";
    NSString *currentLoca = authorDetail.current_location;
    NSString *locationText = [NSString stringWithFormat:@"%@ %@",frontDesc,currentLoca];
    self.locationLabel.text = locationText;
    [self.locationLabel setAttributeTextWithString:locationText
                                             range:NSMakeRange(0, frontDesc.length)
                                             color:Color_DarkGray];
}

#pragma mark - 点击事件
- (void)changeLocation {
    !self.changeLocationBlock ? : self.changeLocationBlock();
}

@end
