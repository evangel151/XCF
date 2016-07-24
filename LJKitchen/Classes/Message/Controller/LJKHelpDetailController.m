//
//  LJKHelpDetailController.m
//  LJKitchen
//
//  Created by  a on 16/6/10.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKHelpDetailController.h"
#import <Masonry.h>
@interface LJKHelpDetailController ()

@property (nonatomic, strong) UILabel *detailTitleLabel;
@property (nonatomic, strong) UILabel *detailDesLabel;
@property (nonatomic, strong) UIView *containView;
@end

@implementation LJKHelpDetailController
#pragma mark - 懒加载
- (UIView *)containView {
    if (!_containView) {
        _containView = [[UIView alloc] init];
        _containView.backgroundColor = [UIColor whiteColor];
    }
    return _containView;
}


- (UILabel *)detailTitleLabel {
    if (!_detailDesLabel) {
        _detailTitleLabel = [UILabel labelWithTextColor:Color_DarkGray
                                        backgroundColor:[UIColor clearColor]
                                               fontSize:21
                                                  lines:0
                                          textAlignment:NSTextAlignmentLeft];
        // 模拟缩进……懒的改了
        _detailTitleLabel.text = @"    如何在LJKitchen注册？";
    }
    return _detailTitleLabel;
}

- (UILabel *)detailDesLabel {
    if (!_detailDesLabel) {
        _detailDesLabel = [UILabel labelWithTextColor:[UIColor blackColor]
                                      backgroundColor:[UIColor clearColor]
                                             fontSize:21
                                                lines:0
                                        textAlignment:NSTextAlignmentNatural];
        _detailDesLabel.text = @"打开LJKitchen App,点击首页“开始”，使用第三方账号登录即能完成注册。（LJKitchen目前只支持第三方账号登录注册，不支持邮箱注册，建议您再使用第三方账号登录之后，在网页版账号设置里绑定邮箱，之后也可以用所绑定的邮箱进行登录。）";
    }
    return _detailDesLabel;
}


#pragma mark - 页面主体
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBasic];
    [self setupNavigationBar];
}

- (void)setupNavigationBar {
    self.title = @"帮助中心";
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reportIcon"]
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(popToRoot)];
    self.navigationItem.rightBarButtonItem.tintColor = Color_ThemeColor;
}

- (void)setupBasic {
    self.view.backgroundColor = Color_BackGround;
    
    [self.view addSubview:self.containView];
    [self.view addSubview:self.detailTitleLabel];
    [self.containView addSubview:self.detailDesLabel];
    
    [self.detailTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 50));
        make.left.equalTo(self.view.mas_left);
        make.top.equalTo(self.view.mas_top).offset(64);
    }];
    
    [self.containView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 200));
        make.top.equalTo(self.detailTitleLabel.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
    }];
    
    [self.detailDesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 40, 200));
        make.top.equalTo(self.containView.mas_top);
        make.left.equalTo(self.containView.mas_left).offset(20);
        make.right.equalTo(self.containView.mas_right).offset(-20);
    }];
}

#pragma mark - 点击事件
- (void)popToRoot {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
