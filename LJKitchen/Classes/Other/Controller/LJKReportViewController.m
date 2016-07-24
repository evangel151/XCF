//
//  LJKReportViewController.m
//  LJKitchen
//
//  Created by  a on 16/7/11.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKReportViewController.h"

@interface LJKReportViewController ()
/** TextArray for cell  */
@property (nonatomic, strong) NSMutableArray *textArray;
@end

@implementation LJKReportViewController

#pragma mark - 懒加载

- (NSMutableArray *)textArray {
    if (!_textArray) {
        _textArray = [NSMutableArray arrayWithObjects:@"广告或垃圾信息",@"盗图或抄袭",@"其他",@"内容与主题无关", nil];
        
    }
    return _textArray;
}

#pragma mark - 页面构成
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
    [self setupTableView];
    
}

- (void)setupNavigationBar {
    self.title = @"举报作品";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(Done)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    self.navigationItem.rightBarButtonItem.tintColor = Color_ThemeColor;
}

- (void)setupTableView {
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = Color_BackGround;
}

#pragma mark - TableView 数据源 & 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"reportCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.textArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }
}

#pragma mark - 点击事件
// 模拟发送相关举报信息至服务器 & 发送成功后pop至原控制器 
- (void)Done {
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD showWithStatus:@"LJKitchen已经收到您的举报，我们会对作品信息进行核查，感谢您对LJKitchen一直以来的支持"];
    
    // 模拟网络延迟2秒 举报成功后 pop回原页面
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
        [self.navigationController popViewControllerAnimated:YES];
    });
}

@end
