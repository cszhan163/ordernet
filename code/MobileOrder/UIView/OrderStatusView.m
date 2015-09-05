//
//  OrderStatusView.m
//  MobileOrder
//
//  Created by cszhan on 15-7-26.
//  Copyright (c) 2015年 com.ximalaya. All rights reserved.
//

#import "OrderStatusView.h"

#define kLeftPendinX  20.f

@implementation OrderStatusView

- (void)dealloc {
    self.arriveBtn = nil;
    SuperDealloc;
}

- (id)initWithFrame:(CGRect)frame {
    if([super initWithFrame:frame]) {
        CGFloat headerCurrY = 10.f;
        CGFloat labelHeight = 30.f;
        UILabel *arriveTitleLabel = [UIComUtil createLabelWithFont:kGoodsOrderMenuTextFont withTextColor:[UIColor blackColor] withText:@"" withFrame:CGRectMake(kLeftPendinX,headerCurrY,frame.size.width/2.f-kLeftPendinX*2,labelHeight)];
        //_totalPayLabel.backgroundColor = [UIColor clearColor];
        arriveTitleLabel.textAlignment = NSTextAlignmentCenter;
        arriveTitleLabel.text  = @"到店倒计时";
        [self addSubview:arriveTitleLabel];
        UIImage *image = nil;
        UIImageAutoScaleWithFileName(image, @"act_time");
        
        UIButton *iconBtn = [UIComUtil createButtonWithNormalBGImage:image withHightBGImage:image withTitle:@"" withTag:0 withTarget:self  withTouchEvent:nil];
        //showOrderBtn.backgroundColor = [UIColor redColor];
        iconBtn.frame = CGRectMake(frame.size.width/2.f-iconBtn.frame.size.width/2,headerCurrY ,iconBtn.frame.size.width, iconBtn.frame.size.height);
        [self  addSubview:iconBtn];

        _timerLabel = [UIComUtil createLabelWithFont:kGoodsOrderMenuTextFont withTextColor:[UIColor blackColor] withText:@"" withFrame:CGRectMake(frame.size.width/2.f+iconBtn.frame.size.width,headerCurrY,frame.size.width/2.f-iconBtn.frame.size.width,labelHeight)];
        //_totalPayLabel.backgroundColor = [UIColor clearColor];
        _timerLabel.textAlignment = NSTextAlignmentCenter;
        _timerLabel.text  = @"00:00";
        [self addSubview:_timerLabel];

        
        UIImageAutoScaleWithFileName(image, @"user_btn_h");
        
        self.arriveBtn = [UIComUtil createButtonWithNormalBGImage:image withHightBGImage:image withTitle:@"已到店" withTag:0 withTarget:self  withTouchEvent:@selector(didButtonPress:)];
        //showOrderBtn.backgroundColor = [UIColor redColor];
        _arriveBtn.frame = CGRectMake(kLeftPendinX,headerCurrY+40.f,frame.size.width/2.f-kLeftPendinX*2,labelHeight);
        [self  addSubview:_arriveBtn];
        
        UIButton *changeBtn = [UIComUtil createButtonWithNormalBGImage:image withHightBGImage:image withTitle:@"更改时间" withTag:1 withTarget:self  withTouchEvent:@selector(didButtonPress:)];
        //showOrderBtn.backgroundColor = [UIColor redColor];
        changeBtn.frame = CGRectMake(frame.size.width/2.f+kLeftPendinX,headerCurrY+40.f,frame.size.width/2.f-kLeftPendinX*2,labelHeight);
        [self  addSubview:changeBtn];
        
        
        //payBtn.frame = CGRectMake(40.f,payContentView.frame.size.height/3*2,image.size.width,image.size.height);
        
    }
    return self;
}

- (void)didButtonPress:(id)sender {

    if(self.delegate && [self.delegate respondsToSelector:@selector(didPressActionButton:withType:)]){
    
        [self.delegate didPressActionButton:sender withType:[sender tag]];
        
    }
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
