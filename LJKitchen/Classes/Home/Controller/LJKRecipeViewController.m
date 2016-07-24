//
//  LJKRecipeViewController.m
//  LJKitchen
//
//  Created by  a on 16/7/6.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  Done

#import "LJKRecipeViewController.h"
#import "LJKBasketController.h"             // 菜篮子
#import "LJKFeedsViewController.h"          // 关注动态
#import "LJKDishViewController.h"           // 菜谱推介
#import "LJKReportViewController.h"         // 举报 (举报控制器)

#import "LJKRecipeIngredientCell.h"         // 用料
#import "LJKRecipeInstructionCell.h"        // 步骤
#import "LJKRecipeTipsCell.h"               // 小贴士
#import "LJKRecipeAddToListCell.h"          // 加入菜单 (已加入)
#import "LJKRecipeDishShowCell.h"           // 作品展示

#import "LJKRecipeSupplementaryFooter.h"    // 菜谱追加描述
#import "LJKRecipeAddListFooter.h"          // 加入菜单 (action)
#import "LJKRecipeViewHeader.h"             // header

#import "LJKDish.h"
#import "LJKRecipe.h"
#import "LJKRecipeList.h"
#import "LJKRecipeIngredient.h"
#import "LJKRecipeInstruction.h"


#import "LJKNetworkTool.h"
#import <MJRefresh.h>
#import <MJExtension.h>

@interface LJKRecipeViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) LJKRecipeViewHeader *header;

@property (nonatomic, strong) LJKRecipe *recipe;
@property (nonatomic, strong) NSMutableArray *dishArray;
@property (nonatomic, strong) NSMutableArray *recipeListArray;
@property (nonatomic, strong) NSMutableArray *title_sections;
@property (nonatomic, strong) NSArray <UIBarButtonItem *>  *naviButtonsArray;
@end

@implementation LJKRecipeViewController

static NSString *const recipeHeaderIdentifier        = @"RecipeHeader";     // Header
static NSString *const recipeFooterSupplyIdentifier  = @"SupplyFooter";     // Footer (追加描述)
static NSString *const recipeFooterAddListIdentifier = @"AddListFooter";    // Footer (加入菜单)

static NSString *const recipeIngredientIdentifier    = @"IngredientCell";   // 用料
static NSString *const recipeInstructionIdentifier   = @"InstructionCell";  // 步骤
static NSString *const recipeTipsIdentifier          = @"TipsCell";         // 小贴士
static NSString *const recipeAddToListIdentifier     = @"AddListCell";      // 被加入的菜单
static NSString *const recipeDishShowIdentifier      = @"DishShowCell";     // 作品展示

#pragma mark - 懒加载
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.bounces = NO;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSMutableArray *)dishArray {
    if (!_dishArray) {
        _dishArray = [NSMutableArray array];
    }
    return _dishArray;
}

- (NSMutableArray *)recipeListArray {
    if (!_recipeListArray) {
        _recipeListArray = [NSMutableArray array];
    }
    return _recipeListArray;
}

- (NSMutableArray *)title_sections {
    if (!_title_sections) {
        _title_sections = [NSMutableArray arrayWithObjects:@"用料",@"做法",@"小贴士",@"被加入的菜单",@"", nil];
    }
    return _title_sections;
}

#pragma mark - 页面主体
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
    [self setupTableView];
    [self setupTableViewHeader];
    [self loadNewData];

}

- (void)setupNavigationBar {
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"buylistButtonImage"]
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(buyListButtonDidClicked)];
    
    /*
     * runtime 向分类中添加属性(block回调)失败，换了最笨的方法……
     * 这大概就是所谓的隔着屏幕散发出恶臭的代码吧……😓
     */
     
    self.naviButtonsArray = [UIBarButtonItem createShareButtonsWith:self
                                                             target:self
                                                  firstButtonAction:@selector(backButtonDidClicked)
                                                 secondButtonAction:@selector(PYQButtonDidClicked)
                                                  thirdButtonAction:@selector(WeChatButtonDidClicked)
                                                 fourthButtonAction:@selector(OtherButtonDidClicked)];
    self.navigationItem.leftBarButtonItems = self.naviButtonsArray;
    
    /*
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@""
                                                               style:UIBarButtonItemStylePlain
                                                              target:self
                                                              action:@selector(backButtonDidClicked)];
    back.image = [UIImage imageNamed:@"backStretchBackgroundNormal"];

    
    UIBarButtonItem *sharePYQ = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                 style:UIBarButtonItemStylePlain
                                                                target:self
                                                                action:@selector(PYQButtonDidClicked)];
    sharePYQ.image = [UIImage imageNamed:@"convenient_share_pyq"];
    sharePYQ.tintColor = Color_DarkGray;
    UIBarButtonItem *shareWX = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                style:UIBarButtonItemStylePlain
                                                               target:self
                                                               action:@selector(WeChatButtonDidClicked)];
    shareWX.image = [UIImage imageNamed:@"convenient_share_wx"];
    shareWX.tintColor = Color_DarkGray;
    UIBarButtonItem *shareOther = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(OtherButtonDidClicked)];
    shareOther.image = [UIImage imageNamed:@"share_other"];
    shareOther.tintColor = Color_DarkGray;
    */

}

- (void)setupTableView {
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = Color_BackGround;
    
    // Header(主体)
    [self.tableView registerClass:[UITableViewHeaderFooterView  class]
forHeaderFooterViewReuseIdentifier:recipeHeaderIdentifier];
    // Footer(追加描述 - 留言/同好/举报)
    [self.tableView registerClass:[LJKRecipeSupplementaryFooter class]
forHeaderFooterViewReuseIdentifier:recipeFooterSupplyIdentifier];
    // Footer(加入菜单 )
    [self.tableView registerClass:[LJKRecipeAddListFooter class]
forHeaderFooterViewReuseIdentifier:recipeFooterAddListIdentifier];
    
    // 用料
    [self.tableView registerClass:[LJKRecipeIngredientCell class]
           forCellReuseIdentifier:recipeIngredientIdentifier];
    // 步骤
    [self.tableView registerClass:[LJKRecipeInstructionCell class]
           forCellReuseIdentifier:recipeInstructionIdentifier];
    // 小贴士
    [self.tableView registerClass:[LJKRecipeTipsCell class]
           forCellReuseIdentifier:recipeTipsIdentifier];
    // 被加入的菜单
    [self.tableView registerClass:[LJKRecipeAddToListCell class]
           forCellReuseIdentifier:recipeAddToListIdentifier];
    // 作品展示
    [self.tableView registerClass:[LJKRecipeDishShowCell class]
           forCellReuseIdentifier:recipeDishShowIdentifier];
    
}

- (void)setupTableViewHeader {
    [self loadHeaderData];
}

#pragma mark - 数据处理
- (void)loadHeaderData {
    [LJKNetworkTool afnGet:LJKRequestKitchenRecipe
                    params:nil
                   success:^(id json) {
                       self.recipe = [LJKRecipe mj_objectWithKeyValues:json[@"content"][@"recipe"]];
                       self.header = [[LJKRecipeViewHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.recipe.headerHeight)];
                       self.header.recipe = self.recipe;
                       self.tableView.tableHeaderView = self.header;
                       
                       WeakSelf;
                       self.header.clickedBlock = ^(NSInteger HeaderDidClickedAction) {
                           switch (HeaderDidClickedAction) {
                               case RecipeHeaderActionAuthorIconClicked:{
                                   [UILabel showMessage:@"Header - 作者头像点击回调"
                                        atNavController:weakSelf.navigationController];
                                   [weakSelf pushWebViewWithUrl:LJKRequestKitchenAuthorPage];
                                   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                       [UILabel showMessage:@"跳转至用户界面(web)"
                                            atNavController:weakSelf.navigationController];
                                   });
                                   break;
                               }
                               case RecipeHeaderActionCollectedButtonClicked:{
                                   [UILabel showMessage:@"发送通知，收藏该菜谱"
                                        atNavController:weakSelf.navigationController];
                                   break;
                               }
                               case RecipeHeaderActionBasketButtonClicked:{
//                                   [UILabel showMessage:@"Header - Push至菜篮子界面"
//                                        atNavController:weakSelf.navigationController];
                                   [UILabel showMessage:@"发送通知，菜篮子储存该菜谱内食材"
                                        atNavController:weakSelf.navigationController];
//                                   [weakSelf.navigationController pushViewController:[[LJKBasketController alloc] init]
//                                                                            animated:YES];
                                   break;
                               }
                           }
                       };

                                                   
    } failure:^(NSError *error) {
                        NSLog(@"%@", error);
    }];
}


- (void)loadNewData {
    [LJKNetworkTool afnGet:LJKRequestKitchenRecipeDish
                    params:nil
                   success:^(id json) {
                       self.dishArray = [LJKDish mj_objectArrayWithKeyValuesArray:json[@"content"][@"dishes"]];
                       [self.tableView reloadData];
    } failure:^(NSError *error) {
                        NSLog(@"加载失败  原因:%@", error);
    }];
    
    [LJKNetworkTool afnGet:LJKRequestKitchenAddedRecipeList
                    params:nil
                   success:^(id json) {
                       self.recipeListArray = [LJKRecipeList mj_objectArrayWithKeyValuesArray:json[@"content"][@"recipe_lists"]];
                       [self.tableView reloadData];
    } failure:^(NSError *error) {
                        NSLog(@"加载失败  原因:%@", error);
    }];
}

#pragma mark - TableView 数据源 & 代理
#pragma mark Sections
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

#pragma mark Rows In Section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
    if (section == 0) {                         // 用料
        return self.recipe.ingredient.count;
    } else if (section == 1) {                  // 做法
        return self.recipe.instruction.count;
    } else if (section == 2) {                  // 小贴士
        if (!self.recipe.tips.length) {
            return 0;
        } else {
            return 1;
        }
    } else if (section == 3) {                  // 被加入的菜单
        return self.recipeListArray.count;
    } else if (section == 4) {                  // 作品
        return 1;
    }
    return 0;
}

#pragma mark Cell For Row
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    WeakSelf;
    if (indexPath.section == 0) {
        LJKRecipeIngredientCell *cell = [tableView dequeueReusableCellWithIdentifier:recipeIngredientIdentifier
                                                                        forIndexPath:indexPath];
        cell.ingredient = self.recipe.ingredient[indexPath.row];
        return cell;
    }
    // 做法
    else if (indexPath.section == 1) {
        LJKRecipeInstructionCell *cell = [tableView dequeueReusableCellWithIdentifier:recipeInstructionIdentifier
                                                                         forIndexPath:indexPath];
        cell.instruction = self.recipe.instruction[indexPath.row];
        return cell;
    }
    // 小贴士
    else if (indexPath.section == 2) {
        LJKRecipeTipsCell * cell = [tableView dequeueReusableCellWithIdentifier:recipeTipsIdentifier
                                                                   forIndexPath:indexPath];
        cell.recipe = self.recipe;
        return cell;
    }
    // 被加入的菜单
    else if (indexPath.section == 3) {

        LJKRecipeAddToListCell *cell = [tableView dequeueReusableCellWithIdentifier:recipeAddToListIdentifier
                                                                       forIndexPath:indexPath];
        cell.recipeList = self.recipeListArray[indexPath.row];

        return cell;
    }
    // 作品展示
    else if (indexPath.section == 4) {
        LJKRecipeDishShowCell *cell = [tableView dequeueReusableCellWithIdentifier:recipeDishShowIdentifier
                                                                      forIndexPath:indexPath];
        cell.recipe = self.recipe;
        cell.dishArray = self.dishArray;
        // 全部作品(button)
        cell.showAllBlock = ^(){
            [UILabel showMessage:@"全部作品" atNavController:weakSelf.navigationController];
            [weakSelf.navigationController pushViewController:[[LJKFeedsViewController alloc] init] animated:YES];
        };
        
        // 上传我的作品(View)
        cell.uploadMyDishBlock = ^() {
            [UILabel showMessage:@"跳转至上传作品" atNavController:weakSelf.navigationController];
        };
        
        // cell点击
        cell.collectionViewCellClickedBlock = ^(NSInteger index){
            [weakSelf.navigationController pushViewController:[[LJKDishViewController alloc] init] animated:YES];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [UILabel showMessage:@"模拟跳转至对应作品" atNavController:weakSelf.navigationController];
            });
        };
        
        // 点赞(button)
        cell.diggsButtonClickedBlock = ^(UIButton *sender){
            [UILabel showMessage:@"点赞 -> 发送请求 -> 刷新TableView" atNavController:weakSelf.navigationController];
//            NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:4];
//            [tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        };
        
        cell.authorIconDidClickedBlock = ^{
            [UILabel showMessage:@"头像跳转" atNavController:weakSelf.navigationController];
            [weakSelf pushWebViewWithUrl:LJKRequestKitchenAuthorPage];
        };
        
        // 刷新
        cell.refreshBlock = ^{
            [LJKNetworkTool afnGet:LJKRequestKitchenRecipeDish
                            params:nil
                           success:^(id json) {
                               NSArray *newDish = [LJKDish mj_objectArrayWithKeyValuesArray:json[@"content"][@"dishes"]];
                               [self.dishArray addObjectsFromArray:newDish];
                               [self.tableView reloadData];
            } failure:^(NSError *error) {
                                NSLog(@"加载失败  原因:%@", error);
            }];
        };
        return cell;
    }

    return nil;
}

#pragma mark Cell's Height For Row
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 用料
    if (indexPath.section == 0) {
        return [self.recipe.ingredient[indexPath.row] cellHeight];
    }
    // 做法
    else if (indexPath.section == 1) {
        return [self.recipe.instruction[indexPath.row] cellHeight];
    }
     // 小贴士
    else if (indexPath.section == 2) {

        if (!self.recipe.tips.length) { // 存在小贴士
            return 0;
        } else {                        // None
            return self.recipe.tipsHeight;
        }
    }
    // 被加入的菜单
    else if (indexPath.section == 3) {
        
        if (self.recipeListArray.count) {
            return 80;
        } else {
            return 0;
        }
        
    }
    // 作品
    else if (indexPath.section == 4) {
        // 155 == 作品数LabelHeight + 所有作品ButtonHeight + MarginSum 
        return self.dishArray.count ? (SCREEN_HEIGHT * 0.5 + 25) + 155 : 0;
    }
    
    return 0;
}

#pragma mark HeaderFooterView In different Section
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    // "小贴士"Footer (菜谱的追加描述 留言 / 同好 / 举报)
    WeakSelf;
    if (section == 2) {
        LJKRecipeSupplementaryFooter *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:recipeFooterSupplyIdentifier];

        footer.recipe = self.recipe;
        footer.frame = CGRectMake(0, 0, SCREEN_WIDTH, 150);

        footer.footerActionBlock = ^(SupplementaryFooterAction action) {
            switch (action) {
                case SupplementaryFooterActionComment: {   // 跳转至所有留言
                    [UILabel showMessage:@"跳转至所有留言" atNavController:weakSelf.navigationController];
                    break;
                }
                case SupplementaryFooterActionSameHobby: { // 跳转至“做过这道菜的还做过”
                    [UILabel showMessage:@"跳转至同类菜谱" atNavController:weakSelf.navigationController];
                    break;
                }
                case SupplementaryFooterActionReport: {    // 举报界面
                    [weakSelf.navigationController pushViewController:[[LJKReportViewController alloc] init]
                                                             animated:YES];
                    [UILabel showMessage:@"Push至举报作品界面"
                         atNavController:weakSelf.navigationController];
                    break;
                }
            }
        };
        
        return footer;
    }
    // 被加入的菜单 Footer
    else if (section == 3) {
        LJKRecipeAddListFooter *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:recipeFooterAddListIdentifier];

        footer.frame = CGRectMake(0, 0, SCREEN_WIDTH, 130);
        // 将本菜谱加入菜单
        footer.footerActionBlock = ^(){
            [UILabel showMessage:@"点击了“加入菜单”按钮"
                 atNavController:weakSelf.navigationController];
        };
        // 跳转至推广的webView
        footer.footerSpreadBlock = ^(){
//            [UILabel showMessage:@"push至商品界面" atNavController:weakSelf.navigationController];
            [weakSelf pushWebViewWithUrl:LJKRequestKitchenSpread];
        };
        
        return footer;
    }
    
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:recipeHeaderIdentifier];
    headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
    headerView.contentView.backgroundColor = [UIColor whiteColor];
    NSInteger tag = 30;
    UILabel *label = [headerView.contentView viewWithTag:tag];
    if (label == nil) {
        label = [[UILabel alloc] init];
        label.tag = tag;
        label.font = [UIFont systemFontOfSize:20];
        label.frame = CGRectMake(15, 15, SCREEN_WIDTH, 40);
        [headerView.contentView addSubview:label];
    }
    label.textAlignment = NSTextAlignmentCenter;
    label.text = self.title_sections[section];
    return headerView;
}

#pragma mark Header'height In different Section
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if ((section == 2 && self.recipe.tips.length == 0) || section == 4) {
        return 0;
    }
    return 50;
}

#pragma mark Footer'height In different Section
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 2) {
        return 150;
    } else if (section == 3) {
        return 130;
    }
    return 0;
}


#pragma mark - 点击事件 
- (void)buyListButtonDidClicked {
    [UILabel showMessage:@"点击了菜篮子" atNavController:self.navigationController];
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

- (void)showReportSuccessHUD {
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD showWithStatus:@"LJKitchen已经收到您的举报，我们会对作品信息进行核查，感谢您对LJKitchen一直以来的支持"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

@end
