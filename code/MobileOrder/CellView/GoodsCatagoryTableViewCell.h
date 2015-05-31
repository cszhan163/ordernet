//
//  GoodsCatagoryTableViewCell.h
//  MobileOrder
//
//  Created by cszhan on 15-5-30.
//  Copyright (c) 2015年 com.ximalaya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsCatagoryTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel   *titleLable;


+ (CGFloat)getCellDefaultHeight;

+ (CGFloat)getCellHeightWithText:(NSString*)txt;

- (void)setCellHeight:(CGFloat)height;

- (void)setCellSelectedStatus:(BOOL)status;

@end
