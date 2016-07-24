//
//  LJKHomeViewController.m
//  LJKitchen
//
//  Created by  a on 16/6/8.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
// done

#import "LJKHomeViewController.h"
#import "LJKBasketController.h"         // Nav    - 菜篮子
#import "LJKCreatRecipeController.h"    // Nav    - 创建菜谱
#import "LJKBLSViewController.h"        // Header - 三餐(scrollView)
#import "LJKRedEnvelopeController.h"    // Header - 红包
#import "LJKFeedsViewController.h"      // Header - 关注动态
#import "LJKRecommendBuyController.h"   // Header - 推荐购买(买买买)
#import "LJKRecipeListViewController.h" // Cell   - 菜谱
#import "LJKDishViewController.h"       // Cell   - 作品(single)
#import "LJKRecipeViewController.h"     // Cell   - 菜谱


#import "LJKSearchBar.h"   // 搜索栏控件
#import "LJKHomeHeader.h"  // 首页的顶部视图（整体）
#import "LJKRecipeCell.h"  // 主体Cell

#import "LJKNavContent.h"
#import "LJKFeeds.h"
#import "LJKIssues.h"
#import "LJKItems.h"

#import "LJKNetworkTool.h" // 网络工具
#import <MJExtension.h>
#import <MJRefresh.h>

@interface LJKHomeViewController ()
@property (nonatomic, strong) UITableView *currentTableView;
/** 首页 - 顶部Header主体 */
@property (nonatomic, strong) LJKHomeHeader *homeHeader;
/** 首页 - 顶部Header - 本周热门、关注动态(数据) */
@property (nonatomic, strong) NSMutableArray *feedsArray;
/** 首页 - 菜谱数据 */
@property (nonatomic, strong) NSMutableArray *issuesArray;
@property (nonatomic, assign) NSInteger sectionCount;
@end

@implementation LJKHomeViewController

static NSString *const recipeCellIdentifier = @"RecipeCell";
static NSString *const recipeHeaderIdentifier = @"RecipeHeader";


#pragma mark - 懒加载
- (NSMutableArray *)feedsArray {
    if (!_feedsArray) {
        self.feedsArray = [NSMutableArray array];
    }
    return _feedsArray;
}

- (NSMutableArray *)issuesArray {
    if (!_issuesArray) {
        self.issuesArray = [NSMutableArray array];
    }
    return _issuesArray;
}


#pragma mark - 页面主体

- (void)viewDidLoad {
    
    [super viewDidLoad];

    [self setupNavigationBar];
    [self setupHomeHeader];
    [self setupTableView];
    [self setupRefresh];
    [self loadNewData];
}

- (void)setupNavigationBar {
    
    LJKSearchBar *searchBar = [LJKSearchBar searchBarWithPlaceholder:@"菜谱、食材"];
    self.navigationItem.titleView = searchBar;
    
    WeakSelf;
    searchBar.searchBarShouldBeginEditingBlock = ^{
        // TODO: 搜索界面未完成
        [UILabel showMessage:@"搜索界面未完成"
             atNavController:weakSelf.navigationController];
    };
    
    self.navigationItem.leftBarButtonItem =
    [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"homepageCreateRecipeButton"]
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(creatRecipe)];
    
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"buylistButtonImage"]
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(basket)];
}

- (void)setupRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self
                                                                refreshingAction:@selector(loadNewData)];
    // !!!: 上拉至底部时，加载旧数据(假数据，与首页数据相同)
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self
                                                                    refreshingAction:@selector(loadMoreData)];
    
}

- (void)setupTableView {
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = Color_Clear;
    self.view.backgroundColor = Color_BackGround;
    
    [self.tableView registerClass:[UITableViewHeaderFooterView class]
forHeaderFooterViewReuseIdentifier:recipeHeaderIdentifier];
    [self.tableView registerClass:[LJKRecipeCell class]
           forCellReuseIdentifier:recipeCellIdentifier];
}

- (void)setupHomeHeader {
    
    // 加载Header数据
    [self loadNavData];
    
    // 加载header界面
    // 顶部Header的总体高度 = 顶部关注栏 + 中部导航按钮 + 三餐scrollView + 新用户优惠() + 系统状态栏
    CGFloat homeHeaderSum = LJKHomeHeader_TopNav_Height + LJKHomeHeader_CenterNav_Height + LJKHomeHeader_CenterNav_Height + LJKHomeHeader_NewAuthor_Height;
    self.homeHeader = [[LJKHomeHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, homeHeaderSum)];
    self.homeHeader.backgroundColor = Color_BackGround;
    self.tableView.tableHeaderView = self.homeHeader;
    
    // header业务逻辑
    WeakSelf;
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    self.homeHeader.clickBlock = ^(NSInteger clickedAction) {
        // 本周流行菜谱
        if (clickedAction == viewDidClickedActionPopularImageView) {

            [weakSelf.navigationController pushViewController:[[LJKRecipeListViewController alloc] init]
                                                     animated:YES];
        }
        // 关注动态
        else if (clickedAction == viewDidClickedActionFeedsView) {
            [weakSelf.navigationController pushViewController:[[LJKFeedsViewController alloc] init]
                                                     animated:YES];
        }
        // 排行榜
        else if (clickedAction == viewDidClickedActionTopListButton) {
            [weakSelf pushWebViewWithUrl:LJKRequestKitchenRankingList];
        }
        // 看视频
        else if (clickedAction == viewDidClickedActionVideoButton) {
            [weakSelf.navigationController pushViewController:[[LJKRecommendBuyController alloc] init]
                                                     animated:YES];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [UILabel showMessage:@"7.15后下厨房更改导航图标图案，非bug"
                     atNavController:weakSelf.navigationController];
            });
        }
        // 买买买
        else if (clickedAction == viewDidClickedActionBuyButton) {
            
            [SVProgressHUD showSuccessWithStatus:@"视频界面未完成(加密)"];
        }
        // 菜谱分类
        else if (clickedAction == viewDidClickedActionRecipeCategoryButton) {
            [weakSelf pushWebViewWithUrl:LJKRequestKitchenRecipeCategory];
        }
        // 三餐
        else if (clickedAction == viewDidClickedActionBreakfast
                 || clickedAction == viewDidClickedActionLunch
                 || clickedAction == viewDidClickedActionSupper) {
            
            
            [weakSelf.navigationController pushViewController:[[LJKBLSViewController alloc] init]
                                                     animated:YES];
        }
        // 红包(新用户优惠)
        else if (clickedAction == viewDidClickedActionFristAuthor) {
            
            //            [SVProgressHUD showSuccessWithStatus:@"跳转至红包界面"];
            [weakSelf.navigationController pushViewController:[[LJKRedEnvelopeController alloc] init]
                                                     animated:YES];
        }
    };
}

#pragma mark - 数据处理 

/** 加载导航数据 */
- (void)loadNavData {
    // 首页Header数据
    // 使用的请求数据为前辈提供的 版本号为 5.1.1的App内抓包获得。
//    NSString *headerUrl = @"http://api.xiachufang.com/v2/init_page_v5.json?version=5.1.1&timezone=Asia%2FShanghai&api_sign=8436824b4ec402b228bf20028d49c9b5&api_key=0f9f79be1dac5f003e7de6f876b17c00&origin=iphone&sk=7UnwJ-JkQ36hbfrMRoL0fA";
    
    [LJKNetworkTool afnGet:LJKRequestKitchenNav
                    params:nil
                   success:^(id json) {
        
        self.homeHeader.navContent = [LJKNavContent mj_objectWithKeyValues:json[@"content"]];
    } failure:^(NSError *error) {
        NSLog(@"加载header失败 原因:%@", error);
    }];
    
    
    [LJKNetworkTool afnGet:LJKRequestKitchenFeeds
                    params:nil
                   success:^(id json) {
        
        self.feedsArray = [LJKFeeds mj_objectArrayWithKeyValuesArray:json[@"content"][@"feeds"]];
        self.homeHeader.dish = [self.feedsArray[0] dish];
    } failure:^(NSError *error) {
        NSLog(@"加载header失败 原因:%@", error);
    }];

}



- (void)loadNewData {
    [self.tableView.mj_footer endRefreshing];
    
    [LJKNetworkTool afnGet:LJKRequestKitchenCell
                    params:nil
                   success:^(id json) {

                        self.issuesArray = [LJKIssues mj_objectArrayWithKeyValuesArray:json[@"content"][@"issues"]];
                        [self.tableView reloadData];
                        [self.tableView.mj_header endRefreshing];
                    } failure:^(NSError *error) {
                        NSLog(@"加载TableView失败 原因:%@", error);
                        [self.tableView.mj_header endRefreshing];
                    }];
    
}

- (void)loadMoreData {
    [self.tableView.mj_header endRefreshing];
    
    [LJKNetworkTool afnGet:LJKRequestKitchenCellMore
                    params:nil
                   success:^(id json) {
                       NSArray *newData = [LJKIssues mj_objectArrayWithKeyValuesArray:json[@"content"][@"issues"]];
                       [self.issuesArray addObjectsFromArray:newData];
                       [self.tableView reloadData];
                       [self.tableView.mj_footer endRefreshing];
                   } failure:^(NSError *error) {
                       NSLog(@"加载更多Cell失败 原因:%@", error);
                       [self.tableView.mj_footer endRefreshing];
                   }];
}

#pragma mark - 导航按钮点击方法
/** 跳转至创建菜谱界面 */
- (void)creatRecipe {
    LJKCreatRecipeController *recipe = [[LJKCreatRecipeController alloc] init];
    [self.navigationController pushViewController:recipe animated:YES];
    
}

/** 跳转至菜篮子界面 */
- (void)basket {
    LJKBasketController *basket = [[LJKBasketController alloc] init];
    [self.navigationController pushViewController:basket animated:YES];
}

#pragma mark - TableView 数据源及代理方法
// 组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.issuesArray.count;
}

// 每组cell数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.issuesArray[section] items_count];
}

// Cell 高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    LJKIssues *issues = self.issuesArray[indexPath.section];
    LJKItems *item = issues.items[indexPath.row];
    // 5 == 调整姓名栏后临时padding
    return item.cellHeight;
}

// section 标题高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

// 预设高度
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 280;
}

// 主体cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LJKRecipeCell *cell = [tableView dequeueReusableCellWithIdentifier:recipeCellIdentifier
                                                          forIndexPath:indexPath];
    LJKIssues *issues = self.issuesArray[indexPath.section];
    LJKItems *item = issues.items[indexPath.row];
    cell.item = item;
    
    WeakSelf;
    cell.authorIconClickedBlock = ^{ // 头像点击回调
         NSLog(@"即将进入作者个人主页——————");
        [weakSelf pushWebViewWithUrl:LJKRequestKitchenAuthorPage];
    };
    return cell;
}

/** section 标题Label */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:recipeHeaderIdentifier];
    headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
    UILabel *label = [UILabel labelWithTextColor:[UIColor blackColor]
                                 backgroundColor:Color_BackGround
                                        fontSize:17
                                           lines:0
                                   textAlignment:NSTextAlignmentCenter];
    [headerView.contentView addSubview:label];
    label.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
    LJKIssues *issues = self.issuesArray[section];
    label.text = issues.title;
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LJKIssues *issues = self.issuesArray[indexPath.section];
    LJKItems *item = issues.items[indexPath.row];
    
    // 根据模板不同跳转对应界面
    switch (item.template) {
        case LJKCellTemplateTopic:
        case LJKCellTemplateWeeklyMagazine: { // 模板1 6 (帖子/杂志)
            NSLog(@"即将跳转对应webView——————");
            [self pushWebViewWithUrl:item.url];
            break;
        }
        case LJKCellTemplateRecipeList: { // 模板2 (菜单)
             NSLog(@"即将跳转菜单——————");
            [self.navigationController pushViewController:[[LJKRecipeListViewController alloc] init]
                                                 animated:YES];
            break;
        }
        case LJKCellTemplateDish: { // 模板4 (作品)
            NSLog(@"即将跳转作品详情——————");
            [self.navigationController pushViewController:[[LJKDishViewController alloc] init]
                                                 animated:YES];
            break;
        }
        case LJKCellTemplateRecipe: { // 模板5 (菜谱)
            NSLog(@"即将跳转菜谱——————");
            [self.navigationController pushViewController:[[LJKRecipeViewController alloc] init]
                                                 animated:YES];
            break;
        }
    }
}


#pragma mark - useless 
// string 4 sectionHeader (不适用)
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    LJKIssues *issues = self.issuesArray[section];
//    return issues.title;
//}

@end

