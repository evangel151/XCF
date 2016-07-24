//
//  LJKCommunityViewController.m
//  LJKitchen
//
//  Created by  a on 16/6/8.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKCommunityViewController.h"
#import "LJKTopicViewController.h"     // 社区-主题
#import "LJKCommunityForumCell.h"      // 论坛
//#import "LJKCookerClubViewController.h"// 社区-厨友社

#import "LJKForum.h"

#import "LJKNetworkTool.h"
#import <Masonry.h>
#import <MJExtension.h>
#import <MJRefresh.h>

@interface LJKCommunityViewController ()
/** 社区-讨论区 */
@property (nonatomic, strong) LJKForum *forumDiscuss;
/** 社区-周边 */
@property (nonatomic, strong) LJKForum *forumAmbitus;

@end

@implementation LJKCommunityViewController

static NSString *const communityFooterIdentifier = @"communityFooter"; // 厨友社
static NSString *const communityCellIdentifier   = @"communityCell";   // 社区cell
static CGFloat  cellHeight = 80;

#pragma mark - 页面主体
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"社区";
    
    [self setupTableView];
    [self setupRefresh];
    [self loadNewData];
    
}

- (void)setupTableView {
    
//    self.view.backgroundColor = Color_BackGround;
    self.tableView.backgroundColor = Color_BackGround;
    [self.tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:communityFooterIdentifier];
    [self.tableView registerClass:[LJKCommunityForumCell class] forCellReuseIdentifier:communityCellIdentifier];
}

- (void)setupRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
}

#pragma mark - 网络请求

- (void)loadNewData {
    
    // !!!: 安卓版与iOS版该界面有区别
    // 安卓的周边cell仍是组合头像 + 帖子内容  iOS的周边cell为静态单元格 
    [LJKNetworkTool afnGet:LJKRequestCommunity
                    params:nil
                   success:^(id json) {
                       self.forumDiscuss = [LJKForum mj_objectWithKeyValues:json[@"content"][@"forums"][0]];
                       self.forumAmbitus = [LJKForum mj_objectWithKeyValues:json[@"content"][@"shouts"]];
                       [self.tableView reloadData];
                       [self.tableView.mj_header endRefreshing];

    } failure:^(NSError *error) {
                        NSLog(@"加载社区失败,原因:%@", error);
                        [self.tableView.mj_header endRefreshing];
    }];
}

#pragma mark - TableView 数据源 & 代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 应该是两种不同的cell
    LJKCommunityForumCell *cell = [tableView dequeueReusableCellWithIdentifier:communityCellIdentifier];
    if (indexPath.row == 0) {
        cell.forum = self.forumDiscuss;
    } else if (indexPath.row == 1) {
        cell.forum = self.forumAmbitus;
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UITableViewHeaderFooterView *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:communityFooterIdentifier];
    footer.frame = CGRectMake(0, 0, SCREEN_WIDTH, 80);
    footer.contentView.backgroundColor = [UIColor whiteColor];
    UIImageView *imageV = [[UIImageView alloc] init];
    imageV.image = [UIImage imageNamed:@"cookerClub"];
    [footer addSubview:imageV];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(footer).insets(UIEdgeInsetsMake(5, 20, 5, 20));
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cookerClub)];
    [footer addGestureRecognizer:tap];
    
    return footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return cellHeight;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [UILabel showMessage:@"即将跳转至\"主题帖界面\"" atNavController:self.navigationController];
        [self.navigationController pushViewController:[[LJKTopicViewController alloc] init]
                                             animated:YES];
    } else if (indexPath.row == 1) {

        [UILabel showMessage:@"周边需要使用定位功能，暂未实现"
             atNavController:self.navigationController];
    }
}


#pragma mark - 点击事件
- (void) cookerClub {
    NSLog(@"即将跳转至\"厨友俱乐部\"——————");
    [self pushWebViewWithUrl:LJKRequestFooterCookerClub];
}

@end
