//
//  LJKRecipeDishShowCell.m
//  LJKitchen
//
//  Created by  a on 16/7/10.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  Done 

#import "LJKRecipeDishShowCell.h"
#import "LJKDishCell.h"

#import "LJKDish.h"
#import "LJKRecipe.h"
#import "LJKRecipeStats.h"
#import "LJKGoods.h"

#import <Masonry.h>

@interface LJKRecipeDishShowCell () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
/** 作品展示 - 作品数量 */
@property (nonatomic, strong) UILabel *dishCountLabel;
/** 作品展示 - 所有作品 */
@property (nonatomic, strong) UIButton *allDishButton;
/** 作品展示 - 上传我的作品(容器) */
@property (nonatomic, strong) UIView *uploadMyDishView;
/** 作品展示 - 上传我的作品(相机图标组件) */
@property (nonatomic, strong) UIImageView *camera;
/** 作品展示 - 上传我的作品(文字说明组件) */
@property (nonatomic, strong) UILabel *uploadLabel;
/** 作品展示 - CollectionView */
@property (nonatomic, strong) UICollectionView *collectionView;

// 自定义刷新/跳转
/** 是否刷新 */
@property (nonatomic, assign) BOOL readyToRefresh;
/** 是否跳转 */
@property (nonatomic, assign) BOOL readyToPush;

@end

@implementation LJKRecipeDishShowCell

// collection ID
static NSString *const dishCellIdentifier = @"DishCell";

#pragma mark - 懒加载
- (UILabel *)dishCountLabel {
    if (!_dishCountLabel) {
        _dishCountLabel = [UILabel labelWithTextColor:Color_TintBlack
                                      backgroundColor:Color_Clear
                                             fontSize:20
                                                lines:1
                                        textAlignment:NSTextAlignmentCenter];
    }
    return _dishCountLabel;
}


- (UIButton *)allDishButton {
    if (!_allDishButton) {
        _allDishButton = [UIButton buttonWithTitle:@"所有作品"
                                        titleColor:Color_TintWhite
                                   backgroundColor:Color_Clear
                                          fontSize:17
                                            target:self
                                            action:@selector(allDishButtonDidClick)];
        [_allDishButton setBackgroundImage:[UIImage imageNamed:@"exit_Button"]
                                  forState:UIControlStateNormal];

    }
    return _allDishButton;
}


- (UIView *)uploadMyDishView {
    if (!_uploadMyDishView) {
        _uploadMyDishView = [[UIView alloc] init];
        _uploadMyDishView.backgroundColor = Color_ThemeColor_Alpha;
        UITapGestureRecognizer *tapUpload = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(uploadMyDishViewDidClicked)];
        [_uploadMyDishView addGestureRecognizer:tapUpload];
    }
    return _uploadMyDishView;
}

- (UIImageView *)camera {
    if (!_camera) {
        _camera = [[UIImageView alloc] init];
        _camera.image = [UIImage imageNamed:@"camera"];
    }
    return _camera;
}


- (UILabel *)uploadLabel {
    if (!_uploadLabel) {
        _uploadLabel = [UILabel labelWithTextColor:Color_TintWhite
                                   backgroundColor:Color_Clear
                                          fontSize:15
                                             lines:1
                                     textAlignment:NSTextAlignmentLeft];
        _uploadLabel.text = @"上传我做的这道菜";
    }
    return _uploadLabel;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH * 0.6 , (SCREEN_HEIGHT * 0.5 + 25));
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                             collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = Color_BackGround;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[LJKDishCell class]
            forCellWithReuseIdentifier:dishCellIdentifier];
    }
    return _collectionView;
}

#pragma mark - 构造方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = Color_BackGround;
        
        [self.contentView addSubview:self.dishCountLabel];
        [self.contentView addSubview:self.allDishButton];
        [self.contentView addSubview:self.uploadMyDishView];
        [self.uploadMyDishView addSubview:self.camera];
        [self.uploadMyDishView addSubview:self.uploadLabel];
        [self.contentView addSubview:self.collectionView];
        
        [_dishCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.top.equalTo(self.contentView.mas_top).offset(LJKAuthorIcon2CellTop);
            make.height.equalTo(@(LJKDiggsButtonWH));
        }];
        
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, (SCREEN_HEIGHT * 0.5 + 25)));
            make.top.equalTo(self.dishCountLabel.mas_bottom).offset(LJKAuthorIcon2CellTop);
            make.left.equalTo(self.contentView.mas_left);
        }];
        
        [_uploadMyDishView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, TABBAR_HEIGHT));
            make.centerX.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView.mas_bottom);
        }];
        
        [_allDishButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(100, 30));
            make.centerX.equalTo(self.contentView);
            make.bottom.equalTo(self.uploadMyDishView.mas_top).offset(-LJKAuthorIcon2CellTop * 2 );
        }];
        
        [_camera mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(25, 25));
            make.centerY.equalTo(self.uploadMyDishView.mas_centerY);
            make.right.equalTo(self.uploadLabel.mas_left).offset(-10);
        }];
        
        [_uploadLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.uploadMyDishView.mas_centerY);
            make.right.equalTo(self.contentView.mas_right);
            make.left.equalTo(self.uploadMyDishView.mas_centerX).offset(-60);
            make.height.equalTo(@(30));
        }];
    }
    return self;
}

#pragma mark - 传入模型
- (void)setRecipe:(LJKRecipe *)recipe {
    _recipe = recipe;
    self.dishCountLabel.text = [NSString stringWithFormat:@"%@个作品", recipe.stats.n_dishes];
}

- (void)setGoods:(LJKGoods *)goods {
    _goods = goods;
    self.uploadMyDishView.hidden = YES;
    // 直接隐藏，不用更新布局了
//    [_allDishButton mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.contentView.mas_bottom).offset(-20);
//    }];
    
    [_allDishButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 30));
        make.centerX.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-20);
    }];
    [self.allDishButton setTitle:@"查看评价" forState:UIControlStateNormal];
    self.dishCountLabel.text = [NSString stringWithFormat:@"%@个评价",goods.n_reviews];
     [self.collectionView reloadData]; // 接收到数据后刷新列表
}

// 接收到数据后刷新列表
- (void)setDishArray:(NSMutableArray *)dishArray {
    _dishArray = dishArray;
    [self.collectionView reloadData];
}

#pragma mark - CollectionView 数据源 & 代理 
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    if (self.type == LJKVerticalCellTypeDish) {
        return self.dishArray.count;
    } else if (self.type == LJKVerticalCellTypeReview) {
        return self.goods.reviews.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LJKDishCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:dishCellIdentifier
                                                                  forIndexPath:indexPath];
    cell.layer.cornerRadius = 5;
    cell.backgroundColor = Color_TintWhite;
    if (self.type == LJKVerticalCellTypeDish) {
        if (self.dishArray.count) {
            cell.dish = self.dishArray[indexPath.item];
        }
        cell.diggsButtonClickedBlock = self.diggsButtonClickedBlock;
        cell.authorIconClickedBlock = self.authorIconDidClickedBlock;
    } else if (self.type == LJKVerticalCellTypeReview) {
        cell.review = self.goods.reviews[indexPath.row];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    !self.collectionViewCellClickedBlock ? : self.collectionViewCellClickedBlock(indexPath.row);
}

#pragma mark - scrollView 代理 & 逻辑
/**
 *  CollectionView 滚动刷新(判断)
 *
 *  @param scrollView 根据scrollView的contentOffset.x 位置 (滚动视距) --> 对readyToRefresh readyToPush 赋值
 
 *  readyToRefresh: 拖拽最大距离大于collectionView.contentSize.width时 -> Ture -> 刷新
 *  readyToPush   : 拖拽最大距离大于4个评论CellWidth + MarginSum 时     -> Ture -> 刷新
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat itemWidth = SCREEN_WIDTH * 0.6; // 宽度
    CGFloat itemLineSpacing = 10;           // 间距
    if (self.type == LJKVerticalCellTypeDish) {
        CGFloat dishContentSizeWidth = ((itemWidth + itemLineSpacing) * self.dishArray.count) - 10 + 40;
        BOOL refresh = scrollView.contentOffset.x > dishContentSizeWidth - SCREEN_WIDTH + 50;
        self.readyToRefresh = refresh;
    } else if (self.type == LJKVerticalCellTypeReview) {

        CGFloat reviewContentSizeWidth = itemWidth * 4 + 30 + 40;
        self.readyToPush = (scrollView.contentOffset.x > reviewContentSizeWidth - SCREEN_WIDTH + 50);
    }
}

/** 松开的一瞬间调用block，刷新数据 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    // 作品刷新
    /***  refresh = (block可用) + (readyToRefresh == YES) + (拥有可供刷新添加的数据) */
    BOOL refresh = self.refreshBlock && self.readyToRefresh && self.dishArray.count < [self.recipe.stats.n_dishes integerValue];
    !(refresh) ? : self.refreshBlock();
    
    // 跳转至"全部评价"界面
    !(self.showAllBlock && self.readyToPush) ? : self.showAllBlock();
}


#pragma mark - 点击事件 
- (void)allDishButtonDidClick {
    !self.showAllBlock ? : self.showAllBlock();
}

- (void)uploadMyDishViewDidClicked {
    !self.uploadMyDishBlock ? : self.uploadMyDishBlock();
}



@end
