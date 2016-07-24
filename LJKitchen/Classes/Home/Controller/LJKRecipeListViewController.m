//
//  LJKRecipeListViewController.m
//  LJKitchen
//
//  Created by  a on 16/7/5.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  Done

#import "LJKRecipeListViewController.h"
#import "LJKRecipeViewController.h"     // 菜谱详情

#import "LJKRecipeListHeader.h"         // 菜单头视图
#import "LJKRecipeCell.h"               // 菜单cell

#import "LJKRecipeList.h"
#import "LJKRecipe.h"

#import "LJKNetworkTool.h"
#import <MJRefresh.h>
#import <MJExtension.h>

@interface LJKRecipeListViewController ()
@property (nonatomic, strong) LJKRecipeList *recipeList;
@property (nonatomic, strong) LJKRecipeListHeader *header;
@end

@implementation LJKRecipeListViewController

static NSString *const recipeListCellIdentifier = @"recipeListCell";

#pragma mark - 页面构成
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
    [self setupTableView];
    [self setupRefresh];
    [self loadNewData];
}

- (void)setupNavigationBar {
    self.title = @"菜单";
}

- (void)setupTableView {
    self.tableView.backgroundColor = Color_BackGround;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[LJKRecipeCell class]
           forCellReuseIdentifier:recipeListCellIdentifier];
}

- (void)setupRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self
                                                                refreshingAction:@selector(loadNewData)];
}

#pragma mark - 数据处理
- (void)loadNewData {
    [LJKNetworkTool afnGet:LJKRequestKitchenRecipeList
                    params:nil
                   success:^(id json) {
                       self.recipeList = [LJKRecipeList mj_objectWithKeyValues:json[@"content"]];
                       [self.tableView reloadData];
                       
                       self.header = [[LJKRecipeListHeader alloc] init];
                       self.header.recipeList = self.recipeList;
                       self.header.frame  = CGRectMake(0, 0, SCREEN_WIDTH, self.recipeList.headerheight);
                       
                       WeakSelf;
                       weakSelf.header.recipeHeaderActionBlock = ^(recipeHeaderAction action) {
                           switch (action) {
                               case RecipeHeaderActionAuthorName: {
                                   [UILabel showMessage:@"跳转至菜谱创简者介绍" atNavController:weakSelf.navigationController];
                                   break;
                               }
                               case RecipeHeaderActionCollected: {
                                   [UILabel showMessage:@"加入收藏 or 取消收藏" atNavController:weakSelf.navigationController];
                                   break;
                               }
                           }
                       };
                       self.tableView.tableHeaderView = self.header;

                       [self.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
                        NSLog(@"加载失败，原因:%@", error);
                        [self.tableView.mj_header endRefreshing];
    }];
}

#pragma mark - TableView 数据源 & 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.recipeList.sample_recipes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LJKRecipeCell *cell = [tableView dequeueReusableCellWithIdentifier:recipeListCellIdentifier];
    LJKRecipe *recipe = self.recipeList.sample_recipes[indexPath.row];
    cell.recipe = recipe;
    
    WeakSelf;
    cell.authorIconClickedBlock  = ^{
        [UILabel showMessage:@"跳转至菜谱作者" atNavController:weakSelf.navigationController];
        [weakSelf pushWebViewWithUrl:LJKRequestKitchenAuthorPage];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 320;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 模拟跳转对应ID菜谱
    // 将点击的对应的菜谱ID 发送给新的菜谱控制器
    [UILabel showMessage:@"跳转至对应菜谱"
         atNavController:self.navigationController];
    LJKRecipeViewController *recipeVc = [[LJKRecipeViewController alloc] init];
    recipeVc.recipeList.ID = self.recipeList.recipes[indexPath.row];
    [self.navigationController pushViewController:recipeVc animated:YES];
}


@end
