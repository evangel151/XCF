//
//  UIImageView+Extension.m
//  LJKitchen
//
//  Created by  a on 16/6/20.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "UIImageView+Extension.h"
#import <UIImageView+WebCache.h>

@implementation UIImageView (Extension)

// ph == placeHolder;
- (void)setCircleIconWithUrl:(NSURL *)url
                 placeHolder:(NSString *)placeHolder
                  cornRadius:(CGFloat)cornRadius {
    

    UIImage *ph = [[UIImage imageNamed:placeHolder]
                   imageByRoundCornerRadius:cornRadius];
    [self sd_setImageWithURL:url
            placeholderImage:ph
                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            self.image = image ? [image imageByRoundCornerRadius:cornRadius] : ph;
                   }];
}

- (void)setNormalIconWithUrl:(NSURL *)url
                 placeHolder:(NSString *)placeHolder {
    
    UIImage *ph = [UIImage imageNamed:placeHolder];
    [self sd_setImageWithURL:url
            placeholderImage:ph
                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                       
                       self.image = image ? image : ph;
                   }];
}


@end
