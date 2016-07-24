//
//  LJKSearchBar.h
//  LJKitchen
//
//  Created by  a on 16/6/11.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  搜索栏 (V)

#import <UIKit/UIKit.h>

@interface LJKSearchBar : UISearchBar
@property (nonatomic, copy) void (^searchBarShouldBeginEditingBlock)(); // 点击回调
@property (nonatomic, copy) void (^searchBarTextDidChangedBlock)();     // 编辑回调
@property (nonatomic, copy) void (^searchBarDidSearchBlock)();          

+ (LJKSearchBar *)searchBarWithPlaceholder:(NSString *)placeholder;
@end
