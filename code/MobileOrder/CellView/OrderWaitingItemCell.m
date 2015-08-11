//
//  OrderWaitingItemCell.m
//  MobileOrder
//
//  Created by cszhan on 15-7-26.
//  Copyright (c) 2015年 com.ximalaya. All rights reserved.
//

#import "OrderWaitingItemCell.h"

@implementation OrderWaitingItemCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.numberLabel.text = [NSString stringWithFormat:@"%ld",self.item.queueNum];
    //self.priceLabel.text =  [NSString stringWithFormat:@"¥ %0.2lf 元",_item.price+_item.basePrice];
    self.priceLabel.text =  [NSString stringWithFormat:@"%ld",self.item.number];
    //self.imageView.frame = CGRectOffset(self.imageView.frame, 6, 0);
    //self.textLabel.frame = CGRectOffset(self.textLabel.frame, 6, 0);
}

@end
