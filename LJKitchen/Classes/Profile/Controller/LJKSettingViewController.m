//
//  LJKSettingViewController.m
//  LJKitchen
//
//  Created by  a on 16/6/8.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKSettingViewController.h"
#import "LJKNotificationViewController.h"
#import "LJKProfileEditViewController.h"

#import "LJKBasicCell.h"
#import "LJKSettingFooter.h"
#import "LJKSettingCell.h"

#import "LJKAuthorDetail.h"
#import "LJKMyInfo.h"

@interface LJKSettingViewController ()
/** 设置 - TitlesArryInDifferentSections */
@property (nonatomic, strong) NSMutableArray *title_section1;
@property (nonatomic, strong) NSMutableArray *title_section2;
@property (nonatomic, strong) NSMutableArray *title_section3;

/** 设置 - supply (版本号、退出) */
@property (nonatomic, strong) LJKSettingFooter *footer;
@property (nonatomic, strong) LJKAuthorDetail *authorDetail;
@end

@implementation LJKSettingViewController

static NSString *const settingCellIdentifier = @"settingCell";

#pragma mark - 懒加载
- (NSMutableArray *)title_section1 {
    if (!_title_section1) {
        _title_section1 = [NSMutableArray arrayWithObjects:@"账号管理",@"设置密码",@"收货地址",@"发现好友", nil];
    }
    return _title_section1;
}

- (NSMutableArray *)title_section2 {
    if (!_title_section2) {
        _title_section2 = [NSMutableArray arrayWithObjects:@"消息推送", nil];
    }
    return _title_section2;
}

- (NSMutableArray *)title_section3 {
    if (!_title_section3) {
        _title_section3 = [NSMutableArray arrayWithObjects:@"把下厨房告诉朋友",@"帮助下厨房评分",nil];
    }
    return _title_section3;
}

#pragma mark - 页面构成
- (void)viewDidLoad {
    [super viewDidLoad];
    self.authorDetail = [LJKMyInfo  info];
    [self setupNavigationBar];
    [self setupTableView];
}

- (void)setupNavigationBar {
    self.title = @"设置";
}

- (void)setupTableView {
    self.tableView.backgroundColor = Color_BackGround;
    self.tableView.bounces = NO;
    [self.tableView registerClass:[LJKSettingCell class]
           forCellReuseIdentifier:settingCellIdentifier];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) { 
        return 1;
    } else if (section == 1) {
        return self.title_section1.count;
    } else if (section == 2) {
        return self.title_section2.count;
    } else {
        return self.title_section3.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // FIXME: (未解决)BasicCell无法满足"个人信息"cell的需要
    LJKSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:settingCellIdentifier];
    if (indexPath.section == 0 ) {
        cell.authorDetail = self.authorDetail;
    } else if (indexPath.section == 1) {
        cell.textLabel.text = self.title_section1[indexPath.row];
    } else if (indexPath.section == 2) {
        cell.textLabel.text = self.title_section2[indexPath.row];
        cell.detailArrow.hidden = YES;
    } else {
        cell.textLabel.text = self.title_section3[indexPath.row];
        cell.detailArrow.hidden = YES;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 3) {
        return 120;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return TABLEVIEWCELL_NORMAL_HEIGHT + 20;
    }
    return TABLEVIEWCELL_NORMAL_HEIGHT;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 3) {
        self.footer = [LJKSettingFooter settingFooter];
        self.footer.version.text = @"版本号: 5.5";
        [self.footer.exit addTarget:self
                             action:@selector(exit)
                   forControlEvents:UIControlEventTouchUpInside];
        return self.footer;
    }
    return nil;
}

#pragma mark - cell & UI 事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) { // 个人信息编辑
         NSLog(@"即将跳转个人信息编辑界面——————");
        LJKProfileEditViewController *editVc = [[LJKProfileEditViewController alloc] init];
        [self.navigationController pushViewController:editVc animated:YES];
        
    } else if (indexPath.section == 1 && indexPath.row == 0) { // 账号管理
        
    } else if (indexPath.section == 1 && indexPath.row == 1) { // 设置密码
        
    } else if (indexPath.section == 1 && indexPath.row == 2) { // 管理收货地址
        
    } else if (indexPath.section == 1 && indexPath.row == 3) { // 发现好友
        
    } else if (indexPath.section == 2 ) {                      // 消息推送
        LJKNotificationViewController *notiVc = [[LJKNotificationViewController alloc] init];
        [self.navigationController pushViewController:notiVc animated:YES];
    } else if (indexPath.section == 3 && indexPath.row == 1) { // 为app评分
        [self commitScore];
    } else if (indexPath.section == 3 && indexPath.row == 0) { // 告诉朋友(分享)
        
    }
}


- (void)commitScore {

    UIAlertController *alertVC =
       [UIAlertController alertControllerWithTitle:@"即将跳转至AppStore为LJKitchen评分"
                                           message:@"但是并没有上架……"
                                    preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *appStore = [UIAlertAction actionWithTitle:@"前往AppStore"
                                                       style:UIAlertActionStyleDefault
                                                     handler:nil];
    
    UIAlertAction *cancel   = [UIAlertAction actionWithTitle:@"取消"
                                                     style:UIAlertActionStyleCancel
                                                     handler:nil];

    [alertVC addAction:appStore];
    [alertVC addAction:cancel];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)exit {
    UIAlertController *alertVC =
    [UIAlertController alertControllerWithTitle:@"确定要退出LJKitchen么？"
                                        message:nil
                                 preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *no = [UIAlertAction actionWithTitle:@"我只是手滑点错了……"
                                                style:UIAlertActionStyleDefault
                                               handler:nil];
    
    UIAlertAction *tureExit = [UIAlertAction actionWithTitle:@"退出"
                                                       style:UIAlertActionStyleDestructive
                                                     handler:^(UIAlertAction * _Nonnull action) {
        [SVProgressHUD showSuccessWithStatus:@"Bye~"];
        
    }];
    
    [alertVC addAction:no];
    [alertVC addAction:tureExit];
    [self presentViewController:alertVC animated:YES completion:nil];
}

@end
