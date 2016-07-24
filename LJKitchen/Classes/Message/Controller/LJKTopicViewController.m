//
//  LJKTopicViewController.m
//  LJKitchen
//
//  Created by  a on 16/6/23.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  Done

#import "LJKTopicViewController.h"
#import "LJKTopicDetailController.h"
#import "LJKTopicViewCell.h"

#import "LJKTopic.h"

#import "LJKNetworkTool.h"
#import <MJRefresh.h>
#import <MJExtension.h>

@interface LJKTopicViewController ()
/** 帖子数组 */
@property (nonatomic, strong) NSMutableArray *topicArray;
@end

@implementation LJKTopicViewController

static NSString *const topicCellIdentifier = @"topicCell";

#pragma mark - 懒加载
- (NSMutableArray *)topicArray {
    if (!_topicArray) {
        _topicArray = [NSMutableArray array];
    }
    return _topicArray;
}


#pragma mark - 页面主体
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
    [self setupRefresh];
    [self setupTableView];
    [self loadNewData];
}

- (void)setupNavigationBar {
    self.title = @"讨论区";
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@"发主题"
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(postTopic)];
    self.navigationItem.rightBarButtonItem.tintColor = Color_ThemeColor;
}

- (void)setupRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self
                                                                refreshingAction:@selector(loadNewData)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self
                                                                    refreshingAction:@selector(loadMoreData)];
}

- (void)setupTableView {
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[LJKTopicViewCell class] forCellReuseIdentifier:topicCellIdentifier];
}

#pragma mark - 网络请求
- (void)loadNewData {
    [LJKNetworkTool afnGet:LJKRequestTopic
                    params:nil
                   success:^(id json) {
                       self.topicArray = [LJKTopic mj_objectArrayWithKeyValuesArray:json[@"content"][@"topics"]];
                       [self.tableView reloadData];
                       [self.tableView.mj_header endRefreshing];
                   } failure:^(NSError *error) {
                       [self.tableView.mj_header endRefreshing];
                   }];
}

- (void)loadMoreData {
    [LJKNetworkTool afnGet:LJKRequestTopic
                    params:nil
                   success:^(id json) {
                       NSArray *newData = [LJKTopic mj_objectArrayWithKeyValuesArray:json[@"content"][@"topics"]];
                       [self.topicArray addObjectsFromArray:newData];
                       [self.tableView reloadData];
                       [self.tableView.mj_footer endRefreshing];
                   } failure:^(NSError *error) {
                       [self.tableView.mj_footer endRefreshing];
                   }];

}

#pragma mark - TableView 数据源 & 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topicArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // !!!:(错误写法) 以indexPath来唯一确定cell
    // 的确可以解决cell重用时子控件位置错误的bug 但是CellIdentifier也相当于完全失去作用，不要使用
    // NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%zd%zd",indexPath.section, indexPath.row];
    LJKTopicViewCell *cell = [tableView dequeueReusableCellWithIdentifier:topicCellIdentifier];
    if (!cell) {
        cell = [[LJKTopicViewCell alloc] init];
    }
    cell.topic = self.topicArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.topicArray[indexPath.row] cellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
     NSLog(@"即将跳转对应的帖子——————");
    LJKTopicDetailController *detailViewC = [[LJKTopicDetailController alloc] init];
    // 将对应cell的topic模型直接传递给主题详情控制器
    detailViewC.topic = self.topicArray[indexPath.row];
    [self.navigationController pushViewController:detailViewC animated:YES];
}

#pragma mark - 点击事件
- (void)postTopic {
     NSLog(@"即将跳转发帖界面——————");
    [UILabel showMessage:@"该功能暂未完成" atNavController:self.navigationController];
}
@end
