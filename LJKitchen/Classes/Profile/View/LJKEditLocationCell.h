//
//  LJKEditLocationCell.h
//  LJKitchen
//
//  Created by  a on 16/6/29.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LJKEditLocationCell : UITableViewCell

@property (nonatomic, copy) NSString *placeHolder;
@property (nonatomic, copy) NSString *displayLocation;
@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) void (^cancelEditingBlock)(NSString *);
@property (nonatomic, copy) void (^editingLocationBlock)(NSString *);

@end
