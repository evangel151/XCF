//
//  LJKSearchBar.m
//  LJKitchen
//
//  Created by  a on 16/6/11.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  Done 

#import "LJKSearchBar.h"

@interface LJKSearchBar () <UISearchBarDelegate>

@end

@implementation LJKSearchBar


+ (LJKSearchBar *)searchBarWithPlaceholder:(NSString *)placeholder {
    LJKSearchBar *searchBar = [[LJKSearchBar alloc] init];
    searchBar.delegate = searchBar;
    searchBar.placeholder = placeholder;
    searchBar.tintColor = Color_DarkGray;
    [searchBar setImage:[UIImage imageNamed:@"searchIcon"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    
    UIView *searchBarSub = searchBar.subviews[0];
    for (UIView *subView in searchBarSub.subviews) {
        
        if ([subView isKindOfClass:NSClassFromString(@"UISearchBarTextField")]) {
            [subView setBackgroundColor:Color_BackGround];
        }
        
        if ([subView isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            [subView removeFromSuperview];
        }
    }
    return searchBar;
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    !self.searchBarShouldBeginEditingBlock ? : self.searchBarShouldBeginEditingBlock();
    return YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    !self.searchBarTextDidChangedBlock ? : self.searchBarTextDidChangedBlock();
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    !self.searchBarDidSearchBlock ? : self.searchBarDidSearchBlock();
}
@end
