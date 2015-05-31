//
//  ExcellLikeCellBase.m
//  BodCarManger
//
//  Created by cszhan on 13-10-4.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import "ExcellLikeCellBase.h"
#define kCellSplitLineColor    HexRGB(96, 95, 95)  
@interface ExcellLikeCellBase(){
    BOOL isHiddenLine;
    BOOL isHiddenGrid;
    UIView  *seperateLine;
}
@property(nonatomic,strong)NSArray *mClounmWidthArray;

@end

@implementation ExcellLikeCellBase
@synthesize mCellItemArray;
@synthesize mClounmWidthArray;

- (void)dealloc{
    self.mClounmWidthArray = nil;
    self.mCellTitleArray  = nil;
    self.mCellItemArray = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.mCellItemArray = [NSMutableArray array];
        self.mLineColor = kCellSplitLineColor;
        self.mClounmWidthArray = [NSMutableArray array];
        self.mCellTitleArray = [NSMutableArray array];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setClounmWidthArrays:(NSArray*)widthArray{
    self.mClounmWidthArray = widthArray;
}
- (void)setClounmLineColor:(UIColor*)color{
    self.mLineColor = color;
}
- (void)layoutSubviews{
  
    CGFloat currX = 0.f;
    if(!isHiddenGrid){
        int count = [mClounmWidthArray count]-1;
        for(int i = 0;i<count;i++)
        {
            id item = [mClounmWidthArray objectAtIndex:i];
            CGFloat lineOffsetX = [item floatValue];
            currX = currX+lineOffsetX;
            UIView  *cloumLine = [[UIView alloc]initWithFrame:CGRectMake(currX,0,1.f,self.frame.size.height)];
            cloumLine.backgroundColor = self.mLineColor;
            [self addSubview:cloumLine];
            SafeRelease(cloumLine);
            
        }
    }
    if(!isHiddenLine)
    {
        seperateLine = [[UIView alloc]initWithFrame:CGRectMake(0,self.frame.size.height-1,self.frame.size.width,1)];
        seperateLine.backgroundColor = self.mLineColor;
        [self addSubview:seperateLine];
        SafeRelease(seperateLine);
    }
      [super layoutSubviews];
}
- (void)setRowLineHidden:(BOOL)status{
    //seperateLine.hidden = status;
    isHiddenLine = status;
}
- (void)setClounmLineHidden:(BOOL)status{
    isHiddenGrid = status;
}
- (void)drawRect:(CGRect)rect{

    [super drawRect:rect];
}
- (void)setTableCellCloumn:(int)clum withData:(NSString*)text{
    UILabel *label = [self.mCellItemArray objectAtIndex:clum];
    label.text = text;
    
}
- (void)setTableCellCloumn:(int)clum withColor:(UIColor*)color{
    UILabel *label = [self.mCellItemArray objectAtIndex:clum];
    label.textColor = color;
}
- (UILabel*)getClounmWithIndex:(int)index{
    if(index<[self.mCellItemArray count]){
        return [self.mCellItemArray objectAtIndex:index];
    }
    return nil;
}

- (void)setTitle:(NSString*)title withIndex:(int)index{

    if(index>=[self.mCellTitleArray count])
        return;
    UILabel *label = [self.mCellTitleArray objectAtIndex:index];
    label.text = title;

}

@end
