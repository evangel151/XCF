//
//  LJKMarketNewArrivalCell.h
//  LJKitchen
//
//  Created by  a on 16/7/15.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  市集 - 新品上架 (V)

#import <UIKit/UIKit.h>

@interface LJKMarketNewArrivalCell : UITableViewCell
/** CollectionViewCellClickedBlock */
@property (nonatomic, copy) void (^collectionViewCellClickedBlock)(NSInteger index);
@end
