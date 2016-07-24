//
//  LJKMarketViewController.m
//  LJKitchen
//
//  Created by  a on 16/6/8.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  Done 

#import "LJKMarketViewController.h"
#import "LJKMallSortViewController.h"       // 详细分类
#import "LJKShoppingSortViewController.h"   // 购物车
#import "LJKGoodsViewController.h"          // 商品

#import "LJKMarketViewHeader.h"             // 市集(定位)
#import "LJKMarketCategoryCell.h"           // 市集分类
#import "LJKMarketSpreadCell.h"             // 推广
#import "LJKMarketShopRecommendCell.h"      // 好店推荐
#import "LJKMarketHotThemeCell.h"           // 热门主题
#import "LJKMarketNewArrivalCell.h"         // 最新上架商品

#import "LJKAuthorDetail.h"
#import "LJKMyInfo.h"

#import "LJKSearchBar.h"

@interface LJKMarketViewController ()
/** 用户信息详情 */
@property (nonatomic, strong) LJKAuthorDetail *authorDetail;
@end

@implementation LJKMarketViewController

static NSString * const categoryCellIdentifier      = @"categoryCell";      // 分类
static NSString * const spreadCellIdentifier        = @"spreadCell";        // 推广
static NSString * const shopRecommendCellIdentifier = @"shopRecomendCell";  // 好店推荐
static NSString * const hotThemeCellIdentifier      = @"hotThemeCell";      // 热门主题
static NSString * const newArrivalCellIdentifier    = @"newArrivalCell";    // 最新上架(商品)

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBasicInfo];
    [self setupNavigationBar];
    [self setupTableViewHeader];
    [self setupTableview];
}

- (void)setupBasicInfo {
    self.authorDetail = [LJKMyInfo  info];
}

- (void)setupNavigationBar {
    
    LJKSearchBar *searchBar = [LJKSearchBar searchBarWithPlaceholder:@"搜索食材、工具"];
    self.navigationItem.titleView = searchBar;
    //    WeakSelf;
    searchBar.searchBarShouldBeginEditingBlock = ^{
        //        XCFSearchViewController *searchCon = [[XCFSearchViewController alloc] initWithStyle:UITableViewStyleGrouped];
        //        [weakSelf.navigationController pushViewController:searchCon animated:YES];
    };
    
    self.navigationItem.leftBarButtonItem =
    [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"leftPageButtonBackgroundNormal"]
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(mallSort)]; // 市集分类
    
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"shoppingCart"]
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(shoppingCart)];
}

- (void)setupTableViewHeader {
    LJKMarketViewHeader *header = [[LJKMarketViewHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    header.authorDetail = self.authorDetail;
    WeakSelf;
    header.changeLocationBlock = ^(){
        [UILabel showMessage:@"切换定位城市" atNavController:weakSelf.navigationController];
    };
    
    self.tableView.tableHeaderView = header;
}

- (void)setupTableview {
    
    self.tableView.bounces = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 市集分类
    [self.tableView registerClass:[LJKMarketCategoryCell class]
           forCellReuseIdentifier:categoryCellIdentifier];
    // 推广
    [self.tableView registerClass:[LJKMarketSpreadCell class]
           forCellReuseIdentifier:spreadCellIdentifier];
    // 好店推荐
    [self.tableView registerClass:[LJKMarketShopRecommendCell class]
           forCellReuseIdentifier:shopRecommendCellIdentifier];
    // 热门主题
    [self.tableView registerClass:[LJKMarketHotThemeCell class]
           forCellReuseIdentifier:hotThemeCellIdentifier];
    // 最新上架
    [self.tableView registerClass:[LJKMarketNewArrivalCell class]
           forCellReuseIdentifier:newArrivalCellIdentifier];
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WeakSelf;
    
    if (indexPath.section == 0) {
        LJKMarketCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:categoryCellIdentifier];
        // 导航按钮 点击回调
        cell.clickBlock = ^(NSInteger marketNavButtonAction) {
            switch (marketNavButtonAction) {
                case marketNavButtonActionCure:
                    [UILabel showMessage:@"点击了烘焙" atNavController:weakSelf.navigationController];
                    NSLog(@"——烘焙———");
                    break;
                case marketNavButtonActionFresh:
                    [UILabel showMessage:@"点击了果蔬生鲜" atNavController:weakSelf.navigationController];
                    NSLog(@"———果蔬生鲜———");
                    break;
                case marketNavButtonActionTableware:
                    [UILabel showMessage:@"点击了器具" atNavController:weakSelf.navigationController];
                    NSLog(@"———器具———");
                    break;
                case marketNavButtonActionPromotionCenter:
                    [UILabel showMessage:@"点击了领券中心" atNavController:weakSelf.navigationController];
                    NSLog(@"———领券中心———");
                    break;
                case marketNavButtonActionFastFood:
                    [UILabel showMessage:@"点击了方便食品" atNavController:weakSelf.navigationController];
                    NSLog(@"———方便食品———");
                    break;
                case marketNavButtonActionIportedFood:
                    [UILabel showMessage:@"点击了进口食品—" atNavController:weakSelf.navigationController];
                    NSLog(@"——进口食品————");
                    break;
                case marketNavButtonActionCondiment:
                    [UILabel showMessage:@"点击了调味品" atNavController:weakSelf.navigationController];
                    NSLog(@"———调味品———");
                    break;
                case marketNavButtonActionAllCategories:
                    [UILabel showMessage:@"点击了全部分类" atNavController:weakSelf.navigationController];
                    NSLog(@"————全部分类——");
                    break;
            }
        };
        return cell;
    } else if (indexPath.section == 1) {
        LJKMarketSpreadCell *cell = [tableView dequeueReusableCellWithIdentifier:spreadCellIdentifier];
        
        return cell;
    } else if (indexPath.section == 2) {
        LJKMarketShopRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:shopRecommendCellIdentifier];

        // 推荐店铺点击回调
        cell.clickedBlock = ^(NSUInteger itemLocation) {
            switch (itemLocation) {
                case shopItemLocationLeft:
                    [UILabel showMessage:@"推荐店铺-左" atNavController:weakSelf.navigationController];
                    break;
                case shopItemLocationMiddle:
                    [UILabel showMessage:@"推荐店铺-中" atNavController:weakSelf.navigationController];
                    break;
                case shopItemLocationRight:
                    [UILabel showMessage:@"推荐店铺-右" atNavController:weakSelf.navigationController];
                    break;
            }
        };
        return cell;
    } else if (indexPath.section == 3) {
        LJKMarketHotThemeCell *cell = [tableView dequeueReusableCellWithIdentifier:hotThemeCellIdentifier];
        
        // collectionViewCell 点击回调
        cell.collectionViewCellClickedBlock = ^(NSInteger index) {
            switch (index) {
                case 0: {
                    [UILabel showMessage:@"爱尝鲜"
                         atNavController:weakSelf.navigationController];
                    break;
                }
                case 1: {
                    [UILabel showMessage:@"你有新的优惠"
                         atNavController:weakSelf.navigationController];
                    break;
                }
                case 2: {
                    [UILabel showMessage:@"山姆夏日尊享"
                         atNavController:weakSelf.navigationController];
                    break;
                }
                case 3: {
                    [UILabel showMessage:@"爱试用"
                         atNavController:weakSelf.navigationController];
                    break;
                }
                case 4: {
                    [UILabel showMessage:@"京东优选馆"
                         atNavController:weakSelf.navigationController];
                    break;
                }
                case 5:{
                    [UILabel showMessage:@"市集上新"
                         atNavController:weakSelf.navigationController];
                    break;
                }
            }
        };
        return cell;
    } else if (indexPath.section == 4) {
        
        // FIXME : (未解决)手势冲突
        // 突然觉得在cell里嵌套collectionView 很蠢…… 手势冲突
        LJKMarketNewArrivalCell *cell = [tableView dequeueReusableCellWithIdentifier:newArrivalCellIdentifier];
        
        cell.collectionViewCellClickedBlock = ^(NSInteger index) {
            [weakSelf.navigationController pushViewController:[[LJKGoodsViewController alloc] init]
                                                     animated:YES];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [UILabel showMessage:@"跳转至对应商品" atNavController:weakSelf.navigationController];
            });
        };
        return cell;
    }
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 180;
    } else if (indexPath.section == 1) {
        return SCREEN_WIDTH  * 0.6;
    } else if (indexPath.section == 2) {
        // sum = item高度 + 标题高度 + 间距
        CGFloat sumH = ((SCREEN_WIDTH - 4 * 20) / 3) + 60 + 30 + 10;
        return sumH;
    } else if (indexPath.section == 3) {
        CGFloat sumH = ((SCREEN_WIDTH - 4 * 20) / 3) + 30 + 10;
        return sumH;
    } else if (indexPath.section == 4) {
        return 1500;
    }
    return 0;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        [self pushWebViewWithUrl:LJKRequestKitchenSpread];
    }
}

#pragma mark - barButton 点击事件
// 市集分类
- (void)mallSort {
    LJKMallSortViewController *mallSort = [[LJKMallSortViewController alloc] init];
    [self.navigationController pushViewController:mallSort animated:YES];
}

// 购物车
- (void)shoppingCart {
    LJKShoppingSortViewController *cart = [[LJKShoppingSortViewController alloc] init];
    [self.navigationController pushViewController:cart animated:YES];
}



@end
