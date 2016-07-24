//
//  LJKReview.m
//  LJKitchen
//
//  Created by  a on 16/7/5.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKReview.h"
#import "LJKReviewPhoto.h"
#import "LJKComment.h"

@implementation LJKReview

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID" : @"id"};
}


+ (NSDictionary *)mj_objectClassInArray {
    return @{@"photos" : [LJKReviewPhoto class],
             @"additional_review_photos" : [LJKReviewPhoto class],
             @"lasted_comments" : [LJKComment class]};
}

- (CGFloat)buyCellHeight {
    
    // (垂直方向)姓名栏maxY == 458
    CGFloat dishNameLabelMaxY = 350 + 2 * LJKAuthorIcon2CellTop + 2 * TABBAR_HEIGHT;
    // (水平方向)间距sum == 104
    CGFloat totalMarginWidth = LJKAuthorIcon2CellLeft * 3 + 44;
    
    CGFloat totalMarginHeight =  TABBAR_HEIGHT;
    
    
    if (self.review.length) {
        CGFloat descHeight = [self.review boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - totalMarginWidth, MAXFLOAT)
                                                       options:NSStringDrawingUsesLineFragmentOrigin
                                                    attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]}
                                                       context:nil].size.height;
        
        _buyCellHeight = dishNameLabelMaxY + descHeight + totalMarginHeight;
    } else {
        _buyCellHeight = dishNameLabelMaxY + totalMarginHeight;
    }
    return _buyCellHeight;

}

@end
