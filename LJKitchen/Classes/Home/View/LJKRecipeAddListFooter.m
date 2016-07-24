//
//  LJKRecipeAddListFooter.m
//  LJKitchen
//
//  Created by  a on 16/7/10.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  Done

#import "LJKRecipeAddListFooter.h"

#import <Masonry.h>

@interface LJKRecipeAddListFooter ()
/** Footer - 加入菜单 */
@property (nonatomic, strong) UIButton *addListButton;
/** Footer - 推广(容器) */
@property (nonatomic, strong) UIView *spreadView;
/** Footer - 加入菜单 */
@property (nonatomic, strong) UILabel *spreadIcon;
/** Footer - 加入菜单 */
@property (nonatomic, strong) UILabel *spreadDesc;
@end

@implementation LJKRecipeAddListFooter

#pragma mark - 懒加载
- (UIButton *)addListButton {
    if (!_addListButton) {
        _addListButton = [UIButton buttonWithBackgroundColor:Color_ThemeColor
                                                       title:@"加入菜单"
                                                    fontSize:17
                                                  titleColor:Color_TintWhite
                                                      target:self
                                                      action:@selector(addListButtonDidClicked)
                                               clipsToBounds:YES];
    }
    return _addListButton;
}

- (UIView *)spreadView {
    if (!_spreadView) {
        _spreadView = [[UIView alloc] init];
        _spreadView.backgroundColor = Color_BackGround;
        UITapGestureRecognizer *tapSpread = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(spreadViewDidClicked)];
        [_spreadView addGestureRecognizer:tapSpread];
    }
    return _spreadView;
}

- (UILabel *)spreadIcon {
    if (!_spreadIcon) {
        _spreadIcon = [UILabel labelWithTextColor:Color_TintWhite
                                  backgroundColor:[UIColor orangeColor]
                                         fontSize:12
                                            lines:1
                                    textAlignment:NSTextAlignmentCenter];
        _spreadIcon.text = @"推广";
    }
    return _spreadIcon;
}

- (UILabel *)spreadDesc {
    if (!_spreadDesc) {
        _spreadDesc = [UILabel labelWithTextColor:Color_TintBlack
                                  backgroundColor:Color_Clear
                                         fontSize:15
                                            lines:0
                                    textAlignment:NSTextAlignmentLeft];
        _spreadDesc.text = @"717年度大促，300元红包人人有，口碑爆款全包邮！戳此领红包 >>>";
    }
    return _spreadDesc;
}

#pragma mark - 构造方法
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = Color_TintWhite;
        
        [self.contentView addSubview:self.addListButton];
        [self.contentView addSubview:self.spreadView];
        [self.spreadView addSubview:self.spreadIcon];
        [self.spreadView addSubview:self.spreadDesc];
        
        [_addListButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(self.contentView.mas_top).offset(15);
            make.size.mas_equalTo(CGSizeMake(100, 30));
        }];
        
        [_spreadView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.addListButton.mas_bottom).offset(15);
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 80));
        }];
        
        [_spreadIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.spreadView.mas_top).offset(LJKAuthorIcon2CellTop);
            make.left.equalTo(self.spreadView.mas_left).offset(LJKAuthorIcon2CellLeft);
            make.size.mas_equalTo(CGSizeMake(50, 22)); // 跟独家图标一样大……
        }];
        
        [_spreadDesc mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.spreadIcon.mas_right).offset(LJKAuthorIcon2CellLeft);
            make.right.equalTo(self.contentView.mas_right).offset(-LJKAuthorIcon2CellLeft);
            make.top.equalTo(self.spreadIcon.mas_top);
        }];
    }
    return self;
}

#pragma mark - 点击事件
- (void)addListButtonDidClicked {
    !self.footerActionBlock ? : self.footerActionBlock();
}

- (void)spreadViewDidClicked {
    !self.footerSpreadBlock ? : self.footerSpreadBlock();
}

@end
