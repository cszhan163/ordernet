//
//  BidPrepareTableViewCell.m
//  BSTell
//
//  Created by cszhan on 14-2-21.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "BidPrepareTableViewCell.h"

@implementation BidPrepareTableViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)idStr{
    self = [super initWithStyle:style reuseIdentifier:idStr];

    if(self){
        [self setHeaderLabelHiddenStatus:YES];
        CGFloat currY = 0.f;
        UIImageWithFileName(UIImage *image , @"bid_prepare_bg_1.png");
        UIImageView *detailView = [[UIImageView alloc]initWithImage:image];
        [self addSubview:detailView];
        detailView.frame = CGRectMake(5.f, 0.f, image.size.width/kScale, image.size.height/kScale);
        UIImageWithFileName(image , @"bid_prepare_bg_2.png");
        currY = currY+detailView.frame.size.height;
        //[self sendSubviewToBack:detailView];
        //detailView = [[UIImageView alloc]initWithImage:image];
        detailView = [[UIImageView alloc]initWithImage:image];
        [self addSubview:detailView];
        detailView.frame = CGRectMake(5.f,currY, image.size.width/kScale, image.size.height/kScale);
        //[self sendSubviewToBack:detailView];
        
        
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

@end
