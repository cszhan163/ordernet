//
//  OrderListItemCell.h
//  MobileOrder
//
//  Created by cszhan on 15-6-13.
//  Copyright (c) 2015年 com.ximalaya. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FoodSubItemCell.h"

@interface OrderListItemCell : UIBaseTableViewCell

@property(nonatomic,strong)IBOutlet UILabel *foodNameLabel;
@property(nonatomic,strong)IBOutlet UILabel *numberLabel;
@property(nonatomic,strong)IBOutlet UILabel *priceLabel;

@property (nonatomic, strong) NSString *foodName;

@property (nonatomic, strong) SubCatagoryItem *item;


- (void)setCellItem:(SubCatagoryItem*)item;

@end
