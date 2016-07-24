//
//  LJKRecommendBuyCell.m
//  LJKitchen
//
//  Created by  a on 16/7/16.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKRecommendBuyCell.h"
#import "LJKRecommendItem.h"

#import <Masonry.h>

@interface LJKRecommendBuyCell () <UICollectionViewDelegate,UICollectionViewDataSource>
/** 推荐购买 - 标题 */
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation LJKRecommendBuyCell

static NSString *const recommendBuyIdentifier = @"recommendBuyItem";

#pragma mark - 懒加载
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        CGFloat itemWH = (SCREEN_WIDTH - 20 * 4) / 3;
        flowLayout.itemSize = CGSizeMake(itemWH, itemWH + 70);
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                             collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = Color_BackGround;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.bounces = NO;
        [_collectionView registerClass:[LJKRecommendItem class]
            forCellWithReuseIdentifier:recommendBuyIdentifier];
    }
    return _collectionView;
}

#pragma mark - 构造方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = Color_BackGround;
        
        _titleLabel = [UILabel labelWithTextColor:Color_TintBlack
                                  backgroundColor:Color_Clear
                                         fontSize:15
                                            lines:1
                                    textAlignment:NSTextAlignmentCenter];
        _titleLabel.text = @"大家都在买";
        [self.contentView addSubview:_titleLabel];
        [self.contentView addSubview:self.collectionView];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.top.equalTo(self.contentView.mas_top).offset(20);
            make.height.equalTo(@(20));
        }];
        
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, (SCREEN_WIDTH - 20 * 4) / 3 + 80));
            make.left.equalTo(self.contentView.mas_left);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
        }];
        
        // TODO: PageControl 未添加
    }
    return self;
}

#pragma mark - CollectionView 数据源 & 代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 12;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LJKRecommendItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:recommendBuyIdentifier forIndexPath:indexPath];
    cell.layer.cornerRadius = 5;
    NSArray *imageArray = @[@"loveFresh",@"newPromotion",@"samSummer",@"loveToTry",@"JD_YouXuan",@"marketNewGoods",@"loveFresh",@"newPromotion",@"samSummer",@"loveToTry",@"JD_YouXuan",@"marketNewGoods"];
    NSArray *titleArray = @[@"进口菲律宾芒果干特价优惠",@"北欧欧姆立式家用电器",@"山姆夏日尊享",@"SKG烤箱",@"北欧欧姆立式家用电器",@"市集上新",@"爱尝鲜",@"北欧欧姆立式家用电器",@"山姆夏日尊享",@"北欧欧姆立式家用电器",@"京东优选馆",@"北欧欧姆立式家用电器"];
    NSArray *priceArray = @[@"11.5",@"65",@"189",@"58.8",@"199",@"266",@"233",@"233",@"100",@"899",@"1000",@"123",];
    
    cell.mainImage.image = [UIImage imageNamed:imageArray[indexPath.row]];
    cell.goodsNameLabel.text = titleArray[indexPath.row];
    cell.priceLabel.text = [NSString stringWithFormat:@"￥ %@",priceArray[indexPath.row]];
    return cell;
}

#pragma mark - 点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    !self.collectionDidClickedBlock ? : self.collectionDidClickedBlock(indexPath.item);
}

@end
