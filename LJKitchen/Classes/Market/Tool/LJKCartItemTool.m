//
//  LJKCartItemTool.m
//  LJKitchen
//
//  Created by  a on 16/7/11.
//  Copyright © 2016年 ycdsq. All rights reserved.
//


#import "LJKCartItemTool.h"

#import "LJKCartItem.h"
#import "LJKGoods.h"
#import "LJKShop.h"

#import "LJKGoodsKind.h"

#import <MJExtension.h>

@implementation LJKCartItemTool

static NSMutableArray *_cartItems;

+ (void)update {
    [NSKeyedArchiver archiveRootObject:_cartItems toFile:LJKCartItemsPath];
    // 任何一个操作之后都发送通知，用处：购物车图标动画
    [NotificationCenter postNotificationName:LJKCartItemTotalNumberDidChangedNotification
                                      object:nil
                                    userInfo:@{@"goodsCount" : @([self totalNumber])}];
}


+ (NSArray *)totalItems {
    _cartItems = [NSKeyedUnarchiver unarchiveObjectWithFile:LJKCartItemsPath];
    if (!_cartItems.count) {
        _cartItems = [NSMutableArray array];
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]
                                                                         pathForResource:@"cart_items.plist"
                                                                         ofType:nil]];
        NSMutableArray *array = [LJKCartItem mj_objectArrayWithKeyValuesArray:dict[@"content"][@"cart_items"]];
        
        /** 将数据内相同店铺的商品分为一类 */
        NSMutableArray *totalShopArray = [NSMutableArray array]; // 总数组
        while (array.count) {
            NSMutableArray *shopArray = [NSMutableArray array]; // 一个店铺作为一个数组
            LJKCartItem *firstItem = array[0];
            NSString *firstShopName = firstItem.goods.shop.name;
            
            for (NSInteger index=0; index<array.count; index++) {
                LJKCartItem *item = array[index];
                if ([item.goods.shop.name isEqualToString:firstShopName]) { // 如果商品店铺名字相同，就加到一个数组内
                    [shopArray addObject:item];
                    [array removeObjectAtIndex:index]; // 删除总数组中对应的商品
                    index--;
                }
            }
            [totalShopArray addObject:shopArray];
        }
        _cartItems = totalShopArray;
    }
    return _cartItems;
}

+ (NSUInteger)totalNumber {
    NSUInteger totalNumber = 0;
    for (NSArray *shopArray in [self totalItems]) {
        for (LJKCartItem *item in shopArray) {
            totalNumber += item.number;
        }
    }
    return totalNumber;
}


/**********************添加**********************/

/**
 *  添加操作需要对进行商品三个层次判断
 *  1. 判断购物车内是否存在与商品相同的店铺
 *  2. 判断店铺内是否存在相同名称的商品
 *  3. 判断商品内是否存在相同的类型
 */

+ (void)addItem:(LJKCartItem *)item {
    if (!_cartItems.count) { // 如果数组为空，重新添加一个店铺数组，店铺数组里添加商品
        _cartItems = [NSMutableArray array];
        NSMutableArray *shopArray = [NSMutableArray array];
        [shopArray addObject:item];
        [_cartItems addObject:shopArray];
    } else {
        
        // 1.
        BOOL hasSameShop = NO; // 记录 新添加的商品 是否属于 已存在的店铺
        for (NSInteger index=0; index<_cartItems.count; index++) {
            NSMutableArray *shopArray = _cartItems[index];
            NSString *shopName = [[[shopArray[0] goods] shop] name];
            if ([item.goods.shop.name isEqualToString:shopName]) { // 根据商品店铺名添加到对应店铺数组内
                
                // 2.
                BOOL hasSameGoods = NO; // 记录是否存在相同的商品
                for (LJKCartItem *existItem in shopArray) {
                    if ([item.goods.name isEqualToString:existItem.goods.name]) { // 如果是同一类商品
                        
                        if ([item.kind_name isEqualToString:existItem.kind_name]) { // 如果是同一分类
                            existItem.number += item.number;
                            hasSameGoods = YES;
                            break;
                        }
                        
                    }
                }
                if (hasSameGoods == NO) [shopArray addObject:item]; // 如果不是同一类商品就加到店铺中
                
                [_cartItems replaceObjectAtIndex:index withObject:shopArray]; // 重新赋值到大数组
                hasSameShop = YES;
                break;
            }
        }
        if (hasSameShop == NO) { // 如果是新店铺的商品，就新建一个店铺数组
            NSMutableArray *newShopArray = [NSMutableArray array];
            [newShopArray addObject:item];
            [_cartItems addObject:newShopArray];
        }
    }
    [self update];
    
}

+ (LJKCartItem *)randomItem {
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]
                                                                     pathForResource:@"cart_items.plist"
                                                                     ofType:nil]];
    NSArray *dataArray = [LJKCartItem mj_objectArrayWithKeyValuesArray:dict[@"content"][@"cart_items"]];
    NSUInteger random = arc4random_uniform((unsigned int)dataArray.count);
    return dataArray[random];
}

+ (void)addItemRandomly:(void (^)(NSString *))itemNameCallback {
    LJKCartItem *item = [self randomItem];
    [LJKCartItemTool addItem:item];
    itemNameCallback(item.goods.name);
}


/**********************更新**********************/

+ (void)updateItemAtIndexPath:(NSIndexPath *)indexPath withItem:(LJKCartItem *)item {
    NSMutableArray *shopArray = _cartItems[indexPath.section];
    [shopArray replaceObjectAtIndex:indexPath.row withObject:item];
    [_cartItems replaceObjectAtIndex:indexPath.section withObject:shopArray];
    [self update];
}


+ (void)updateShopArrayAtIndex:(NSUInteger)index withShopArray:(NSArray<LJKCartItem *> *)array {
    [_cartItems replaceObjectAtIndex:index withObject:array];
    [self update];
}


+ (void)updateAllItemState:(LJKCartItemState)state {
    for (NSArray *shopArray in _cartItems) {
        for (LJKCartItem *item in shopArray) {
            item.state = state;
        }
    }
    [self update];
}


/**********************删除**********************/

+ (void)removeSelectedItem {
    for (NSInteger i=0; i<_cartItems.count; i++) {
        NSMutableArray *shopArray = _cartItems[i];
        for (NSInteger j=0; j<shopArray.count; j++) {
            LJKCartItem *item = shopArray[j];
            if (item.state == LJKCartItemStateSelected) { // 如果是选中状态就删除
                [shopArray removeObjectAtIndex:j];
                j--;
            }
        }
        if (!shopArray.count) { // 如果店铺无商品，就删除店铺数组
            [_cartItems removeObjectAtIndex:i];
            i--;
        }
    }
    [self update];
}

+ (void)removeItemByIndexPathArray:(NSArray<NSIndexPath *> *)array {
    for (NSIndexPath *indexPath in array) {
        NSMutableArray *shopArray = _cartItems[indexPath.section];
        [shopArray removeObjectAtIndex:indexPath.row];
        if (!shopArray.count) {
            [_cartItems removeObjectAtIndex:indexPath.section]; // 如果店铺数组内没有商品，就将店铺数组删除
        } else {
            [_cartItems replaceObjectAtIndex:indexPath.section withObject:shopArray];
        }
    }
    [self update];
}

+ (void)removeAllItem {
    [_cartItems removeAllObjects];
    [self update];
}



+ (void)resetItemState {
    [self updateAllItemState:LJKCartItemStateNone];
}

// 订单
+ (NSArray *)totalBuyItems {
    NSMutableArray *totalBuyItemsArray = [NSMutableArray array];
    for (NSArray *shopArray in _cartItems) {
        NSMutableArray *newShopArray = [NSMutableArray array];
        for (LJKCartItem *item in shopArray) {
            if (item.state == LJKCartItemStateSelected) [newShopArray addObject:item];
        }
        if (newShopArray.count) [totalBuyItemsArray addObject:newShopArray];
    }
    return totalBuyItemsArray;
}

+ (NSArray *)buyItem:(LJKCartItem *)item {
    // 设置状态为选中，即：说明此商品需要购买
    item.state = LJKCartItemStateSelected;
    NSMutableArray *totalBuyItemsArray = [NSMutableArray array];
    NSMutableArray *newShopArray = [NSMutableArray array];
    [newShopArray addObject:item];
    [totalBuyItemsArray addObject:newShopArray];
    return totalBuyItemsArray;
}


@end
