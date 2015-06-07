//
//  UIBaseTableViewCell.h
//  BodCarManger
//
//  Created by cszhan on 13-12-19.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol CellDelegate <NSObject>

- (void)cellDidClickOrderAddBtn:(id)sender  withNumber:(NSInteger)number;

- (void)cellDidClickOrderSubBtn:(id)sender  withNumber:(NSInteger)number;

@end


@interface UIBaseTableViewCell : UITableViewCell{
    CGFloat inset;
    CGFloat insetY;
}
@property (nonatomic, assign) BOOL isPendingX;
@property (nonatomic, assign) BOOL isPendingY;

@property (nonatomic, assign) id<CellDelegate> delegate;

- (void)setPendingX:(CGFloat)pendingx;
- (void)setPendingY:(CGFloat)pendingy;
@end
