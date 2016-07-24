//
//  LJKHelpCenterViewController.m
//  LJKitchen
//
//  Created by  a on 16/6/10.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKHelpCenterViewController.h"
#import "LJKHelpDetailController.h"
#import "LJKBasicCell.h"

@interface LJKHelpCenterViewController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *helpView;
@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, strong) NSMutableArray *headerStrings;
@end

@implementation LJKHelpCenterViewController

static NSString *const sectionTitle = @"常见问题";
#pragma mark - 懒加载
- (NSMutableArray *)headerStrings {
    if (!_headerStrings) {
        _headerStrings = [NSMutableArray arrayWithObjects:@"LJKitchen常见问题",nil];
    }
    return _headerStrings;
}

- (NSMutableArray *)titleArray {
    if (!_titleArray) {
        self.titleArray = [NSMutableArray arrayWithObjects:@"账号相关",@"菜谱相关",@"作品相关",@"菜单相关",@"登录相关",@"其他", nil];
    }
    return _titleArray;
}


- (UITableView *)helpView {
    if (!_helpView) {
        _helpView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
                                                 style:UITableViewStyleGrouped];
        _helpView.dataSource = self;
        _helpView.delegate   = self;
    }
    return _helpView;
}

#pragma mark - 页面主体 
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"帮助中心";
    self.view.backgroundColor = Color_BackGround;
    [self.view addSubview:self.helpView];
}

#pragma mark TableView 数据源 & 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LJKBasicCell *cell = [LJKBasicCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLabelView.text = [NSString stringWithFormat:@"%@", self.titleArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LJKHelpDetailController *detail = [[LJKHelpDetailController alloc] init];
    [self.navigationController pushViewController:detail animated:YES];
    NSLog(@"跳转至帮助页面——————");
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.headerStrings[section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return TABLEVIEW_TITLE_HEIGHT;
}

@end
