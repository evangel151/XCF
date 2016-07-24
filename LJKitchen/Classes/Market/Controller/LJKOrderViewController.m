//
//  LJKOrderViewController.m
//  LJKitchen
//
//  Created by  a on 16/7/11.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  结算订单 (C) Done

#import "LJKOrderViewController.h"

#import "LJKCartItemShopHeader.h"       // 店铺   (header)
#import "LJKCartItemCell.h"             // 商品
#import "LJKOrderItemFooterView.h"      // 订单信息(footer)
#import "LJKOrderPayView.h"             // 底部结算工具条
#import "LJKOrderSupplementaryFooter.h" // 结算方式(footer)
//#import "LJKOrderPromotionCell.h"       // 优惠

#import "LJKCartItemTool.h"
#import "LJKCartItem.h"
#import "LJKGoods.h"


@interface LJKOrderViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableString *leaveMessage; // 留言

@end

@implementation LJKOrderViewController

static NSString *const cartItemHeaderIdentifier = @"cartItemHeader"; // 店铺名称
static NSString *const cartItemFooterIdentifier = @"cartItemfooter"; // 订单商品详情
static NSString *const cartItemCellIdentifier   = @"cartItemCell";   // 商品cell 
//static NSString *const promotionCellIdentifier = @"promotionCell";

#pragma mark - 懒加载
- (NSArray *)buyItems {
    // 如果没有数据，说明是从购物车进入
    if (!_buyItems.count) {
        _buyItems = [LJKCartItemTool totalBuyItems];
    }
    return  _buyItems;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - LJKCartSettlementViewHeight)
                                                  style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSMutableString *)leaveMessage {
    if (!_leaveMessage) {
        _leaveMessage = [[NSMutableString alloc] init];
    }
    return _leaveMessage;
}


#pragma mark - 页面构成

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationBar];
    [self setupTableViewHeader];
    [self setupTableView];
    [self setupTableViewFooter];
    [self setupOrderPayView];
    
}

- (void)setupNavigationBar {
    self.title = @"确认订单";
    self.view.backgroundColor = Color_BackGround;
}

- (void)setupTableViewHeader {
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    header.backgroundColor = Color_Cover_Alpha;
    UILabel *testLabel = [UILabel labelWithTextColor:Color_TintBlack
                                     backgroundColor:Color_ThemeColor_Alpha
                                            fontSize:15
                                               lines:0
                                       textAlignment:NSTextAlignmentLeft];
    testLabel.text = @" >>> TableViewHeader - 收货地址 <<<< ";
    testLabel.frame = CGRectMake(0, 10, SCREEN_WIDTH, 80);
    [header addSubview:testLabel];
    WeakSelf;
    UITapGestureRecognizer *tapAddress = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        [UILabel showMessage:@"跳转至地址选择" atNavController:weakSelf.navigationController];
    }];
    [header addGestureRecognizer:tapAddress];
    self.tableView.tableHeaderView = header;
}

- (void)setupTableView {
    // 订单 - 商品
    [self.tableView registerClass:[LJKCartItemCell class] forCellReuseIdentifier:cartItemCellIdentifier];
    // 订单 - 店铺
    [self.tableView registerClass:[LJKCartItemShopHeader class] forHeaderFooterViewReuseIdentifier:cartItemHeaderIdentifier];
    // 订单 - 商品详情
    [self.tableView registerClass:[LJKOrderItemFooterView class] forHeaderFooterViewReuseIdentifier:cartItemFooterIdentifier];
}


- (void)setupTableViewFooter {
    LJKOrderSupplementaryFooter *footer = [[LJKOrderSupplementaryFooter alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180)];
    
    WeakSelf;
    footer.promotionViewClickedBlock = ^(){
        [UILabel showMessage:@"跳转至优惠券……" atNavController:weakSelf.navigationController];
    };
    
    self.tableView.tableFooterView = footer;
}

- (void)setupOrderPayView {
    LJKOrderPayView *payView = [[LJKOrderPayView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - LJKCartSettlementViewHeight, SCREEN_WIDTH, LJKCartSettlementViewHeight)];
    
    payView.buyItems = self.buyItems;

    WeakSelf;
    payView.payButtonDidClickedBlock = ^(){
        [UILabel showMessage:@"调用集成的付款接口"
             atNavController:weakSelf.navigationController];
    };
    
    [self.view addSubview:payView];
}

#pragma mark - TableView 数据源 & 代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.buyItems.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *shopArray = self.buyItems[section];
    return shopArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    LJKCartItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cartItemCellIdentifier
                                                            forIndexPath:indexPath];
    cell.style         = LJKCartViewChildControlStyleOrder;
    NSArray *shopArray = self.buyItems[indexPath.section];
    LJKCartItem *item  = shopArray[indexPath.row];
    cell.cartItem      = item;
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    LJKCartItemShopHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:cartItemHeaderIdentifier];
    
    NSArray *shopArray = self.buyItems[section];
    header.style       = LJKCartViewChildControlStyleOrder;
    header.cartItem    = shopArray[0];
    
    return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    LJKOrderItemFooterView *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:cartItemFooterIdentifier];
    footer.shopArray = self.buyItems[section];
    
    WeakSelf;
    footer.leaveMessageBlock = ^(NSString *message) {
        [UILabel showMessage:@"退出编辑后保存留言"
             atNavController:weakSelf.navigationController];
    };
    
    return footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 140 + 10;
}

#pragma mark - 业务逻辑
#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.tableView endEditing:YES];
}

@end
