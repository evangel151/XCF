//
//  LJKBLSViewController.m
//  LJKitchen
//
//  Created by  a on 16/6/21.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  Done

#import "LJKBLSViewController.h"
#import "LJKBLSViewHeader.h"
#import "LJKBLSViewCell.h"

#import "LJKBLSHeaderData.h"
#import "LJKDish.h"

#import "LJKNetworkTool.h"
#import <Masonry.h>
#import <MJExtension.h>
#import <MJRefresh.h>

@interface LJKBLSViewController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
/** 三餐 - 上传我的作品 */
@property (nonatomic, strong) UIButton *uploadMyDishButton;
@property (nonatomic, strong) LJKBLSHeaderData *headerData;
@property (nonatomic, strong) NSArray *dishArray;
@end

@implementation LJKBLSViewController

static NSString * const reuseIdentifier  = @"BLSDishCell";
static NSString * const headerIdentifier = @"BLSHeader";
static NSString * const footerIdentifier = @"BLSFooter";



#pragma mark - 懒加载
- (UIButton *)uploadMyDishButton {
    if (!_uploadMyDishButton) {
        _uploadMyDishButton = [UIButton buttonWithTitle:@"上传我的作品"
                                             titleColor:Color_TintWhite
                                        backgroundColor:Color_ThemeColor_Alpha
                                               fontSize:17
                                                 target:self
                                                 action:@selector(uploadMyDish)];
        [_uploadMyDishButton setImage:[UIImage imageNamed:@"camera"] forState:UIControlStateNormal];
    }
    return _uploadMyDishButton;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake((SCREEN_WIDTH - 10) * 0.5, 300);
        flowLayout.minimumInteritemSpacing = 10;
        flowLayout.minimumLineSpacing = 10;
        flowLayout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 120);
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds
                                             collectionViewLayout:flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_collectionView];
        
        [_collectionView registerClass:[LJKBLSViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
        [_collectionView registerClass:[LJKBLSViewHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerIdentifier];
    }
    return _collectionView;
}

#pragma mark - 页面主体
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubviews];
    [self loadNewData];
}

- (void)setupSubviews {
    self.collectionView.backgroundColor = Color_BackGround;

    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.uploadMyDishButton];
    [_uploadMyDishButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, TABBAR_HEIGHT));
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
    }];
}


#pragma mark - 数据处理
- (void)loadNewData {
    
    // 2016.6月22日 晚餐
    [LJKNetworkTool afnGet:LJKRequestKitchenSupper
                    params:nil
                   success:^(id json) {

                       self.headerData = [LJKBLSHeaderData mj_objectWithKeyValues:json[@"content"][@"event"]];
                       [self.collectionView reloadData];
                       NSString *string = [self.headerData.name substringWithRange:NSMakeRange(0, 2)];
                       [self.uploadMyDishButton setTitle:[NSString stringWithFormat:@"上传我的%@", string]
                                                forState:UIControlStateNormal];
                       
    }
                   failure:^(NSError *error) {
                       NSLog(@"加载header失败 原因:%@", error);
    }];
    
    
    // FIXME: (未解决)无法使用固定request获取数据
    // (抓包获取的url时效性约10min ~ 30min不等) 失效后仍返回success,但数据为nil
    // 2016.6月22日 晚餐
//    NSString *supper = @"http://api.xiachufang.com/v2/events/100131208/dishes_order_by_hot_v2.json?api_sign=203b9171e8adaf9493110c90e53069d6&limit=18&sk=EhUpkVYBSoOT9qAapL0BUw&timestamp=1466598138&nonce=2B9BE1A1-3B94-4F27-AABE-DCCE44E030FA&api_key=07397197043fafe11ce5c65c10febf84&version=5.5.0&_ts=1466598139.679015&dish_size=360w_360h&offset=0&location_code=156320900000000&detail=true&origin=iphone";
    [LJKNetworkTool afnGet:LJKRequestKitchenSupperDishes
                    params:nil
                   success:^(id json) {
//                       NSLog(@"作品json: %@", json);
                       self.dishArray = [LJKDish mj_objectArrayWithKeyValuesArray:json[@"content"][@"dishes"]];
                       [self.collectionView reloadData];

                       NSUInteger count = self.dishArray.count;
                       WeakSelf;
                       if (count == 0 ) {
                           [UILabel showMessage:@"请求已过期，无法显示，请重新抓取" atNavController:weakSelf.navigationController];
                       }
                   }
                   failure:^(NSError *error) {
                       NSLog(@"加载dishs失败 原因:%@", error);
                   }];
}

- (void)uploadMyDish {
    // TODO: 上传菜品界面未完成
     NSLog(@"即将跳转上传作品界面——————");
}

#pragma mark - collectionView 数据源 & 代理

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    // FIXME:(已解决) 接口无故失效！！！
    // 接口具有时效性……(抓包获取的url时效性约10min ~ 30min不等) 失效后仍返回success,但数据为nil)
    // return 20;
//    WeakSelf;
//    if (count == 0 ) {
//        [UILabel showMessage:@"作品接口已失效，暂时无法显示" atNavController:weakSelf.navigationController];
//    }
    NSUInteger count = self.dishArray.count;
    return count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LJKBLSViewCell *cell =
    [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                              forIndexPath:indexPath];
    cell.dish = self.dishArray[indexPath.row];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableView;
    if([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        LJKBLSViewHeader *header =
        [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                           withReuseIdentifier:headerIdentifier
                                                  forIndexPath:indexPath];
        
        header.data = self.headerData;
        reusableView = header;
    } else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerIdentifier forIndexPath:indexPath];
        
    }
    return reusableView;
}

- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(SCREEN_WIDTH, 90.0);
}

- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(SCREEN_WIDTH, 44.0);
}

@end
