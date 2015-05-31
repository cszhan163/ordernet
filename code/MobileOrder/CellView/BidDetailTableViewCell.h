//
//  CarCheckTableView.h
//  BodCarManger
//
//  Created by cszhan on 13-10-21.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import "BidDetailTableViewCell.h"
#import "ExcellLikeCellBase.h"
@interface BidDetailTableViewCell : ExcellLikeCellBase{

    CGFloat currCellHeight;
    CGFloat cellHeitht;
    CGFloat valueHeight;
    UILabel *headerLabel;
}
- (void)setHeaderLabelHiddenStatus:(BOOL)status;
- (void)setHeaderLabelText:(NSString*)text;
- (id)initWithFrame:(CGRect)frame withRowCount:(NSInteger) rowNum withColumCount:(NSInteger)colNum withColumWidthArray:(NSArray*)widthArray;
- (id)initWithIIFrame:(CGRect)frame withRowCount:(NSInteger) rowNum withColumCount:(NSInteger)colNum withCellHeight:(CGFloat)height withHeaderTitle:(NSString*)title;
- (id)initWithCustomFrame:(CGRect)frame withRowCount:(NSInteger) rowNum withColumCount:(NSInteger)colNum withCellHeight:(CGFloat)height withHeaderTitle:(NSString*)title;
- (id)initWithFrame:(CGRect)frame withRowCount:(NSInteger) rowNum withColumCount:(NSInteger)colNum withCellHeight:(CGFloat)height withHeaderTitle:(NSString*)title;
- (void)addColumWithKeyTitleArray:(NSArray*)titleArray withColumWidthArray:(NSArray*)widthArray;
- (void)addColumIIWithKeyTitleArray:(NSArray*)titleArray withColumWidthArray:(NSArray*)widthArray;
- (BOOL)setCellItemValue:(NSString*)value withRow:(NSInteger)row withCol:(NSInteger)col;
- (void)addColumWithKeyTitleArray:(NSArray*)titleArray withColumWidthArray:(NSArray*)widthArray withKeyTitleHeight:(CGFloat)keyHeight withValueHeight:(CGFloat)valueHeight;
@end
