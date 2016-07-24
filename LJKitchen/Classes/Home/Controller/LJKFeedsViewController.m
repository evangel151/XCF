//
//  LJKFeedsViewController.m
//  LJKitchen
//
//  Created by  a on 16/7/1.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKFeedsViewController.h"
#import "LJKRecipeViewController.h"  // 菜谱详情

#import "LJKFeedsViewCell.h"

#import "LJKDish.h"
#import "LJKFeeds.h"
#import "LJKPicture.h"

#import "LJKNetworkTool.h"
#import <MJRefresh.h>
#import <MJExtension.h>

@interface LJKFeedsViewController ()<UIActionSheetDelegate>

@property (nonatomic, strong) NSMutableArray *feedsArray;
@property (nonatomic, strong) NSMutableArray *imageViewCurrentLocationArray; // 存储cell内图片轮播器滚动位置
@end

@implementation LJKFeedsViewController

static NSString *feedsCellIdentifier = @"feedsCell";

#pragma mark - 懒加载
- (NSMutableArray *)feedsArray {
    if (!_feedsArray) {
        _feedsArray = [NSMutableArray array];
    }
    return _feedsArray;
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
    [self setupRefresh];
    [self loadNewData];
}

- (void)setupTableView {
    self.tableView.backgroundColor = Color_BackGround;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[LJKFeedsViewCell class]
           forCellReuseIdentifier:feedsCellIdentifier];
    
}

- (void)setupNavigationBar {
    
    // FIXME: (已解决)直接设置默认rightBarButtonItems 会导致上传按钮被隐藏 or 错误的颜色显示
    // 下面的方式设置一个空的标题后可以解决这个问题……但感觉有点蠢……
    self.title = @"关注动态";
    UIBarButtonItem *notifi = [[UIBarButtonItem alloc] initWithTitle:@""
                                                               style:UIBarButtonItemStylePlain
                                                              target:self
                                                              action:@selector(notificationButtonClicked)];
    notifi.image = [UIImage imageNamed:@"notification"];
    
    UIBarButtonItem *upload = [[UIBarButtonItem alloc] initWithTitle:@""
                                                               style:UIBarButtonItemStylePlain
                                                              target:self
                                                              action:@selector(uploadDishButtonClicked)];
    upload.image = [UIImage imageNamed:@"uploadPhoto"];
    upload.tintColor = Color_ThemeColor;
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:notifi, upload, nil];
}

- (void)setupRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

#pragma mark - 数据处理
- (void)loadNewData {
    

    [LJKNetworkTool afnGet:LJKRequestKitchenFeeds
                    params:nil
                   success:^(id json) {
                       
                       self.feedsArray = [LJKFeeds mj_objectArrayWithKeyValuesArray:json[@"content"][@"feeds"]];
                       if (self.imageViewCurrentLocationArray.count > self.feedsArray.count) {
                           NSUInteger length = self.imageViewCurrentLocationArray.count - self.feedsArray.count;
                           NSRange shouldRemoveRange = NSMakeRange(self.feedsArray.count, length);
                           [self.imageViewCurrentLocationArray removeObjectsInRange:shouldRemoveRange];
                           
                       } else if (self.imageViewCurrentLocationArray.count == 0){ // 如果数组为空，添加与模型数据数量相等的 位移数据
                           for (NSInteger index=0; index<self.feedsArray.count; index++) {
                               [self.imageViewCurrentLocationArray addObject:@(0)];
                           }
                       }
                       [self.tableView reloadData];
                       [self.tableView.mj_header endRefreshing];
                       
    } failure:^(NSError *error) {
                        [self.tableView.mj_header endRefreshing];
                        NSLog(@"加载失败 原因:%@", error);
    }];
}


- (void)loadMoreData {
    
    [self.tableView.mj_header endRefreshing];
    [LJKNetworkTool afnGet:LJKRequestKitchenFeeds
                    params:nil
                   success:^(id json) {
                       
                       NSArray *newContent = [LJKFeeds mj_objectArrayWithKeyValuesArray:json[@"content"][@"feeds"]];
                       [self.feedsArray addObjectsFromArray:newContent];
                       // 添加对应个数的图片位置到数组中
                       for (NSInteger index=0; index<newContent.count; index++) {
                           [self.imageViewCurrentLocationArray addObject:@(0)];
                       }
                       [self.tableView reloadData];
                       [self.tableView.mj_footer endRefreshing];
                       
    } failure:^(NSError *error) {
                        [self.tableView.mj_footer endRefreshing];
                        NSLog(@"加载失败 原因:%@", error);
    }];
}


#pragma mark - TableView 数据源 & 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.feedsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    LJKFeedsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:feedsCellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = Color_ThemeColor_Yellow;
    
    if (self.feedsArray.count) {
        LJKFeeds *feeds = self.feedsArray[indexPath.row];
        
        // 添加主图、附加图到要显示的图片数组
        NSMutableArray *imageArray = [NSMutableArray array];
        if (feeds.dish) {
            [imageArray addObject:feeds.dish.main_pic];
        }
        
        if (feeds.dish.extra_pics.count) {
            NSArray *extraPicArray = [LJKPicture mj_objectArrayWithKeyValuesArray:feeds.dish.extra_pics];
            [imageArray addObjectsFromArray:extraPicArray];
        }
        
        cell.type = LJKShowViewTypeDish;
        cell.dish = feeds.dish;
        cell.imageArray = imageArray;
        
        // 赋值每个cell对应的图片滚动位置
        cell.imageViewCurrentLocation = [self.imageViewCurrentLocationArray[indexPath.row] floatValue];
    }
    
    WeakSelf;
    // ???: ... why?
    cell.imageViewDidScrolledBlock = ^(CGFloat finalContentOffsetX) {
        // 拿到最后的位置保存到数组中
        weakSelf.imageViewCurrentLocationArray[indexPath.row] = @(finalContentOffsetX);
    };
    
    cell.actionBlock = ^(DishViewAction action) {
        switch (action) {
            case DishViewActionIcon: {     // 用户头像
//                [UILabel showMessage:@"即将跳转至关注用户界面"
//                     atNavController:weakSelf.navigationController];
                [weakSelf pushWebViewWithUrl:LJKRequestKitchenAuthorPage];
                break;
            }
            case DishViewActionName: {     // 菜谱
                [UILabel showMessage:@"跳转至对应菜谱界面"
                     atNavController:weakSelf.navigationController];
                [weakSelf.navigationController pushViewController:[[LJKRecipeViewController alloc] init] animated:YES];
                break;
            }
            case DishViewActionDigg: {     // 点赞按钮

                break;
            }
            case DishViewActionCommment: { // 评论按钮 & total评论Label
                [UILabel showMessage:@"即将跳转至少全部评论界面"
                     atNavController:weakSelf.navigationController];
                break;
            }
            case DishViewActionMore: {     // 更多按钮
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row == 0 || indexPath.row == 1) {
//        [self.navigationController pushViewController:[[LJKRecipeViewController alloc] init] animated:YES];
//    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.feedsArray.count) {
        LJKFeeds *feeds = self.feedsArray[indexPath.row];
        return feeds.dish.dishCellHeight + feeds.dish.commentViewHeight;
    }
    return 0;
}

#pragma mark - 点击事件 
- (void)notificationButtonClicked {
     NSLog(@"点击了通知中心——————");
}

- (void)uploadDishButtonClicked {
    NSLog(@"点击了上传图片按钮——————");
}

#pragma mark - AlertAction reuseMethod 
- (void)showReportSuccessHUD {
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD showWithStatus:@"LJKitchen已经收到您的举报，我们会对作品信息进行核查，感谢您对LJKitchen一直以来的支持"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}


//- (void)moreButtonClickedInDishView {
//    
//}

@end
