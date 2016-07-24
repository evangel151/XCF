
//
//  LJKMallSortViewController.m
//  LJKitchen
//
//  Created by  a on 16/6/8.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKMallSortViewController.h"
#import "LJKShoppingSortViewController.h"

#import "LJKMarketSortCell.h"

@interface LJKMallSortViewController ()

@end

@implementation LJKMallSortViewController

static NSString * const reuseIdentifier = @"Cell";

#pragma mark - init方法 (创建流水布局)
- (instancetype)init {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat itemWH = (SCREEN_WIDTH - 2) / 3;
    layout.itemSize = CGSizeMake(itemWH, itemWH);
    layout.minimumLineSpacing = 1;
    layout.minimumInteritemSpacing = 1;
    return [super initWithCollectionViewLayout:layout];
}

#pragma mark - 页面主体
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
    [self setupCollectionView];
}

- (void)setupCollectionView {
    self.collectionView.backgroundColor = Color_BackGround;
    self.collectionView.bounces = NO;
    [self.collectionView registerClass:[LJKMarketSortCell class]
            forCellWithReuseIdentifier:reuseIdentifier];
}

- (void)setupNavigationBar {
    self.title = @"市集分类";
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"shoppingCart"]
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(shoppingCart)];
}

#pragma mark - Nav点击事件
- (void)shoppingCart {
    LJKShoppingSortViewController *cart = [[LJKShoppingSortViewController alloc] init];
    [self.navigationController pushViewController:cart animated:YES];
}

#pragma mark - 数据源 & 代理
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 15;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    LJKMarketSortCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    NSString *imageName = [NSString stringWithFormat:@"market_menu_%zd",indexPath.item + 1];
    cell.sortItemView.image = [UIImage imageNamed:imageName];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [SVProgressHUD showImage:[UIImage imageNamed:@"notification"]
                      status:@"即将跳转对应的搜索结果"];
    NSArray *itemArray = @[@"烘焙",@"果蔬生鲜",@"器具",@"领券中心",@"零食",@"进口食品",@"调味品",@"方便食品",@"腌制食品",@"南北干货",@"饮品茶酒",@"米面粮油",@"厨房电器",@"礼盒",@"山姆会员尊享"];
    [UILabel showMessage:[NSString stringWithFormat:@"点击了>>> %@ <<<即将跳转",itemArray[indexPath.item]]
         atNavController:self.navigationController];
    NSLog(@"点击了第%zd个item,即将跳转对应的搜索结果", indexPath.item + 1);
}


@end
