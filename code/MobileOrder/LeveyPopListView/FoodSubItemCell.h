//
//  LeveyPopListViewCell.h
//  LeveyPopListViewDemo
//
//  Created by Levey on 2/21/12.
//  Copyright (c) 2012 Levey. All rights reserved.
//

#import "UIBaseTableViewCell.h"
#import "GoodsCatagoryItem.h"
@interface FoodSubItemCell : UIBaseTableViewCell {

    UILabel     *_foodNameLabel;
    UILabel     *_numberLabel;
    UILabel     *_priceLabel;
    UIButton    *_addBtn;
    UIButton    *_subBtn;
    
}


@property (nonatomic, strong) NSString *foodName;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withFrame:(CGRect)rect;

- (void)setCellItem:(SubCatagoryItem*)item;

@end
