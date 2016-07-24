//
//  LJKEditAuthorDescCell.h
//  LJKitchen
//
//  Created by  a on 16/7/1.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LJKEditAuthorDescCell : UITableViewCell

@property (nonatomic, copy) NSString *displayDescription;

@property (nonatomic, copy) void (^editingDescBlock)(NSString *);

@end
