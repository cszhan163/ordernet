//
//  FoodOrderListCell.m
//  MobileOrder
//
//  Created by cszhan on 15-6-24.
//  Copyright (c) 2015年 com.ximalaya. All rights reserved.
//

#import "FoodsOrderListCell.h"

@implementation FoodsOrderListCell

- (id)initWithFrame:(CGRect)frame withRowCount:(NSInteger) rowNum withColumCount:(NSInteger)colNum withCellHeight:(CGFloat)height
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
    if (self) {
        // Initialization code
        self.frame = frame;
        self.clipsToBounds = YES;
        if(kDeviceCheckIphone5){
            //currY = 5.f;
        }
        [self setRowLineHidden:YES];
        [self setClounmLineHidden:YES];
        
        cellHeitht = 25;
        
        currCellHeight = 10;
        
        valueHeight = 30.f;
               
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
