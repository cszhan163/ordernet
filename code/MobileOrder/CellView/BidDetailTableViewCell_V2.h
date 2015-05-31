//
//  BidDetailTableViewCell_V2.h
//  BSTell
//
//  Created by cszhan on 14-2-19.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "LeftTitleListCell.h"

@interface BidDetailTableViewCell_V2 : LeftTitleListCell


- (id)initWithFrame:(CGRect)frame withHeaderTitle:(NSString *)title withTitleArray:(NSArray*)titleArray withTitleAttributeArray:(NSArray*)titleAtrArray withValueAttributeArray:(NSArray*)valueAtrArray withHeightArray:(NSArray*)heightArray;

- (void)setActionTarget:(id)actionTarget withSelecotr:(SEL)selector;
- (void)setBidButtonTitle:(NSString*)string;
- (void)setBidButtonTag:(int)tag;
- (void)setButtonDisableStatus:(BOOL)status;
- (void)setButtonHiddenStatus:(BOOL)status;
@end
