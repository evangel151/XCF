//
//  LJKSendMailViewController.m
//  LJKitchen
//
//  Created by  a on 16/6/9.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKSendMailViewController.h"
#import "LJKSearchBar.h"


@implementation LJKSendMailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LJKSearchBar *searchBar = [LJKSearchBar searchBarWithPlaceholder:@"搜厨友"];
    self.navigationItem.titleView = searchBar;
//    WeakSelf;
    searchBar.searchBarShouldBeginEditingBlock = ^{

    };

}

@end
