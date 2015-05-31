//
//  BidStartedTableViewCell.m
//  BSTell
//
//  Created by cszhan on 14-2-9.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "BidStartedTableViewCell.h"

@implementation BidStartedTableViewCell

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
    if (self) {
        // Initialization code
        //self.frame = frame;
        self.clipsToBounds = YES;
        if(kDeviceCheckIphone5){
            //currY = 5.f;
        }
        [self setRowLineHidden:YES];
        [self setClounmLineHidden:YES];
        cellHeitht = 20.f;
        currCellHeight = 3.f;
        valueHeight = 25.f;
        
        UIImageWithFileName(UIImage *image , @"arrow_detail.png");
        
        UIImageView *detailView = [[UIImageView alloc]initWithImage:image];
        [self addSubview:detailView];
        SafeRelease(detailView);
        detailView.frame = CGRectMake(0.f, 0.f, image.size.width/kScale, image.size.height/kScale);
        detailView.center = CGPointMake(290-20.f,62);
        /*
        UIButton *bidBtn = [UIComUtil createButtonWithNormalBGImageName:@"bid_price_btn.png" withHightBGImageName:@"bid_price_btn.png" withTitle:@"出价" withTag:0];
        [self addSubview:bidBtn];
        bidBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [bidBtn addTarget:self action:@selector(startBidPrice:) forControlEvents:UIControlEventTouchUpInside];
        bidBtn.frame = CGRectMake(170.f, 100.f, bidBtn.frame.size.width, bidBtn.frame.size.height);
        */
        
    }
    
    return self;

}
- (void)startBidPrice:(id)sender{
    
    
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
