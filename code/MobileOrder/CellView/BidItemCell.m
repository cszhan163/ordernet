//
//  FriendItemCell.m
//  DressMemo
//
//  Created by  on 12-7-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BidItemCell.h"
#import <QuartzCore/QuartzCore.h>
#define kLeftCellPendingX 10.f
#define kTopCellPendingY  10.f

#define kTitleLabelWidth   60.f
#define kTitleLabelHeight   20.f

#define kValueLabelWidth   80.f


#define kCellItemPending  30.f


static  NSString* kTitleTextArray[] = {@"场次名称",@"",@"场次编号",@"保证金",@"卖方单位",@"参加状态",@"竞买时间",@""};

@implementation BidItemCell
@synthesize userIconImageView;
@synthesize locationLabel;
@synthesize nickNameLabel;
@synthesize relationBtn;
@synthesize indictTextLabel;
-(void)dealloc{
    self.userIconImageView = nil;
    self.locationLabel = nil;
    self.nickNameLabel = nil;
    self.relationBtn = nil;
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        // Initialization code
        UIImageWithFileName(UIImage* image, @"bid_cell_bg.png");
        assert(image);
        CGFloat startX = kLeftCellPendingX;
        CGFloat startY = kTopCellPendingY;
        self.layer.contents = (id)image.CGImage;
        CGRect rect;
        self.labelArray = [NSMutableArray arrayWithCapacity:8];
        for(int i = 0;i<4;i++){
            startX = kLeftCellPendingX;
            //startY = startY+kTopCellPendingY;
            for(int j=0;j<2;j++){
                if(i ==3||i== 0){
                    if(j==1)
                        continue;
                }
                rect = CGRectMake(startX,startY ,kTitleLabelWidth, kTitleLabelHeight);
                UILabel *item = [UIComUtil createLabelWithFont:[UIFont systemFontOfSize:12] withTextColor:[UIColor blackColor] withText:kTitleTextArray[2*i+j] withFrame:rect];
                item.textAlignment = NSTextAlignmentLeft;
                [self addSubview:item];
                SafeRelease(item);
                startX = startX+kTitleLabelWidth+5.f;
                CGRect labelRect = item.frame;
                if(i ==3||i== 0){
                    if(j==1){
                    
                    }
                    else{
                        rect = CGRectMake(labelRect.origin.x+item.frame.size.width,startY ,kValueLabelWidth*2, kTitleLabelHeight);
                    }
                }
                else{
                    rect = CGRectMake(labelRect.origin.x+item.frame.size.width,startY ,kValueLabelWidth, kTitleLabelHeight);
                }
                item = [UIComUtil createLabelWithFont:[UIFont systemFontOfSize:12] withTextColor:[UIColor blackColor] withText:@"" withFrame:rect];
                item.textAlignment = NSTextAlignmentLeft;
                [self addSubview:item];
                SafeRelease(item);
                [self.labelArray addObject:item];
                //startX = startX+kTitleLabelWidth;
                startX = startX+kValueLabelWidth;
        }
             startY = startY+kCellItemPending;
        }
        
    }
    return self;
}
- (BOOL)setCellItemValue:(NSString*)value withIndex:(NSInteger)index{
    if(index>=[self.labelArray count])
        return NO;
    UILabel *item = [self.labelArray objectAtIndex:index];
    item.text = value;
    return  YES;

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(id)getFromNibFile
{
    NSArray *nibItems = [[NSBundle mainBundle] loadNibNamed:@"BidItemCell" owner:nil options:nil];
    BidItemCell *instance = [nibItems objectAtIndex:0];
    /*
    instance.userIconImageView.layer.borderWidth = 2.5f;
    instance.userIconImageView.layer.borderColor = [[UIColor whiteColor]CGColor];
     */
    instance.selectionStyle = UITableViewCellSelectionStyleNone;
    instance.backgroundColor = [UIColor clearColor];
    return instance;

    //return instance;

}

@end
