//
//  UICarTableViewCell.h
//  BodCarManger
//
//  Created by cszhan on 13-12-19.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICarTableViewCell : UITableViewCell{
    CGFloat inset;
    CGFloat insetY;
}
@property (nonatomic, assign) BOOL isPendingX;
@property (nonatomic, assign) BOOL isPendingY;
- (void)setPendingX:(CGFloat)pendingx;
- (void)setPendingY:(CGFloat)pendingy;
@end
