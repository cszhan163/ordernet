//
//  CarCheckTableView.m
//  BodCarManger
//
//  Created by cszhan on 13-10-21.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import "BidDetailTableViewCell.h"

@interface BidDetailTableViewCell(){

    
}
@end
@implementation BidDetailTableViewCell
- (void)setHeaderLabelHiddenStatus:(BOOL)status{
    headerLabel.hidden = status;
}
- (id)initWithFrame:(CGRect)frame withRowCount:(NSInteger) rowNum withColumCount:(NSInteger)colNum withCellHeight:(CGFloat)height withHeaderTitle:(NSString*)title;
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
        
        cellHeitht = height;
        
        //for header title
        CGRect headRect = CGRectMake(0.f,0.f,kDeviceScreenWidth, 40);
        headerLabel = [UIComUtil createLabelWithFont:[UIFont systemFontOfSize:16] withTextColor:[UIColor blackColor] withText:title withFrame:headRect];
        [self addSubview:headerLabel];
        //headerLabel.backgroundColor = [UIColor blueColor];
        SafeRelease(headerLabel);
        
        currCellHeight = 40.f;
        
        valueHeight = 25.f;
        //NSArray *widthArray = ;
        /*
        for(int i = 0;i<colNum;i++){
            UILabel *itemLabel = [[UILabel alloc]initWithFrame:CGRectMake(currX,currY,[widthArray[i]floatValue],18)];
            itemLabel.font = [UIFont systemFontOfSize:12];
            itemLabel.textColor = [UIColor whiteColor];
            itemLabel.backgroundColor = [UIColor clearColor];
            itemLabel.textAlignment = NSTextAlignmentCenter;
            itemLabel.text = @"";
            currX = currX+[widthArray[i]floatValue]+1;
            [self addSubview:itemLabel];
            SafeRelease(itemLabel);
            [self.mCellItemArray addObject:itemLabel];
        }
        [self setClounmWidthArrays:widthArray];
        */
        
    }
    return self;
}
- (id)initWithIIFrame:(CGRect)frame withRowCount:(NSInteger) rowNum withColumCount:(NSInteger)colNum withCellHeight:(CGFloat)height withHeaderTitle:(NSString*)title{
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
        
        cellHeitht = height;
        
        currCellHeight = 32.f;
        
        valueHeight = 20.f;
        //NSArray *widthArray = ;
        /*
         for(int i = 0;i<colNum;i++){
         UILabel *itemLabel = [[UILabel alloc]initWithFrame:CGRectMake(currX,currY,[widthArray[i]floatValue],18)];
         itemLabel.font = [UIFont systemFontOfSize:12];
         itemLabel.textColor = [UIColor whiteColor];
         itemLabel.backgroundColor = [UIColor clearColor];
         itemLabel.textAlignment = NSTextAlignmentCenter;
         itemLabel.text = @"";
         currX = currX+[widthArray[i]floatValue]+1;
         [self addSubview:itemLabel];
         SafeRelease(itemLabel);
         [self.mCellItemArray addObject:itemLabel];
         }
         [self setClounmWidthArrays:widthArray];
         */
        
    }
    return self;


}
- (id)initWithCustomFrame:(CGRect)frame withRowCount:(NSInteger) rowNum withColumCount:(NSInteger)colNum withCellHeight:(CGFloat)height withHeaderTitle:(NSString*)title{

    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
    if (self) {
        // Initialization code
        self.frame = frame;
        self.clipsToBounds = YES;
        if(kDeviceCheckIphone5){
            //currY = 5.f;
        }
        cellHeitht = height;
        
        //for header title
        CGRect headRect = CGRectMake(0.f,0.f,kDeviceScreenWidth, 40);
        headerLabel = [UIComUtil createLabelWithFont:[UIFont systemFontOfSize:16] withTextColor:[UIColor blackColor] withText:title withFrame:headRect];
        [self addSubview:headerLabel];
        //headerLabel.backgroundColor = [UIColor blueColor];
        SafeRelease(headerLabel);
        
        currCellHeight = 35.f;
        
        valueHeight = 20.f;
        [self setRowLineHidden:YES];
        [self setClounmLineHidden:YES];
        cellHeitht = height;
        currCellHeight = 0.f;
        
    }
    return self;
}

- (void)setHeaderLabelText:(NSString*)text{

    headerLabel.text = text;

}
- (void)addColumWithKeyTitleArray:(NSArray*)titleArray withColumWidthArray:(NSArray*)widthArray{
    NSMutableArray *rowArray = [NSMutableArray array];
    CGFloat currX = 0.f;
    CGFloat currY = currCellHeight;
    int columCount = [titleArray count];
    for(int i = 0;i<columCount;i++)
    {
        UILabel *itemLabel = [[UILabel alloc]initWithFrame:CGRectMake(currX,currY,[widthArray[i]floatValue],18)];
        itemLabel.font = [UIFont systemFontOfSize:12];
        itemLabel.textColor = [UIColor blackColor];
        itemLabel.backgroundColor = [UIColor clearColor];
        itemLabel.textAlignment = NSTextAlignmentCenter;
        itemLabel.text = titleArray[i];
        currX = currX+[widthArray[i]floatValue]+1;
        [self addSubview:itemLabel];
        SafeRelease(itemLabel);
        //[rowArray addObject:itemLabel];
    }
    currY = currY+cellHeitht;
    currX = 0.f;
    for(int i = 0;i<columCount;i++)
    {
        UILabel *itemLabel = [[UILabel alloc]initWithFrame:CGRectMake(currX,currY,[widthArray[i]floatValue],18)];
        itemLabel.font = [UIFont systemFontOfSize:12];
        itemLabel.textColor = [UIColor blackColor];
        itemLabel.backgroundColor = [UIColor clearColor];
        itemLabel.textAlignment = NSTextAlignmentCenter;
        itemLabel.text = @"";
        currX = currX+[widthArray[i]floatValue]+1;
        [self addSubview:itemLabel];
        SafeRelease(itemLabel);
        [rowArray addObject:itemLabel];
    }
    [self.mCellItemArray addObject:rowArray];
    currY = currY+valueHeight;
    currCellHeight = currY;
    
}
- (void)addColumIIWithKeyTitleArray:(NSArray*)titleArray withColumWidthArray:(NSArray*)widthArray{
    NSMutableArray *rowArray = [NSMutableArray array];
    CGFloat currX = 5.f;
    CGFloat currY = currCellHeight;
    int columCount = [titleArray count];
    for(int i = 0;i<columCount;i++)
    {
        UILabel *itemLabel = [[UILabel alloc]initWithFrame:CGRectMake(currX,currY,[widthArray[i]floatValue],18)];
        itemLabel.font = [UIFont systemFontOfSize:12];
        itemLabel.textColor = [UIColor blackColor];
        itemLabel.backgroundColor = [UIColor clearColor];
        itemLabel.textAlignment = NSTextAlignmentCenter;
        itemLabel.text = titleArray[i];
        currX = currX+[widthArray[i]floatValue]+1;
        [self addSubview:itemLabel];
        SafeRelease(itemLabel);
        //[rowArray addObject:itemLabel];
    }
    currY = currY+cellHeitht;
    currX = 0.f;
    for(int i = 0;i<columCount;i++)
    {
        UILabel *itemLabel = [[UILabel alloc]initWithFrame:CGRectMake(currX,currY,[widthArray[i]floatValue],18)];
        itemLabel.font = [UIFont systemFontOfSize:12];
        itemLabel.textColor = [UIColor blackColor];
        itemLabel.backgroundColor = [UIColor clearColor];
        itemLabel.textAlignment = NSTextAlignmentCenter;
        itemLabel.text = @"";
        currX = currX+[widthArray[i]floatValue]+1;
        [self addSubview:itemLabel];
        SafeRelease(itemLabel);
        [rowArray addObject:itemLabel];
    }
    [self.mCellItemArray addObject:rowArray];
    currY = currY+valueHeight;
    currCellHeight = currY;
    
}



- (void)addColumWithKeyTitleArray:(NSArray*)titleArray withColumWidthArray:(NSArray*)widthArray withTitleAttributeArray:(NSArray*)titleAtrArray withValueAttributeArray:(NSArray*)valueAtrArray withHeightArray:(NSArray*)heightArray{

    CGFloat currX = 0.f;
    CGFloat currY = 0.f;
    int columCount = [titleArray count];
    for(int i = 0;i<columCount;i++)
    {
        NSDictionary *titleDict = titleAtrArray[i];
        float  height = [heightArray[i]floatValue];
        UILabel *itemLabel = [[UILabel alloc]initWithFrame:CGRectMake(currX,currY,[widthArray[i]floatValue],height)];
        itemLabel.font = [titleDict objectForKey:@"font"];
        itemLabel.textColor = [titleDict objectForKey:@"color"];
        itemLabel.backgroundColor = [UIColor clearColor];
        //itemLabel.textAlignment = NSTextAlignmentCenter;
        itemLabel.text = titleArray[i];
        
        
        NSDictionary *valueDict = titleAtrArray[i];
        
        [self addSubview:itemLabel];
        SafeRelease(itemLabel);
     
        itemLabel = [[UILabel alloc]initWithFrame:CGRectMake(currX,currY+height,100,height)];
        itemLabel.font = [valueDict objectForKey:@"font"];
        itemLabel.textColor = [valueDict objectForKey:@"color"];
        itemLabel.backgroundColor = [UIColor clearColor];
        //itemLabel.textAlignment = NSTextAlignmentCenter;
        itemLabel.text = @"";
        [self addSubview:itemLabel];
        SafeRelease(itemLabel);
        [self.mCellItemArray addObject:itemLabel];
        currY = currY+height;
    }

    
    
}
- (void)addColumWithKeyTitleArray:(NSArray*)titleArray withColumWidthArray:(NSArray*)widthArray withKeyTitleHeight:(CGFloat)keyHeight withValueHeight:(CGFloat)_valueHeight {
    NSMutableArray *rowArray = [NSMutableArray array];
    CGFloat currX = 5.f;
    CGFloat currY = currCellHeight;
    int columCount = [titleArray count];
    for(int i = 0;i<columCount;i++)
    {
        UILabel *itemLabel = [[UILabel alloc]initWithFrame:CGRectMake(currX,currY,[widthArray[i]floatValue],keyHeight)];
        itemLabel.font = [UIFont systemFontOfSize:10];
        itemLabel.textColor = [UIColor blackColor];
        itemLabel.backgroundColor = [UIColor clearColor];
        itemLabel.textAlignment = NSTextAlignmentCenter;
        
        itemLabel.text = titleArray[i];
        currX = currX+[widthArray[i]floatValue]+1;
        [self addSubview:itemLabel];
        SafeRelease(itemLabel);
        //[rowArray addObject:itemLabel];
    }
    currY = currY+keyHeight;
    currX = 5.f;
    for(int i = 0;i<columCount;i++)
    {
        UILabel *itemLabel = [[UILabel alloc]initWithFrame:CGRectMake(currX,currY,[widthArray[i]floatValue],_valueHeight)];
        itemLabel.font = [UIFont systemFontOfSize:10];
        itemLabel.textColor = [UIColor blackColor];
        itemLabel.backgroundColor = [UIColor clearColor];
        //itemLabel.adjustsFontSizeToFitWidth = YES;
        itemLabel.textAlignment = NSTextAlignmentCenter;
        itemLabel.text = @"";
        currX = currX+[widthArray[i]floatValue]+1;
        [self addSubview:itemLabel];
        SafeRelease(itemLabel);
        [rowArray addObject:itemLabel];
    }
    [self.mCellItemArray addObject:rowArray];
    currY = currY+_valueHeight;
    currCellHeight = currY;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (BOOL)setCellItemValue:(NSString*)value withRow:(NSInteger)row withCol:(NSInteger)col{
    UILabel *textLabel =  self.mCellItemArray[row][col];
    textLabel.text = value;
    return YES;
}
@end
