//
//  OrderTableViewCell.m
//  BSTell
//
//  Created by cszhan on 14-2-18.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "OrderTableViewCell.h"

@implementation OrderTableViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        /*
        UIImageWithFileName(UIImage*image, @"info_order_cel_bg.png");
        self.layer.contents = (id)image.CGImage;
         */
        self.layer.cornerRadius = 10.f;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (void)awakeFromNib{

    self.contentView.layer.cornerRadius = 10.f;
    //self.contentView.

}
- (void)layoutSubviews{
    CGRect rect = self.contentView.frame;
    self.contentView.frame = CGRectMake(10.f, rect.origin.y+2.5, 300.f, rect.size.height-5.f);
}
@end
