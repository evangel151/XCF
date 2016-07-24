//
//  LJKProfileHeader.m
//  LJKitchen
//
//  Created by  a on 16/6/26.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKProfileHeader.h"
#import "LJKHomeHeaderNavButton.h"
#import "LJKAuthorDetail.h"
#import <Masonry.h>

@interface LJKProfileHeader ()
/** 个人信息(主体) */
@property (nonatomic, strong) UIView *myInfoView;
/** 个人信息(头像) */
@property (nonatomic, strong) UIImageView *myInfoIcon;
/** 个人信息(姓名栏) */
@property (nonatomic, strong) UILabel *myInfoNameLabel;
/** 个人信息(关注数) */
@property (nonatomic, strong) UILabel *myInfoFollowedLabel;
/** 个人信息(粉丝数) */
@property (nonatomic, strong) UILabel *myInfoFansLabel;
/** 个人信息(加入时间) */
@property (nonatomic, strong) UILabel *myInfoSignLabel;
/** 个人信息(背景图片) */
@property (nonatomic, strong) UIImageView *myInfoBackground;

/** 导航按钮组 */
@property (nonatomic, strong) UIView *navButtons;

/** 绑定手机 */
@property (nonatomic, strong) UIView *bindView;
/** 绑定手机(标志) */
@property (nonatomic, strong) UIImageView *bindIcon;
/** 绑定手机(文字) */
@property (nonatomic, strong) UILabel *bindLabel;

/** 分隔线-1 */
@property (nonatomic, strong) UIView *separatorLine1;
/** 分隔线-2 */
@property (nonatomic, strong) UIView *separatorLine2;

@end

@implementation LJKProfileHeader

#pragma mark - 懒加载
#pragma mark 顶部个人信息 

- (UIView *)myInfoView {
    if (!_myInfoView) {
        _myInfoView = [[UIView alloc] init];
        _myInfoView.backgroundColor = [UIColor clearColor];
    }
    return _myInfoView;
}

- (UIImageView *)myInfoIcon {
    if (!_myInfoIcon) {
        _myInfoIcon = [[UIImageView alloc] init];
    }
    return _myInfoIcon;
}

- (UILabel *)myInfoNameLabel {
    if (!_myInfoNameLabel) {
        _myInfoNameLabel = [UILabel labelWithTextColor:Color_TintBlack
                                       backgroundColor:Color_Clear
                                              fontSize:17
                                                 lines:1
                                         textAlignment:NSTextAlignmentLeft];
    }
    return _myInfoNameLabel;
}

- (UILabel *)myInfoFollowedLabel {
    if (!_myInfoFollowedLabel) {
        _myInfoFollowedLabel = [UILabel labelWithTextColor:Color_DarkGray
                                           backgroundColor:[UIColor clearColor]
                                                  fontSize:13
                                                     lines:1
                                             textAlignment:NSTextAlignmentLeft];
    }
    return _myInfoFollowedLabel;
}

- (UILabel *)myInfoFansLabel {
    if (!_myInfoFansLabel) {
        _myInfoFansLabel = [UILabel labelWithTextColor:Color_DarkGray
                                       backgroundColor:Color_Clear
                                              fontSize:13
                                                 lines:1
                                         textAlignment:NSTextAlignmentLeft];
    }
    return _myInfoFansLabel;
}

- (UILabel *)myInfoSignLabel {
    if (!_myInfoSignLabel) {
        _myInfoSignLabel = [UILabel labelWithTextColor:Color_DarkGray
                                       backgroundColor:Color_Clear
                                              fontSize:13
                                                 lines:1
                                         textAlignment:NSTextAlignmentLeft];
    }
    return _myInfoSignLabel;
}

- (UIImageView *)myInfoBackground {
    if (!_myInfoBackground) {
        _myInfoBackground = [[UIImageView alloc] init];
        _myInfoBackground.image = [UIImage imageNamed:@"profile_info_background"];
    }
    return _myInfoBackground;
}

- (UIView *)separatorLine1 {
    if (!_separatorLine1) {
        _separatorLine1 = [[UIView alloc] init];
        _separatorLine1.backgroundColor = Color_DarkGray;
    }
    return _separatorLine1;
}

#pragma mark 中部导航按钮组
- (UIView *)navButtons {
    if (!_navButtons) {
        _navButtons = [[UIView alloc] init];
        _navButtons.userInteractionEnabled = YES;
    }
    return _navButtons;
}

- (UIView *)separatorLine2 {
    if (!_separatorLine2) {
        _separatorLine2 = [[UIView alloc] init];
        _separatorLine2.backgroundColor = Color_ThemeColor;
    }
    return _separatorLine2;
}



#pragma mark 下部绑定手机按钮
- (UIView *)bindView {
    if (!_bindView) {
        _bindView = [[UIView alloc] init];
    }
    return _bindView;
}

- (UIImageView *)bindIcon {
    if (!_bindIcon) {
        _bindIcon = [[UIImageView alloc] init];
        _bindIcon.image = [UIImage imageNamed:@"bindMobile"];
    }
    return _bindIcon;
}

- (UILabel *)bindLabel {
    if (!_bindLabel) {
        _bindLabel = [UILabel labelWithTextColor:Color_ThemeColor
                                 backgroundColor:Color_Clear
                                        fontSize:15
                                           lines:1
                                   textAlignment:NSTextAlignmentLeft];
        _bindLabel.text = @"绑定手机";

    }
    return _bindLabel;
}



#pragma mark - 构造方法
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        // 顶部 个人信息 组件
        [self addSubview:self.myInfoView];
        [self.myInfoView addSubview:self.myInfoBackground];
        [self.myInfoView addSubview:self.myInfoIcon];
        [self.myInfoView addSubview:self.myInfoNameLabel];
        [self.myInfoView addSubview:self.myInfoFollowedLabel];
        [self.myInfoView addSubview:self.myInfoFansLabel];
        [self.myInfoView addSubview:self.myInfoSignLabel];
        [self.myInfoView addSubview:self.separatorLine1];
        
        // 底部 绑定手机 组件
        [self addSubview:self.bindView];
        [self.bindView addSubview:self.bindIcon];
        [self.bindView addSubview:self.bindLabel];
        
        // 中部 导航按钮组
        [self setupNavButtons];
        [self.navButtons addSubview:self.separatorLine2];
        [self addSubview:self.navButtons];
        UITapGestureRecognizer *tapInfoView = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                      action:@selector(myInfoViewDidClick:)];
        self.myInfoView.tag = 1;
        [self.myInfoView addGestureRecognizer:tapInfoView];
        
        UITapGestureRecognizer *tapBindMobile = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                        action:@selector(bindViewDidClick:)];
        self.bindView.tag = 6;
        [self.bindView addGestureRecognizer:tapBindMobile];
        
        // 个人信息 (容器)
        [_myInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, LJKProfileHeader_InfoView_Height));
            make.top.equalTo(self);
            make.left.equalTo(self);
        }];
        
        // 个人信息-背景图片
        [_myInfoBackground mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.myInfoView);
        }];
        
        // 个人信息-头像
        [_myInfoIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.myInfoView.mas_left).offset(LJKAuthorIcon2CellLeft);
            make.centerY.equalTo(self.myInfoView.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(LJKAuthorIconsWH, LJKAuthorIconsWH));
        }];
        
        // 个人信息-姓名栏
        [_myInfoNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.myInfoIcon.mas_right).offset(LJKAuthorIcon2CellLeft);
            make.right.equalTo(self.mas_right).offset(-LJKAuthorIcon2CellLeft);
            make.top.equalTo(self.myInfoIcon.mas_top);
            make.height.equalTo(@(20));
        }];
        
        // 个人信息-关注栏
        [_myInfoFollowedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.myInfoNameLabel.mas_bottom);
            make.left.equalTo(self.myInfoNameLabel.mas_left);
            make.height.equalTo(@(20));
            make.width.equalTo(@(80));
        }];
        
        // 个人信息-粉丝栏
        [_myInfoFansLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.myInfoFollowedLabel.mas_top);
            make.left.equalTo(self.myInfoFollowedLabel.mas_right);
            make.size.mas_equalTo(self.myInfoFollowedLabel);
        }];
        
        // 个人信息-加入时间
        [_myInfoSignLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(self.myInfoNameLabel);
            make.left.equalTo(self.myInfoNameLabel.mas_left);
            make.top.equalTo(self.myInfoFollowedLabel.mas_bottom);
        }];
        
        // 个人信息-分隔线
        [_separatorLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.myInfoView.mas_left);
            make.bottom.equalTo(self.myInfoView.mas_bottom);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 1));
        }];
        
        // 导航按钮组
        [_navButtons mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.myInfoView.mas_bottom);
            make.left.equalTo(self.mas_left);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, LJKHomeHeader_CenterNav_Height));
        }];
        
        // 导航按钮组-分隔线
        [_separatorLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.navButtons.mas_left);
            make.bottom.equalTo(self.navButtons.mas_bottom);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 1));
        }];
        
        // 绑定手机(容器)
        [_bindView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, LJKHomeHeader_NewAuthor_Height));
            make.top.equalTo(self.navButtons.mas_bottom);
            make.left.equalTo(self.mas_left);
        }];
        
        // 绑定手机(图片)
        [_bindIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(30, 30));
            make.top.equalTo(self.bindView.mas_top).offset(7);
            make.right.equalTo(self.bindView.mas_centerX).offset(-20);
        }];
        
        // 绑定手机(文字)
        [_bindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bindIcon.mas_top);
            make.left.equalTo(self.bindIcon.mas_right);
            make.bottom.equalTo(self.bindIcon.mas_bottom);
            make.right.equalTo(self.bindView.mas_right).offset(-LJKAuthorIcon2CellLeft);
        }];
    }
    return self;
}


- (void)setupNavButtons {
    CGFloat x = 0;
    CGFloat y = 0;
    NSInteger count = 4;
    CGFloat buttonWidth = SCREEN_WIDTH / count;
    CGFloat buttonHeight = LJKHomeHeader_CenterNav_Height;
    NSArray *imageArray = @[@"myFavourite", @"myVoucher", @"myFavourite", @"myVoucher"];
    NSArray *titleArray = @[@"收藏", @"订单", @"优惠", @"积分"];
    
    // FIXME:(已解决) 按钮点击无反应
    // 父视图(容器)size 设置与buttons 不符， 实际点击时超出了父视图范围，无法触发响应链条
    for (NSUInteger index = 0; index < count; index++) {
        LJKHomeHeaderNavButton *button = [LJKHomeHeaderNavButton buttonWithImageName:imageArray[index]
                                                                               title:titleArray[index]
                                                                              target:self
                                                                              action:@selector(navButtonDidClick:)];
        
        x = buttonWidth * index;
        button.frame = CGRectMake(x, y, buttonWidth, buttonHeight);
        button.tag = index + 10;
        [self.navButtons addSubview:button];
    }
    
}

#pragma mark - 传入模型
- (void)setAuthorDetail:(LJKAuthorDetail *)authorDetail {
    _authorDetail = authorDetail;
    
    self.myInfoNameLabel.text     = authorDetail.name;
    self.myInfoIcon.image         = [[UIImage imageNamed:authorDetail.photo160] imageByRoundCornerRadius:233];
    self.myInfoFollowedLabel.text = [NSString stringWithFormat:@"%@关注", authorDetail.nfollow];
    self.myInfoFansLabel.text     = [NSString stringWithFormat:@"%@粉丝", authorDetail.nfollowed];
    self.myInfoSignLabel.text     = [NSString stringWithFormat:@"加入时间:%@", authorDetail.create_time];
    
}

#pragma mark - 点击事件
- (void)navButtonDidClick:(LJKHomeHeaderNavButton *)navButton {

    !self.clickBlock ? : self.clickBlock(navButton.tag);
}

- (void)myInfoViewDidClick:(id)sender {

    !self.clickBlock ? : self.clickBlock(headerDidClickedActionInfoView);
}

- (void)bindViewDidClick:(id)sender {

    !self.clickBlock ? : self.clickBlock(headerDidClickedActionBindMobile);
}



@end
