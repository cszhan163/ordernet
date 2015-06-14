//
//  OrderListItemCell.m
//  MobileOrder
//
//  Created by cszhan on 15-6-13.
//  Copyright (c) 2015年 com.ximalaya. All rights reserved.
//

#import "OrderListItemCell.h"
#import "GoodsCatagoryItem.h"

@interface OrderListItemCell()

@property (nonatomic, strong) SubCatagoryItem *item;

@end

@implementation OrderListItemCell


- (void)awakeFromNib {

    
}

- (void)setCellItem:(SubCatagoryItem*)item {
    
    self.item = item;
    [self layoutIfNeeded];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSString *titleName = _item.name;
    if(self.foodName && ![self.foodName isEqualToString:@""]) {
        titleName = [NSString stringWithFormat:@"%@+%@",self.foodName,_item.name];
    }
    //titleName= @"很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长";
    self.textLabel.text =titleName;
    self.textLabel.frame = CGRectMake(0.f, 0.f,self.frame.size.width/2.f, 40);
    _numberLabel.text = [NSString stringWithFormat:@"%ld",_item.number];
    _priceLabel.text =  [NSString stringWithFormat:@"¥ %0.2lf 元",_item.price];
    //self.imageView.frame = CGRectOffset(self.imageView.frame, 6, 0);
    //self.textLabel.frame = CGRectOffset(self.textLabel.frame, 6, 0);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}



@end
