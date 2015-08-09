//
//  FoodMenuCell.m
//  MobileOrder
//
//  Created by cszhan on 15-6-11.
//  Copyright (c) 2015年 com.ximalaya. All rights reserved.
//

#import "FoodMenuCell.h"


#define kPendingX 10
#define kPendingY 20

#define kButtonWidth  40.f

#define kFoodNameWidth  100.f

#define kPriceWidth      70.f

@implementation FoodMenuCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withFrame:(CGRect)rect
{
   
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier withFrame:rect];
    if (self) {
       
        CGFloat foodNameWidth = kFoodNameWidth;
        CGFloat priceWidth = kPriceWidth;
        if(kDeviceCheckIphone6) {
        
            foodNameWidth = kFoodNameWidth +50.f;
            priceWidth = kPriceWidth +20.f;
            CGSize  size = CGSizeMake(priceWidth, _priceLabel.frame.size.height);
            _priceLabel.frame = CGRectMake(_priceLabel.frame.origin.x, _priceLabel.frame.origin.y, size.width, size.height);
            size = CGSizeMake(foodNameWidth, _foodNameLabel.frame.size.height);
            _foodNameLabel.frame =  CGRectMake(_foodNameLabel.frame.origin.x, _foodNameLabel.frame.origin.y, size.width, size.height);
            
        }
         CGFloat offsextX = -10.f;
        _addBtn.frame = CGRectOffset(_addBtn.frame,offsextX,0);
        _subBtn.frame = CGRectOffset(_subBtn.frame,offsextX,0);
        _numberLabel.frame = CGRectOffset(_numberLabel.frame,offsextX,0);
        _priceLabel.frame = CGRectOffset(_priceLabel.frame,offsextX,0);
        
    }
    return self;
}


@end
