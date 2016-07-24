//
//  LJKShoppingSortViewController.m
//  LJKitchen
//
//  Created by  a on 16/6/8.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKShoppingSortViewController.h"
#import "LJKOrderViewController.h"          // 订单
#import "LJKGoodsViewController.h"          // 商品
#import "LJKShopViewController.h"           // 店铺

#import "LJKCartSettlementView.h"           // 底部结算工具条
#import "LJKCartItemShopHeader.h"           // 商铺(cellHeader)
#import "LJKCartItemCell.h"                 // 商品Cell

#import "LJKCartItem.h"
#import "LJKGoods.h"
#import "LJKShop.h"

#import "LJKCartItemTool.h"                 // 购物车工具(逻辑)

@interface LJKShoppingSortViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
/** 购物车 - 商店数据 */
@property (nonatomic, strong) NSMutableArray *shopArray;
/** 购物车 - 结算view (底部) */
@property (nonatomic, strong) LJKCartSettlementView *settlementView;


@end

@implementation LJKShoppingSortViewController

static NSString *const cartItemIdentifier    = @"cartItemCell";    // 商品Cell
static NSString *const headerReuseIdentifier = @"cartItemHeader";  // 店铺Header

#pragma mark - 懒加载
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - LJKCartSettlementViewHeight)
                                                  style:UITableViewStyleGrouped];
        _tableView.bounces = NO;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.sectionFooterHeight = 10;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSMutableArray *)shopArray {
    if (!_shopArray) {
        _shopArray = [NSMutableArray array];
    }
    return _shopArray;
}


#pragma mark - 页面构成
// 重置TableView中 商品状态
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 每次pop回来就重置购物车商品点选状态
    [LJKCartItemTool resetItemState];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
    [self setupTableView];
    [self setupSettlementView];
}


- (void)setupNavigationBar {
    self.title = @"购物车";
    self.navigationItem.rightBarButtonItem =
    [UIBarButtonItem barButtonItemWithTitle:@"编辑"
                              selectedTitle:@"完成"
                                     target:self
                                     action:@selector(editOrDoneDidClicked:)];
    
}

- (void)setupTableView {
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 购物车 - cellHeader
    [self.tableView registerClass:[LJKCartItemShopHeader class]
forHeaderFooterViewReuseIdentifier:headerReuseIdentifier];
    // 购物车 - 商品
    [self.tableView registerClass:[LJKCartItemCell class]
           forCellReuseIdentifier:cartItemIdentifier];
}

- (void)setupSettlementView {
    self.settlementView = [[LJKCartSettlementView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - LJKCartSettlementViewHeight, SCREEN_WIDTH, LJKCartSettlementViewHeight)];
    // 加载购物车内商品
    self.settlementView.totalItemsArray = [LJKCartItemTool totalItems];
    // 默认为结算模式
    self.settlementView.style = LJKCartEditStyleSettlement;
    [self.view addSubview:self.settlementView];
    
    WeakSelf;
    // 全选按钮回调 刷新TableView
    self.settlementView.selectedAllItemBlock = ^(LJKCartItemState state) {
        [LJKCartItemTool updateAllItemState:state];
        [weakSelf.tableView reloadData];
    };
    
    // 结算、删除模式 回调
    self.settlementView.settleOrDeleteBlock = ^{
        // 结算模式
        if (weakSelf.settlementView.style == LJKCartEditStyleSettlement ) {
            
            // 判断能否进行结算
            NSUInteger totalNumber = 0;
            for (NSArray *shopArray in [LJKCartItemTool totalItems]) {
                for (LJKCartItem *item in shopArray) {
                    if (item.state == LJKCartItemStateSelected)  {
                        totalNumber += item.number;
                    }
                }
            }
            
            if (totalNumber) { // (有商品)可进行结算
                [weakSelf.navigationController pushViewController:[[LJKOrderViewController alloc] init]
                                                         animated:YES];
            } else           { // (无商品) 提示用户需要选择至少一件商品 进行结算
                [UILabel showMessage:@"请选择需要支付的商品"
                     atNavController:weakSelf.navigationController];
            }
            
        }
        // 删除模式
        else if (weakSelf.settlementView.style == LJKCartEditStyleDelete) {
            
            // 计算总商品数量
            NSArray *totalItemsArray = [LJKCartItemTool totalItems];
            NSUInteger totalGoods = 0;  // 总商品数  （删除时显示）
            for (NSArray *shopArray in totalItemsArray) {
                for (LJKCartItem *item in shopArray) {
                    if (item.state == LJKCartItemStateSelected)  {
                        totalGoods++;
                    }
                }
            }
            
            if (totalGoods) { // (有商品)可供删除
                // 弹出AlertAction
                [weakSelf showDeleteGoodsAlertWithTotalGoods:totalGoods];
                
            } else          { // (无选中商品) 提示用户需要进行删除
                [UILabel showMessage:@"请选择需要删除的商品"
                     atNavController:weakSelf.navigationController];
            }
            
        }
        
    };
}



#pragma mark - TableView 数据源 & 代理 

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    self.settlementView.totalItemsArray = [LJKCartItemTool totalItems];
    [self updateCheckAllMarkState];
    return [LJKCartItemTool totalItems].count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.shopArray = [LJKCartItemTool totalItems][section];
    return self.shopArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    LJKCartItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cartItemIdentifier];
    cell.style = LJKCartViewChildControlStyleCart;
    NSArray *shopArray = [LJKCartItemTool totalItems][indexPath.section];
    LJKCartItem *cartItem = shopArray[indexPath.row];
    cell.cartItem = cartItem;
    
    WeakSelf;
    // 选中回调
    cell.selectedItemBlock = ^(LJKCartItemState state) { // 勾选商品回调
        cartItem.state = state;
        [LJKCartItemTool updateItemAtIndexPath:indexPath withItem:cartItem];
        [weakSelf.tableView reloadData];
    };
    
    // 修改商品数量回调
    cell.itemNumberChangeBlock = ^(NSUInteger number) { // 修改商品个数回调
        
        // 拿到之前保存的数据，再修改数量
        // 如果不拿到最新数据，在编辑商品数量时点击店铺全选 会导致正在编辑的商品无法同步选中状态的bug
        NSArray *newShopArray = [LJKCartItemTool totalItems][indexPath.section];
        LJKCartItem *newItem = newShopArray[indexPath.row];
        newItem.number = number;// 修改数据中商品个数的值
        [LJKCartItemTool updateItemAtIndexPath:indexPath withItem:newItem];// 更新本地数据
        [weakSelf.tableView reloadData];// 刷新界面
    };
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    LJKCartItemShopHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerReuseIdentifier];
    NSArray *shopArray = [LJKCartItemTool totalItems][section];
    header.style = LJKCartViewChildControlStyleCart;
    header.cartItem = shopArray[0];
    BOOL allItemsSelected = YES; // 记录店铺全选状态
    for (LJKCartItem *item in shopArray) {
        if (item.state == LJKCartItemStateNone) {
            allItemsSelected = NO; // 只要有一个不是选中状态，就取消店铺选中
            break;
        }
    }
    
    WeakSelf;
    // 店铺全选回调
    header.selectedShopItemsBlock = ^(LJKCartShopState state) {
        // 同步店铺内商品与店铺的点选状态
        LJKCartItemState itemState = (LJKCartItemState)state;
        for (LJKCartItem *item in shopArray) {
            item.state = itemState;
        }
        [LJKCartItemTool updateShopArrayAtIndex:section withShopArray:shopArray];
        [weakSelf.tableView reloadData];
    };
    
    // 店铺Header 点击回调
    header.shopHeaderDidClickedBlock = ^(){
        [weakSelf.navigationController pushViewController:[[LJKShopViewController alloc] init]
                                                 animated:YES];
    };
    
    header.state = allItemsSelected;
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LJKGoodsViewController *goodsVc = [[LJKGoodsViewController alloc] init];
    [self.navigationController pushViewController:goodsVc animated:YES];
}

#pragma mark - 点击事件
// NaviRightBtn 点击后切换 结算style & 重载TableView
- (void)editOrDoneDidClicked:(UIButton *)button {
    button.selected = !button.selected;
    self.settlementView.style = button.isSelected;
    [self.tableView reloadData];
}

#pragma mark - 相关业务逻辑
// 结算条显示业务逻辑
- (void)updateCheckAllMarkState {
    NSArray *totalItemsArray = [LJKCartItemTool totalItems];
    BOOL allItemsSelected = YES;
    // 遍历所有商品状态，只要搜索到1个Item未选中，更改全选状态
    for (NSArray *shopArray in totalItemsArray) {
        for (LJKCartItem *item in shopArray) {
            if (item.state == LJKCartItemStateNone) {
                allItemsSelected = NO;
                break;
            }
        }
    }
    
    if (!allItemsSelected) { // 非全选
        self.settlementView.state = LJKCartShopStateNone;
    } else {
        self.settlementView.state = LJKCartShopStateSelected;
    }
}

#pragma mark - AlertAction 
- (void)showDeleteGoodsAlertWithTotalGoods:(NSInteger)totalGoods  {

    NSString *displayTitle = [NSString stringWithFormat:@"确定要删除这%zd种商品吗", totalGoods];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:displayTitle
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                         // 删除所有商品后 -> 重载所有商品
                                                         [LJKCartItemTool removeSelectedItem]; // 删除选中的商品
                                                         [self.tableView reloadData];
                                                     }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self.navigationController presentViewController:alertController animated:YES completion:nil];

}

#pragma mark - Dealloc
// 不保存购物车商品的点选状态
- (void)dealloc {
    [LJKCartItemTool resetItemState];
}

@end
