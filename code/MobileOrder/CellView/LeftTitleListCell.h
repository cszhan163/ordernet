//
//  LeftTitleListCell.h
//  BSTell
//
//  Created by cszhan on 14-2-9.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "ExcellLikeCellBase.h"

@interface LeftTitleListCell : ExcellLikeCellBase{

    CGFloat currValueTextWidth;
    
    CGFloat currValueTextHeight;
}
@property (nonatomic, assign) CGFloat yItemPendingY;

@property (nonatomic, assign) CGFloat xStartLeftPendingX;

@property (nonatomic, strong) UILabel *headerLabel;

@property (nonatomic, assign) BOOL  haveHeader;

- (id)initWithFrame:(CGRect)frame withTitleArray:(NSArray*)titleArray withTitle:(NSString*)title withValueAtrArray:(NSArray*)valueArray withItemPending:(CGFloat)yItemPending;

- (id)initWithGoodsDetailFrame:(CGRect)frame withTitleArray:(NSArray*)titleArray withTitle:(NSString*)title  withValueAtrArray:(NSArray*)valueArray withItemPending:(CGFloat)yItemPending;

- (id)initWithFrame:(CGRect)frame withTitleArray:(NSArray*)titleArray withTitleAttributeArray:(NSArray*)titleAtrArray withValueAttributeArray:(NSArray*)valueAtrArray withHeightArray:(NSArray*)heightArray;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withTitleArray:(NSArray*)titleArray withTitleAttributeArray:(NSArray*)titleAtrArray withValueAttributeArray:(NSArray*)valueAtrArray withHeightArray:(NSArray*)heightArray;

- (id)initWithFrame:(CGRect)frame withTitleArray:(NSArray*)titleArray withTitle:(NSString*)title  withValueAtrArray:(NSArray*)valueArray withItemPending:(CGFloat)yItemPending withOrderCell:(BOOL)isOrder;

- (id)initWithFrame:(CGRect)frame withTitleArray:(NSArray*)titleArray withItemPendingArray:(NSArray*)itemArray;


- (void)initWithTitleArray:(NSArray*)titleArray withTitleAttributeArray:(NSArray*)titleAtrArray withValueAttributeArray:(NSArray*)valueAtrArray withHeightArray:(NSArray*)heightArray;

- (BOOL)setCellItemValue:(NSString*)value withRow:(NSInteger)row;

- (BOOL)setCellItemValue:(NSString*)value withRow:(NSInteger)row withCol:(NSInteger)col;

- (void)setValueColorByIndex:(NSInteger)index withColor:(UIColor*)color;

- (void)setTitleHidden:(BOOL)status withIndex:(int)index;

- (void)setTitleHidden:(BOOL)status withIndex:(int)index withAdjust:(BOOL)adjust;



@end

