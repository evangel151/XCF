//
//  LJKMarketHotThemeCell.m
//  LJKitchen
//
//  Created by  a on 16/7/15.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  市集 - 热门主题 Done

#import "LJKMarketHotThemeCell.h"
#import "LJKMarketHotItem.h"

#import <Masonry.h>

@interface LJKMarketHotThemeCell () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

/** 热门主题 - CollectionView */
@property (nonatomic, strong) UICollectionView *collectionView;
/** 热门主题 - 热门主题描述 */
@property (nonatomic, strong) UILabel *hotThemeTitle;

@end

@implementation LJKMarketHotThemeCell

static NSString *const hotThemeIdentifier = @"hotThemeCell";

#pragma mark - 懒加载
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        CGFloat itemWH = (SCREEN_WIDTH - 20 * 4) / 3;
        flowLayout.itemSize = CGSizeMake(itemWH, itemWH);
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                             collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = Color_BackGround;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.bounces = NO;
        [_collectionView registerClass:[LJKMarketHotItem class]
            forCellWithReuseIdentifier:hotThemeIdentifier];
    }
    return _collectionView;
}

#pragma mark - 构造方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _hotThemeTitle = [UILabel labelWithTextColor:Color_TintBlack
                                     backgroundColor:Color_Clear
                                            fontSize:15 lines:1
                                       textAlignment:NSTextAlignmentLeft];
        _hotThemeTitle.text = @"热门主题";
        [self.contentView addSubview:_hotThemeTitle];
        
        [self.contentView addSubview:self.collectionView];
        
        [_hotThemeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 40, 30));
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.top.equalTo(self.contentView.mas_top);
        }];
        
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, (SCREEN_WIDTH - 20 * 4) / 3 + 10));
            make.top.equalTo(self.hotThemeTitle.mas_bottom);
            make.left.equalTo(self.contentView.mas_left);
        }];
        
    }
    return self;
}

#pragma mark - CollectionView 数据源 & 代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LJKMarketHotItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:hotThemeIdentifier forIndexPath:indexPath];
    NSArray *imageArray = @[@"loveFresh",@"newPromotion",@"samSummer",@"loveToTry",@"JD_YouXuan",@"marketNewGoods",];
    NSArray *titleArray = @[@"爱尝鲜",@"你有新的优惠",@"山姆夏日尊享",@"爱试用",@"京东优选馆",@"市集上新"];
    
    cell.mainImage.image = [UIImage imageNamed:imageArray[indexPath.row]];
    cell.titleLabel.text = titleArray[indexPath.row];
    return cell;
}

#pragma mark - 点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    !self.collectionViewCellClickedBlock ? : self.collectionViewCellClickedBlock(indexPath.row);
}


@end
