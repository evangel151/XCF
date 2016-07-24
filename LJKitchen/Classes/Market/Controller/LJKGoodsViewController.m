//
//  LJKGoodsViewController.m
//  LJKitchen
//
//  Created by  a on 16/7/11.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  Done 

#import "LJKGoodsViewController.h"
#import "LJKShoppingSortViewController.h"   // 购物车
#import "LJKShopViewController.h"           // 店铺
#import "LJKOrderViewController.h"          // 订单
#import "LJKTalkViewController.h"           // 联系卖家

#import "LJKDishCell.h"                     // 评论Cell
#import "LJKGoodsBottomView.h"              // 底部工具条(购买/联系卖家/加入购物车/前往店铺)
#import "LJKGoodsHeaderView.h"              // Header (图片轮播器 + 商品详情)
#import "LJKGoodsFooterView.h"              // Footer (拖拽查看详情)
#import "LJKGoodsShopCell.h"                // 店铺简介
#import "LJKRecipeDishShowCell.h"           // 用户评价
#import "LJKRecommendBuyCell.h"             // 推荐购买
#import "LJKGoodsDetailView.h"              // 商品细节

#import "LJKNetworkTool.h"
#import "LJKGoods.h"
#import "LJKShop.h"

#import <MJExtension.h>

@interface LJKGoodsViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
/** 商品 - 导航按钮组 */
@property (nonatomic, strong) NSArray <UIBarButtonItem *>  *naviButtonsArray;
/** 商品 - header(整体) */
@property (nonatomic, strong) LJKGoodsHeaderView *headerView;

@property (nonatomic, strong) LJKGoods *goods;

@end

@implementation LJKGoodsViewController

static NSString * const shopCellIdentifier     = @"shopCell";       // 店铺介绍 cell
static NSString * const reviewCellIdentifier   = @"reviewCell";     // 商品评价 cell
static NSString * const recommendBuyIdentifier = @"recommendCell";  // 大家都在买 cell

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - LJKCartSettlementViewHeight)
                                                  style:UITableViewStyleGrouped];
//        _tableView.bounces = NO;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


#pragma mark - 页面主体
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    [self setupNavigationBar];
    [self setupTableview];
    [self setupTableViewFooter];
    [self setupBottomBar];
}

- (void)setupNavigationBar {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"shoppingCart"]
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(buyListButtonDidClicked)];
    
    self.naviButtonsArray = [UIBarButtonItem createShareButtonsWith:self target:self
                                                  firstButtonAction:@selector(backButtonDidClicked)
                                                 secondButtonAction:@selector(PYQButtonDidClicked)
                                                  thirdButtonAction:@selector(WeChatButtonDidClicked)
                                                 fourthButtonAction:@selector(OtherButtonDidClicked)];
    self.navigationItem.leftBarButtonItems = self.naviButtonsArray;
}

- (void)setupTableViewHeaderView {

    CGFloat headerHeight = self.goods.goodsDetailViewHeight + self.goods.shopPromotionViewHeight + 350;
    LJKGoodsHeaderView *headerView = [[LJKGoodsHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, headerHeight)];
    headerView.goods = self.goods;
    
    // TODO: 图片查看器未做
//    WeakSelf;
//    headerView.showImageBlock = ^(NSUInteger CGRect){
//        
//    };
    
    self.headerView = headerView;
    self.tableView.tableHeaderView = headerView;
}

- (void)setupTableview {
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 店铺简介
    [self.tableView registerClass:[LJKGoodsShopCell class] forCellReuseIdentifier:shopCellIdentifier];
    // 商品评价
    [self.tableView registerClass:[LJKRecipeDishShowCell class] forCellReuseIdentifier:reviewCellIdentifier];
    // 大家都在买
    [self.tableView registerClass:[LJKRecommendBuyCell class] forCellReuseIdentifier:recommendBuyIdentifier];
}

- (void)setupTableViewFooter {
    LJKGoodsFooterView *footerView = [[LJKGoodsFooterView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    self.tableView.tableFooterView = footerView;
}

- (void)setupBottomBar {
    LJKGoodsBottomView *bottomBar = [[LJKGoodsBottomView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 60, SCREEN_WIDTH, 60)];

    WeakSelf;
    bottomBar.clickBlock = ^(NSInteger action){
        switch (action) {
            case bottomViewActionGoToShop:    { // 前往店铺
                [UILabel showMessage:@"前往店铺" atNavController:weakSelf.navigationController];
                [weakSelf.navigationController pushViewController:[[LJKShopViewController alloc] init]
                                                         animated:YES];
                break;
            }
            case bottomViewActionContactShop: { // 联系卖家
                [UILabel showMessage:@"联系卖家" atNavController:weakSelf.navigationController];
                [weakSelf.navigationController pushViewController:[[LJKTalkViewController alloc] init]
                                                         animated:YES];
                break;
            }
            case bottomViewActionAddToCart:   { // 加入购物车
                // 向购物车发送通知 添加商品(默认1件)进入购物单
                [UILabel showMessage:@"加入购物车" atNavController:weakSelf.navigationController];
                break;
            }
            case bottomViewActionBuyNow:      { // 立即购买
                // 弹出分类选择界面或者 直接进入订单界面
                // FIXME: (未解决)暂时无对应商品信息 -> 订单信息内没有数据
                [UILabel showMessage:@"立即购买" atNavController:weakSelf.navigationController];
                [weakSelf.navigationController pushViewController:[[LJKOrderViewController alloc] init]
                                                         animated:YES];
                break;
            }
        }
    };
    [self.view addSubview:bottomBar];
}

#pragma mark - 数据处理
- (void)loadData {
    [LJKNetworkTool afnGet:LJKRequestGoods
                    params:nil
                   success:^(id json) {
                       self.goods = [LJKGoods mj_objectWithKeyValues:json[@"content"][@"goods"]];
                       [self.tableView reloadData];
                       [self setupTableViewHeaderView];
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - TableView 数据源 & 代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    WeakSelf;
    if (indexPath.section == 0) {
        LJKGoodsShopCell *cell = [tableView dequeueReusableCellWithIdentifier:shopCellIdentifier];
        cell.shop = self.goods.shop;
    
        // 前往店铺
        cell.goShopDidClickedBlock = ^() {
            [weakSelf pushWebViewWithUrl:self.goods.shop.url];
        };
        return cell;
    } else if (indexPath.section == 1) {
        LJKRecipeDishShowCell *cell = [tableView dequeueReusableCellWithIdentifier:reviewCellIdentifier];
        cell.type = LJKShowViewTypeReview;
        cell.goods = self.goods;

        cell.collectionViewCellClickedBlock = ^(NSInteger index) {
            [UILabel showMessage:[NSString stringWithFormat:@"点击了第%zd个评价 -> 跳转",index + 1]
                 atNavController:weakSelf.navigationController];
        };
        
        cell.showAllBlock = ^(){
            [UILabel showMessage:@"前往所有评价" atNavController:weakSelf.navigationController];
        };
        
        return cell;
    } else if (indexPath.section == 2) {
        LJKRecommendBuyCell *cell = [tableView dequeueReusableCellWithIdentifier:recommendBuyIdentifier];
        
        cell.collectionDidClickedBlock = ^(NSInteger index) {
            [UILabel showMessage:[NSString stringWithFormat:@"点击了第%zd个推荐产品 -> 跳转",index + 1]
                 atNavController:weakSelf.navigationController];
        };
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 150;
    } else if (indexPath.section == 1) {
        return self.goods.reviews.count ? (SCREEN_HEIGHT * 0.5 + 25) + 125 : 0;
    } else if (indexPath.section == 2) {
        return  self.goods.shopRecommendBuyCellHeight+ 50;
    }
    return 0;
}

#pragma mark - 点击事件
- (void)buyListButtonDidClicked {
    [self.navigationController pushViewController:[[LJKShoppingSortViewController alloc] init]
                                         animated:YES];
}

- (void)backButtonDidClicked {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)PYQButtonDidClicked {
    [UILabel showMessage:@"分享至朋友圈" atNavController:self.navigationController];
}

- (void)WeChatButtonDidClicked {
    [UILabel showMessage:@"分享至微信" atNavController:self.navigationController];
}

- (void)OtherButtonDidClicked {
    [UILabel showMessage:@"其他分享" atNavController:self.navigationController];
}

#pragma mark - UIScrollViewDelegate (上拉加载图文详情逻辑)
// 向上拖动到一定程度，切换至图文详情界面
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    // 预定值为100
//    if (scrollView.contentOffset.y > self.tableView.contentSize.height - self.tableView.frame.size.height + 100) {
//        // 隐藏商品信息
//        self.tableView.hidden = YES;
//        // 动画
//        [UIView animateWithDuration:0.5 animations:^{
//            self.tableView.transform = CGAffineTransformMakeTranslation(0, -(self.view.bounds.size.height-44-64));
////            self.imageTextView.transform = CGAffineTransformMakeTranslation(0, -(self.view.bounds.size.height-44));
//        } completion:^(BOOL finished) {
//
//            [UILabel showMessage:@"加载图文详情"
//                 atNavController:self.navigationController];
//
//        }];
//    }
//}

@end
