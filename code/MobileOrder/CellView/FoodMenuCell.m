//
//  FoodMenuCell.m
//  MobileOrder
//
//  Created by cszhan on 15-6-11.
//  Copyright (c) 2015年 com.ximalaya. All rights reserved.
//

#import "FoodMenuCell.h"

@implementation FoodMenuCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.frame = CGRectMake(0.f, 0.f,kDeviceScreenWidth,50);
        
        CGFloat offsextX = 80.f;
        _addBtn.frame = CGRectOffset(_addBtn.frame,offsextX,0);
        _subBtn.frame = CGRectOffset(_subBtn.frame,offsextX,0);
        _numberLabel.frame = CGRectOffset(_numberLabel.frame,offsextX,0);
        _priceLabel.frame = CGRectOffset(_priceLabel.frame,offsextX,0);
        
    }
    return self;
}


@end
