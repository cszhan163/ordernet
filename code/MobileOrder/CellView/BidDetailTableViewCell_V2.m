//
//  BidDetailTableViewCell_V2.m
//  BSTell
//
//  Created by cszhan on 14-2-19.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "BidDetailTableViewCell_V2.h"

#define  kItemPendingX   80.f
@interface BidDetailTableViewCell_V2(){
    UIButton *bidBtn;
    UITextView *bidTextView;
}
@property (nonatomic, assign)  id      actionTarget;
@property (nonatomic, assign)  SEL     actionSel;
@end
@implementation BidDetailTableViewCell_V2

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withTitleArray:(NSArray*)titleArray withTitleAttributeArray:(NSArray*)titleAtrArray withValueAttributeArray:(NSArray*)valueAtrArray withHeightArray:(NSArray*)heightArray
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier withTitleArray:titleArray withTitleAttributeArray:titleAtrArray withValueAttributeArray:valueAtrArray withHeightArray:heightArray];
    if (self) {
        // Initialization code
        
        UIImageWithFileName(UIImage *image , @"arrow_detail.png");
        
        UIImageView *detailView = [[UIImageView alloc]initWithImage:image];
        [self addSubview:detailView];
        SafeRelease(detailView);
        detailView.frame = CGRectMake(0.f, 0.f, image.size.width/kScale, image.size.height/kScale);
        detailView.center = CGPointMake(290-20.f,52);
        
        bidBtn = [UIComUtil createButtonWithNormalBGImageName:@"bid_cell_btn.png" withHightBGImageName:@"bid_cell_btn.png" withTitle:@"" withTag:0];
        [self addSubview:bidBtn];
        bidBtn.titleLabel.font = [UIFont boldSystemFontOfSize:40];
        
        bidBtn.frame = CGRectMake(190.f, 25.f+30, bidBtn.frame.size.width, bidBtn.frame.size.height);
        
        bidTextView = [[UITextView alloc]initWithFrame:CGRectMake(0.f, 0.f, bidBtn.frame.size.width, bidBtn.frame.size.height)];
        bidTextView.font = [UIFont systemFontOfSize:16];
        bidTextView.textColor = [UIColor blueColor];
        bidTextView.editable = NO;
        bidTextView.backgroundColor = [UIColor clearColor];
        bidTextView.textAlignment = NSTextAlignmentCenter;
        bidTextView.userInteractionEnabled  = NO;
        [bidBtn addSubview:bidTextView];
        SafeRelease(bidTextView);
        
//       
//        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTouchCellView:)];
//        
//        [self addGestureRecognizer:tapGesture];
//        SafeRelease(tapGesture);
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame withHeaderTitle:(NSString *)title withTitleArray:(NSArray*)titleArray withTitleAttributeArray:(NSArray*)titleAtrArray withValueAttributeArray:(NSArray*)valueAtrArray withHeightArray:(NSArray*)heightArray{
    
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"customCell"];
    if (self) {
        //for header title
        self.frame = frame;
        self.clipsToBounds = YES;
        if(kDeviceCheckIphone5){
            //currY = 5.f;
        }
        
        
        UIImageWithFileName(UIImage *image , @"arrow_detail.png");
        
        UIImageView *detailView = [[UIImageView alloc]initWithImage:image];
        [self addSubview:detailView];
        SafeRelease(detailView);
        detailView.frame = CGRectMake(0.f, 0.f, image.size.width/kScale, image.size.height/kScale);
        detailView.center = CGPointMake(self.frame.size.width-20.f,52);
        
        [self setRowLineHidden:YES];
        [self setClounmLineHidden:YES];
        CGFloat currX = 20.f;
        CGFloat currY = 10.f;
        int columCount = [titleArray count];
        for(int i = 0;i<columCount;i++)
        {
            NSDictionary *titleDict = titleAtrArray[i];
            float  height = [heightArray[i]floatValue];
            UILabel *itemLabel = [[UILabel alloc]initWithFrame:CGRectMake(currX,currY,kItemPendingX,height)];
            itemLabel.font = [titleDict objectForKey:@"font"];
            itemLabel.textColor = [titleDict objectForKey:@"color"];
            itemLabel.backgroundColor = [UIColor clearColor];
            //itemLabel.textAlignment = NSTextAlignmentCenter;
            itemLabel.text = titleArray[i];
            
            
            NSDictionary *valueDict = valueAtrArray[i];
            
            [self addSubview:itemLabel];
            [self.mCellTitleArray addObject:itemLabel];
            
            SafeRelease(itemLabel);
            
            itemLabel = [[UILabel alloc]initWithFrame:CGRectMake(currX+kItemPendingX,currY,140,height)];
            itemLabel.font = [valueDict objectForKey:@"font"];
            itemLabel.textColor = [valueDict objectForKey:@"color"];
            itemLabel.backgroundColor = [UIColor clearColor];
            //itemLabel.textAlignment = NSTextAlignmentCenter;
            itemLabel.text = @"";
            itemLabel.numberOfLines = 0;
            [self addSubview:itemLabel];
            SafeRelease(itemLabel);
            [self.mCellItemArray addObject:itemLabel];
            currY = currY+height;
        }

        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTouchCellView:)];
        
        [self addGestureRecognizer:tapGesture];
        SafeRelease(tapGesture);
        

    }
    return  self;
}
- (void)setActionTarget:(id)actionTarget withSelecotr:(SEL)selector{
    [bidBtn addTarget:actionTarget action:selector forControlEvents:UIControlEventTouchUpInside];
    self.actionTarget = actionTarget;
    self.actionSel = selector;
}
- (void)setBidButtonTag:(int)tag{
    bidBtn.tag = tag;
}
- (void)setBidButtonTitle:(NSString*)string{
#if 0
    [bidBtn setTitle:string forState:UIControlStateNormal];
    [bidBtn setTitle:string forState:UIControlStateSelected];
#else
    bidTextView.text = string;
#endif
}
- (void)setButtonDisableStatus:(BOOL)status{
    bidBtn.enabled = !status;
}
- (void)setButtonHiddenStatus:(BOOL)status{
    
    bidBtn.hidden = status;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
//
//    
//    [self.actionTarget performSelector:self.actionSel withObject:self];
//}
- (void)didTouchCellView:(UITapGestureRecognizer*)sender{

     [self.actionTarget performSelector:self.actionSel withObject:self];
}
@end
