//
//  LJKDishViewController.m
//  LJKitchen
//
//  Created by  a on 16/7/6.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKDishViewController.h"
#import "LJKFeedsViewCell.h"
#import "LJKRecipeViewController.h"

#import "LJKDish.h"
#import "LJKPicture.h"

#import "LJKNetworkTool.h"
#import <MJRefresh.h>
#import <MJExtension.h>

@interface LJKDishViewController ()
@property (nonatomic, strong) LJKDish *dish;
@property (nonatomic, strong) NSMutableArray *dishArray;
@property (nonatomic, strong) NSMutableArray *imageViewCurrentLocationArray; // 存储cell内图片轮播器滚动位置
@end

@implementation LJKDishViewController

static NSString *const dishCellIdentifier = @"dishCell";

#pragma mark - 懒加载
- (NSMutableArray *)dishArray {
    if (!_dishArray) {
        _dishArray = [[NSMutableArray alloc] init];
    }
    return _dishArray;
}

- (NSMutableArray *)imageViewCurrentLocationArray {
    if (!_imageViewCurrentLocationArray) {
        _imageViewCurrentLocationArray = [NSMutableArray array];
    }
    return _imageViewCurrentLocationArray;
}


#pragma mark - 页面构成
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
    [self setupTableView];
    [self loadNewData];
}

- (void)setupNavigationBar {
    self.title = @"菜品";
    self.view.backgroundColor = Color_BackGround;
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@"分享"
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(shareDish)];
    self.navigationItem.rightBarButtonItem.tintColor = Color_ThemeColor;
}

- (void)setupTableView {
    self.tableView.bounces = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = Color_Clear;
    [self.tableView registerClass:[LJKFeedsViewCell class]
           forCellReuseIdentifier:dishCellIdentifier];
}

- (void)loadNewData {
    [LJKNetworkTool afnGet:LJKRequestKitchenDish
                    params:nil
                   success:^(id json) {
                       self.dish = [LJKDish mj_objectWithKeyValues:json[@"content"][@"dish"]];
                       self.title = self.dish.name;
                       NSInteger count = 0;
                       if (self.dish.main_pic) {
                           count = self.dish.extra_pics.count + 1;
                       }
                       [self.imageViewCurrentLocationArray addObject:@(count)];
                       
                       [self.tableView reloadData];
    } failure:^(NSError *error) {
                        NSLog(@"加载失败, 原因:%@", error);
    }];
}

#pragma mark - TableView 数据源 & 代理 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LJKFeedsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dishCellIdentifier];
    cell.backgroundColor = Color_ThemeColor_Yellow;
    
    if (indexPath.row == 0) {
        NSMutableArray *imageArray = [NSMutableArray array];
        if (self.dish) {
            [imageArray addObject:self.dish.main_pic];
        }
        
        if (self.dish.extra_pics.count) {
            NSArray *extraPicArray = [LJKPicture mj_objectArrayWithKeyValuesArray:self.dish.extra_pics];
            [imageArray addObjectsFromArray:extraPicArray];
        }
        cell.dish = self.dish;
        cell.imageArray = imageArray;
        cell.type = LJKShowViewTypeDish;
    }
    
    // 赋值每个cell对应的图片滚动位置
//    cell.imageViewCurrentLocation = [self.imageViewCurrentLocationArray[indexPath.row] floatValue];
    WeakSelf;
    cell.imageViewDidScrolledBlock = ^(CGFloat finalContentOffsetX) {
        // 拿到最后的位置保存到数组中
        weakSelf.imageViewCurrentLocationArray[indexPath.row] = @(finalContentOffsetX);
    };

    
    cell.actionBlock = ^(DishViewAction action) {
        switch (action) {
            case DishViewActionIcon: {     // 用户头像
                [UILabel showMessage:@"即将跳转至关注用户界面"
                     atNavController:weakSelf.navigationController];
                [weakSelf pushWebViewWithUrl:LJKRequestKitchenAuthorPage];
                break;
            }
            case DishViewActionName: {     // 菜谱
                [UILabel showMessage:@"即将跳转至对应菜谱界面"
                     atNavController:weakSelf.navigationController];
                [weakSelf.navigationController pushViewController:[[LJKRecipeViewController alloc] init]
                                                         animated:YES];
                break;
            }
            case DishViewActionDigg: {     // 点赞按钮
                [UILabel showMessage:@"点赞按钮取反 - 发送请求至服务器，刷新页面"
                     atNavController:weakSelf.navigationController];
                break;
            }
            case DishViewActionCommment: { // 评论按钮 & total评论Label
                [UILabel showMessage:@"即将跳转至少全部评论界面"
                     atNavController:weakSelf.navigationController];
                break;
            }
            case DishViewActionMore: {     // 更多按钮
                // TODO: 将feedsViewController内的Alert进行封装
                UIAlertController *alertVC =
                // 一级AlertAction
                [UIAlertController alertControllerWithTitle:@"更多"
                                                    message:nil
                                             preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *sharedDish =
                [UIAlertAction actionWithTitle:@"分享作品"
                                         style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction * _Nonnull action) {
                                           
                                       }];
                
                UIAlertAction *reportDish =
                [UIAlertAction actionWithTitle:@"举报"
                                         style:UIAlertActionStyleDestructive
                                       handler:^(UIAlertAction * _Nonnull action) {
                                           
                                           // 二级AlertAction
                                           UIAlertController *alertVcInside =
                                           [UIAlertController alertControllerWithTitle:@"请选择你的举报理由？"
                                                                               message:nil
                                                                        preferredStyle:UIAlertControllerStyleAlert];
                                           
                                           UIAlertAction *rubbish =
                                           [UIAlertAction actionWithTitle:@"广告或垃圾信息"
                                                                    style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * _Nonnull action) {
                                                                      [self showReportSuccessHUD];
                                                                  }];
                                           UIAlertAction *stolenImage =
                                           [UIAlertAction actionWithTitle:@"盗图或抄袭"
                                                                    style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * _Nonnull action) {
                                                                      [self showReportSuccessHUD];
                                                                  }];
                                           UIAlertAction *other =
                                           [UIAlertAction actionWithTitle:@"其他"
                                                                    style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * _Nonnull action) {
                                                                      [self showReportSuccessHUD];
                                                                  }];
                                           UIAlertAction *nonConformity =
                                           [UIAlertAction actionWithTitle:@"与主题不符"
                                                                    style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * _Nonnull action) {
                                                                      [self showReportSuccessHUD];
                                                                  }];
                                           
                                           [alertVcInside addAction:rubbish];
                                           [alertVcInside addAction:stolenImage];
                                           [alertVcInside addAction:other];
                                           [alertVcInside addAction:nonConformity];
                                           [weakSelf presentViewController:alertVcInside animated:YES completion:nil];
                                       }];
                
                [alertVC addAction:reportDish];
                [alertVC addAction:sharedDish];
                
                [alertVC setModalPresentationStyle:UIModalPresentationOverFullScreen];
                [weakSelf presentViewController:alertVC animated:YES completion:nil];
                break;
            }
        }
    };
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.dish) {
        return self.dish.dishCellHeight + self.dish.commentViewHeight;
    }
    return 0;
}

#pragma mark - 点击事件
- (void)shareDish {
    [UILabel showMessage:@"分享该道菜品" atNavController:self.navigationController];
}

#pragma mark - AlertAction reuseMethod
- (void)showReportSuccessHUD {
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD showWithStatus:@"LJKitchen已经收到您的举报，我们会对作品信息进行核查，感谢您对LJKitchen一直以来的支持"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

@end
