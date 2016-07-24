//
//  LJKProfileViewController.m
//  LJKitchen
//
//  Created by  a on 16/6/8.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKProfileViewController.h"
#import "LJKFindFriendViewController.h"
#import "LJKSettingViewController.h"
#import "LJKProfileEditViewController.h"

#import "LJKProfileHeader.h"

#import "LJKAuthorDetail.h"
#import "LJKMyInfo.h"
#import "LJKDish.h"

#import "LJKNetworkTool.h"
#import <HMSegmentedControl.h>
#import <MJExtension.h>
#import <UIImageView+WebCache.h>

@interface LJKProfileViewController () <UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) LJKAuthorDetail *authorDetail;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UICollectionView *myDishCollectionView;
@property (nonatomic, assign) CGFloat headerHeight;
@property (nonatomic, assign) CGFloat scrollViewHeight;
@property (nonatomic, strong) NSMutableArray *authorDishArray;
@end

@implementation LJKProfileViewController

static NSString * const mydishIdentifier = @"myDishCollectionCell";

#pragma mark - 懒加载
- (NSMutableArray *)authorDishArray {
    if (!_authorDishArray) {
        _authorDishArray = [NSMutableArray array];
    }
    return _authorDishArray;
}


#pragma mark - 页面主体
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName,
      [UIFont systemFontOfSize:17], NSFontAttributeName, nil]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.authorDetail = [LJKMyInfo  info];
    [self setupNavigationBar];
    [self setupHeader];
    [self setupSegment];
    [self setupScrollView];
    [self setupMyDishCollectionView];
    [self setupMyRecipeView];
    [self loadNewData];
    
}

- (void)setupNavigationBar {
    self.navigationItem.leftBarButtonItem =
    [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navFindFriendsImage"]
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(findFriend)];
    
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"rightPageSetting"]
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(setting)];
}

- (void)setupHeader {
    // header 高度 = 信息栏 + 导航按钮组 + 绑定手机栏
    self.headerHeight = LJKProfileHeader_InfoView_Height + LJKHomeHeader_CenterNav_Height + LJKHomeHeader_NewAuthor_Height;
    LJKProfileHeader *header = [[LJKProfileHeader alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, self.headerHeight)];
    header.authorDetail = self.authorDetail;
    [self.view addSubview:header];
    
    /** 顶部导航视图点击事件 */

    WeakSelf;
    header.clickBlock = ^(NSInteger headerDidClickedAction) {

        switch (headerDidClickedAction) {
            case headerDidClickedActionInfoView: { // 个人信息编辑
                [weakSelf.navigationController pushViewController:[[LJKProfileEditViewController alloc] init] animated:YES];
                NSLog(@"点击了\"个人信息(我)\"栏——————");
                [UILabel showMessage:@"个人信息" atNavController:weakSelf.navigationController];
                break;
            }
            case headerDidClickedActionCollected: { // 收藏
                NSLog(@"点击了 收藏 按钮——————");
                [UILabel showMessage:@"收藏" atNavController:weakSelf.navigationController];
                break;
            }
            case headerDidClickedActionOrders: { // 订单
                NSLog(@"点击了 订单 按钮——————");
                [UILabel showMessage:@"订单" atNavController:weakSelf.navigationController];
                break;
            }
            case headerDidClickedActionPreferential: {
                NSLog(@"点击了 优惠 按钮——————");
                [UILabel showMessage:@"优惠" atNavController:weakSelf.navigationController];
                break;
            }
            case headerDidClickedActionScore: {
                NSLog(@"点击了 积分 按钮——————");
                [UILabel showMessage:@"积分" atNavController:weakSelf.navigationController];
                break;
            }
            case headerDidClickedActionBindMobile: {
                NSLog(@"点击了 绑定手机 View——————");
                [UILabel showMessage:@"绑定手机" atNavController:weakSelf.navigationController];
                break;
            }
        }
        
    };
}

- (void)setupSegment {
    // 重灾区……
    HMSegmentedControl *segmentControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"作品",@"菜谱"]];
    segmentControl.frame = CGRectMake(0, self.headerHeight + NAVBAR_HEIGHT, SCREEN_WIDTH, TABBAR_HEIGHT);
    segmentControl.selectionIndicatorHeight = 4.0;
    segmentControl.backgroundColor = Color_BackGround;
    segmentControl.titleTextAttributes = @{NSForegroundColorAttributeName : Color_ThemeColor};
    segmentControl.selectionIndicatorColor = Color_ThemeColor;
    segmentControl.selectedSegmentIndex = 0;
    segmentControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    segmentControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    segmentControl.shouldAnimateUserSelection = NO;
    [segmentControl addTarget:self
                       action:@selector(segmentedControlChangedValue:)
             forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentControl];
}


- (void)setupScrollView {
    self.scrollViewHeight = SCREEN_HEIGHT - self.headerHeight - TABBAR_HEIGHT * 2 - NAVBAR_HEIGHT;
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.headerHeight + NAVBAR_HEIGHT +TABBAR_HEIGHT, SCREEN_WIDTH, self.scrollViewHeight - 1)];
    self.scrollView.backgroundColor = LJregular(0.7, 0.7, 0.7, 0.4);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
//    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 2, self.scrollViewHeight);
    self.scrollView.contentOffset = CGPointMake(0, 0);
    self.scrollView.delegate = self;
    [self.scrollView scrollRectToVisible:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, self.scrollViewHeight) animated:NO];
    [self.view addSubview:self.scrollView];
}

- (void)setupMyDishCollectionView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 2;
    flowLayout.minimumInteritemSpacing = 5;
    flowLayout.itemSize = CGSizeMake((SCREEN_WIDTH - 5 * 2) / 3, (SCREEN_WIDTH - 5 * 2) / 3);
    self.myDishCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    self.myDishCollectionView.backgroundColor = Color_BackGround;
    self.myDishCollectionView.delegate = self;
    self.myDishCollectionView.dataSource = self;
    self.myDishCollectionView.contentSize = self.view.bounds.size;
    self.myDishCollectionView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.myDishCollectionView];
    [self.scrollView addSubview:self.myDishCollectionView];
    
    [self.myDishCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:mydishIdentifier];
}

- (void)setupMyRecipeView {
    UIView *myRecipe = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, self.scrollViewHeight)];
    myRecipe.backgroundColor = Color_BackGround;
    UIButton *signButton = [UIButton buttonWithTitle:@"上传我的菜谱"
                                          titleColor:Color_TintWhite
                                     backgroundColor:[UIColor clearColor]
                                            fontSize:15
                                              target:self
                                              action:@selector(signIn)];
    signButton.frame = CGRectMake(SCREEN_WIDTH / 2 - 50, 100, 100, 50);
    [signButton setBackgroundImage:[UIImage imageNamed:@"exit_Button"] forState:UIControlStateNormal];
    [myRecipe addSubview:signButton];
    [self.scrollView addSubview:myRecipe];
}


#pragma mark - 数据处理 
- (void)loadNewData {
    [LJKNetworkTool afnGet:LJKAuthorDish
                    params:nil
                   success:^(id json) {
                       
                       self.authorDishArray = [LJKDish mj_objectArrayWithKeyValuesArray:json[@"content"][@"dishes"]];
                       [self.myDishCollectionView reloadData];
                       
    } failure:^(NSError *error) {
                        NSLog(@"加载失败,原因: %@", error);
        
    }];
}


#pragma mark - 点击事件
// 跳转至 “寻找厨友”
- (void)findFriend {
    LJKFindFriendViewController *findFriend = [[LJKFindFriendViewController alloc] init];
    [self.navigationController pushViewController:findFriend animated:YES];
    
}

// 跳转至 “设置”
- (void)setting {
    LJKSettingViewController *setting = [[LJKSettingViewController alloc] init];
    [self.navigationController pushViewController:setting animated:YES];
}

- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    
    if (segmentedControl.selectedSegmentIndex == 0) {
         NSLog(@"来到我的作品——————");
        self.scrollView.contentOffset = CGPointMake(0, 0);
    } else {
         NSLog(@"来到我的菜谱——————");
        self.scrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
    }
}

- (void)signIn {
     NSLog(@"即将跳转至登陆界面——————");
}

#pragma mark - collectionView 数据源 代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSLog(@"%zd", self.authorDishArray.count);
    return self.authorDishArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:mydishIdentifier
                                                                           forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    NSInteger tag = 555;
    UIImageView *imageView = [cell viewWithTag:tag];
    if (!imageView) {
        imageView = [[UIImageView alloc] init];
        imageView.frame = cell.contentView.bounds;
        imageView.tag = tag;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [cell.contentView addSubview:imageView];
    }
    NSString *imageURL = [self.authorDishArray[indexPath.item] thumbnail_160];
    [imageView sd_setImageWithURL:[NSURL URLWithString:imageURL]];
    
    return cell;
}


@end
