//
//  LJKRecommendBuyController.m
//  LJKitchen
//
//  Created by  a on 16/7/3.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKRecommendBuyController.h"
#import "LJKFeedsViewCell.h"            // 关注动态

#import "LJKReview.h"
#import "LJKReviewPhoto.h"

#import "LJKNetworkTool.h"
#import <MJRefresh.h>
#import <MJExtension.h>

@interface LJKRecommendBuyController ()
/** 商品数组 */
@property (nonatomic, strong) NSMutableArray *reviewsArray;
/** 存储cell内图片轮播器滚动位置 */
@property (nonatomic, strong) NSMutableArray *imageViewCurrentLocationArray;

@end

@implementation LJKRecommendBuyController

static NSString *const recommendCellIdentifier = @"recommendCell";

#pragma mark - 懒加载
- (NSMutableArray *)reviewsArray {
    if (!_reviewsArray) {
        _reviewsArray = [NSMutableArray array];
    }
    return _reviewsArray;
}

- (NSMutableArray *)imageViewCurrentLocationArray {
    if (!_imageViewCurrentLocationArray) {
        _imageViewCurrentLocationArray = [NSMutableArray array];
    }
    return _imageViewCurrentLocationArray;
}


#pragma mark - 页面主体
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
    [self setupTableView];
    [self setupRefresh];
    [self loadNewData];
}

- (void)setupNavigationBar {
    self.title = @"买买买";
}

- (void)setupTableView {
    self.tableView.backgroundColor = Color_BackGround;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[LJKFeedsViewCell class]
           forCellReuseIdentifier:recommendCellIdentifier];
}

- (void)setupRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self
                                                          refreshingAction:@selector(loadNewData)];
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self
                                                              refreshingAction:@selector(loadMoreData)];
}

#pragma mark - 数据处理
- (void)loadNewData {
    [LJKNetworkTool afnGet:LJKRequestKitchenBuy
                    params:nil
                   success:^(id json) {
                       self.reviewsArray = [LJKReview mj_objectArrayWithKeyValuesArray:json[@"content"][@"reviews"]];
                       
                       // 如果位置数组数量 > 模型数据，删除多余的数据
                       if (self.imageViewCurrentLocationArray.count > self.reviewsArray.count) {
                           // 多余的数量
                           NSUInteger length = self.imageViewCurrentLocationArray.count - self.reviewsArray.count;
                           NSRange shouldRemoveRange = NSMakeRange(self.reviewsArray.count, length);
                           [self.imageViewCurrentLocationArray removeObjectsInRange:shouldRemoveRange];
                           
                       } else if (self.imageViewCurrentLocationArray.count == 0){
                           for (NSInteger index=0; index<self.reviewsArray.count; index++) {
                               [self.imageViewCurrentLocationArray addObject:@(0)];
                           }
                       }
                       [self.tableView reloadData];
                       [self.tableView.mj_header endRefreshing];

    } failure:^(NSError *error) {
        
    }];
}

- (void)loadMoreData {
    [LJKNetworkTool afnGet:LJKRequestKitchenBuy
                    params:nil
                   success:^(id json) {
                       NSArray *moreData = [LJKReview mj_objectArrayWithKeyValuesArray:json[@"content"][@"reviews"]];
                       // ?:(未解决)此处图片数组会引起未知数组越界错误
                       [self.reviewsArray addObjectsFromArray:moreData];
                       for (NSInteger index = 0; index < moreData.count; index++) {
                           [self.imageViewCurrentLocationArray addObject:@(0)];
                       }
                       
                       [self.tableView reloadData];
                       [self.tableView.mj_footer endRefreshing];
                     
                       
                   } failure:^(NSError *error) {
                       [self.tableView.mj_footer endRefreshing];
                   }];
}

#pragma mark - tableView 数据源 & 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.reviewsArray.count) {
        self.tableView.mj_footer.hidden = YES;
    }
    return self.reviewsArray.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.reviewsArray.count) {
        LJKReview *review = self.reviewsArray[indexPath.row];
        return review.buyCellHeight;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LJKFeedsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:recommendCellIdentifier];
    cell.backgroundColor = Color_ThemeColor_Yellow;
    if (self.reviewsArray.count) {
        LJKReview *review = self.reviewsArray[indexPath.row];
        
        // 添加主图、附加图到要显示的图片数组
        NSMutableArray *imageArray = [NSMutableArray array];
        [imageArray addObjectsFromArray:review.photos];
        if (review.additional_review_photos.count) {
            NSArray *photosArray = [LJKReviewPhoto mj_objectArrayWithKeyValuesArray:review.additional_review_photos];
            [imageArray addObjectsFromArray:photosArray];
        }
        
        cell.type = LJKShowViewTypeReview;
        cell.review = review;
        cell.imageArray = imageArray;
        cell.imageViewCurrentLocation = [self.imageViewCurrentLocationArray[indexPath.row] floatValue];
        
        WeakSelf;
        // 防止cell的复用机制导致图片轮播器的位置错乱
        cell.imageViewDidScrolledBlock = ^(CGFloat finalContentOffsetX) {
            weakSelf.imageViewCurrentLocationArray[indexPath.row] = @(finalContentOffsetX);
        };
        
        cell.actionBlock = ^(DishViewAction action) {
            if (action == DishViewActionName) { // 点击了推荐商品 titleView

            }
        };
    }

    return cell;

}

@end
