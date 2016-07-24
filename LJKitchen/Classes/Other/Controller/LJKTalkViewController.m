//
//  LJKTalkViewController.m
//  LJKitchen
//
//  Created by  a on 16/7/15.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKTalkViewController.h"
#import "LJKTopicComposeBar.h"

#import "LJKNetworkTool.h"

@interface LJKTalkViewController ()
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) LJKTopicComposeBar *composeBar;

@end

@implementation LJKTalkViewController

#pragma mark - 页面主体
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
    [self setupComposeBar];
}

- (void)setupNavigationBar {
    self.view.backgroundColor = Color_BackGround;
    self.title = @"联系卖家";
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reportIcon"]
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(backToMain)];
    self.navigationItem.rightBarButtonItem.tintColor = Color_ThemeColor;
}

- (void)setupComposeBar {
    WeakSelf;
    self.composeBar = [LJKTopicComposeBar addCompostBarWithEditingTextBlock:^(NSString *compose) {
        [UILabel showMessage:@"留言" atNavController:weakSelf.navigationController];
    }];
    [self.view addSubview:self.composeBar];
}

#pragma mark - 点击事件
- (void)backToMain {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
