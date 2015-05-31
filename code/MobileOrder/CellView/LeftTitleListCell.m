//
//  LeftTitleListCell.m
//  BSTell
//
//  Created by cszhan on 14-2-9.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "LeftTitleListCell.h"
/*
 物资编号
 资源数
 起拍价
 当前价
 我的出价
 结束时间
 报盘方式
 拼盘梯度
 品名
 包装
 产地
 仓库
 重量
 计量单位
 质量标准
 备注
 附件
 竞价状态
 计价单位
 场次名称
 */
#define kTitleFontSize 13
@implementation LeftTitleListCell

- (id)initWithFrame:(CGRect)frame withTitleArray:(NSArray*)titleArray withItemPendingArray:(NSArray*)itemArray
{
 
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.frame = frame;
        self.clipsToBounds = YES;
        if(kDeviceCheckIphone5){
            //currY = 5.f;
        }
      
        [self setRowLineHidden:YES];
        [self setClounmLineHidden:YES];
        CGFloat currX = 20.f;
        CGFloat currY = 10.f;
        int columCount = [titleArray count];
        for(int i = 0;i<columCount;i++)
        {
            UILabel *itemLabel = [[UILabel alloc]initWithFrame:CGRectMake(currX,currY,60,15)];
            itemLabel.font = [UIFont systemFontOfSize:kTitleFontSize];
            itemLabel.textColor = [UIColor blackColor];
            itemLabel.backgroundColor = [UIColor clearColor];
            //itemLabel.textAlignment = NSTextAlignmentCenter;
            itemLabel.text = titleArray[i];
           
            [self addSubview:itemLabel];
            [self.mCellTitleArray addObject:itemLabel];
            SafeRelease(itemLabel);
            
            currValueTextWidth = 150.f;
            if(i ==13){
                UITextView *itemLabel = [[UITextView alloc]initWithFrame:CGRectMake(currX+100.f,currY,currValueTextWidth,15)];
                itemLabel.contentInset = UIEdgeInsetsMake(-9.f,10.f, 0.f, 0.f);
                itemLabel.font = [UIFont systemFontOfSize:kTitleFontSize];
                itemLabel.textColor = [UIColor blackColor];
                //itemLabel.numberOfLines = 0;
                itemLabel.backgroundColor = [UIColor clearColor];
                //itemLabel.textAlignment = NSTextAlignmentCenter;
                itemLabel.text = @"";
                [self addSubview:itemLabel];
                SafeRelease(itemLabel);
                [self.mCellItemArray addObject:itemLabel];
                currY = currY+[itemArray[i]floatValue];
            }
            else{
                itemLabel = [[UILabel alloc]initWithFrame:CGRectMake(currX+100.f,currY,currValueTextWidth,15)];
                itemLabel.font = [UIFont systemFontOfSize:kTitleFontSize];
                itemLabel.textColor = [UIColor blackColor];
                //itemLabel.numberOfLines = 0;
                itemLabel.backgroundColor = [UIColor clearColor];
                //itemLabel.textAlignment = NSTextAlignmentCenter;
                itemLabel.text = @"";
               
                [self addSubview:itemLabel];
                SafeRelease(itemLabel);
                [self.mCellItemArray addObject:itemLabel];
                currY = currY+[itemArray[i]floatValue];
            }
           
            
        }
        
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame withTitleArray:(NSArray*)titleArray withTitle:(NSString*)title  withValueAtrArray:(NSArray*)valueArray withItemPending:(CGFloat)yItemPending;
{
    if(self = [super initWithFrame:frame]){
        
        self.frame = frame;
        self.clipsToBounds = YES;
        if(kDeviceCheckIphone5){
            //currY = 5.f;
        }
        CGFloat currY = 10.f;
        [self setRowLineHidden:YES];
        [self setClounmLineHidden:YES];
        //for header title
        if(self.haveHeader){
            CGRect headRect = CGRectMake(self.xStartLeftPendingX,0.f,kDeviceScreenWidth, 30);
            self.headerLabel = [UIComUtil createLabelWithFont:[UIFont boldSystemFontOfSize:16] withTextColor:[UIColor blackColor] withText:title withFrame:headRect];
            self.headerLabel.textAlignment = NSTextAlignmentLeft;
            [self addSubview:self.headerLabel];
            //headerLabel.backgroundColor = [UIColor blueColor];
            SafeRelease(self.headerLabel);
            currY = 35.f;
        }
        [self setRowLineHidden:YES];
        [self setClounmLineHidden:YES];
        CGFloat currX = self.xStartLeftPendingX;
        
        int columCount = [titleArray count];
        for(int i = 0;i<columCount;i++)
        {
            UILabel *itemLabel = [[UILabel alloc]initWithFrame:CGRectMake(currX,currY,60,15)];
            itemLabel.font = [UIFont systemFontOfSize:kTitleFontSize];
            itemLabel.textColor = [UIColor blackColor];
            itemLabel.backgroundColor = [UIColor clearColor];
            //itemLabel.textAlignment = NSTextAlignmentCenter;
            itemLabel.text = titleArray[i];
            
            [self addSubview:itemLabel];
            SafeRelease(itemLabel);
            
            itemLabel = [[UILabel alloc]initWithFrame:CGRectMake(currX+60.f,currY,130,15)];
            itemLabel.font = [UIFont systemFontOfSize:kTitleFontSize];
            itemLabel.textColor = [UIColor blackColor];
            itemLabel.backgroundColor = [UIColor clearColor];
            //itemLabel.textAlignment = NSTextAlignmentCenter;
            itemLabel.text = @"";
            [self addSubview:itemLabel];
            SafeRelease(itemLabel);
            [self.mCellItemArray addObject:itemLabel];
            currY = currY+yItemPending;
        }
    }
return self;

}

- (id)initWithGoodsDetailFrame:(CGRect)frame withTitleArray:(NSArray*)titleArray withTitle:(NSString*)title  withValueAtrArray:(NSArray*)valueArray withItemPending:(CGFloat)yItemPending{

    if(self = [super initWithFrame:frame]){
        
        self.frame = frame;
        self.clipsToBounds = YES;
        if(kDeviceCheckIphone5){
            //currY = 5.f;
        }
        CGFloat currY = 10.f;
        [self setRowLineHidden:YES];
        [self setClounmLineHidden:YES];
        //for header title
        if(self.haveHeader){
            CGRect headRect = CGRectMake(self.xStartLeftPendingX,0.f,kDeviceScreenWidth, 30);
            self.headerLabel = [UIComUtil createLabelWithFont:[UIFont boldSystemFontOfSize:16] withTextColor:[UIColor blackColor] withText:title withFrame:headRect];
            self.headerLabel.textAlignment = NSTextAlignmentLeft;
            [self addSubview:self.headerLabel];
            //headerLabel.backgroundColor = [UIColor blueColor];
            SafeRelease(self.headerLabel);
            currY = 35.f;
        }
        [self setRowLineHidden:YES];
        [self setClounmLineHidden:YES];
        CGFloat currX = self.xStartLeftPendingX;
        
        int columCount = [titleArray count];
        for(int i = 0;i<columCount;i++)
        {
            UILabel *itemLabel = [[UILabel alloc]initWithFrame:CGRectMake(currX,currY,60,15)];
            itemLabel.font = [UIFont systemFontOfSize:15];
            itemLabel.textColor = [UIColor blackColor];
            itemLabel.backgroundColor = [UIColor clearColor];
            //itemLabel.textAlignment = NSTextAlignmentCenter;
            itemLabel.text = titleArray[i];
            
            [self addSubview:itemLabel];
            
             [self.mCellTitleArray addObject:itemLabel];
            
            SafeRelease(itemLabel);
            
            itemLabel = [[UILabel alloc]initWithFrame:CGRectMake(currX+90.f,currY,150,15)];
            itemLabel.font = [UIFont systemFontOfSize:15];
            itemLabel.textColor = [UIColor blackColor];
            itemLabel.backgroundColor = [UIColor clearColor];
            itemLabel.textAlignment = NSTextAlignmentLeft;
            itemLabel.text = @"";
            if(i ==13){
                itemLabel.numberOfLines = 0;
                itemLabel.lineBreakMode = NSLineBreakByWordWrapping;
            }
            [self addSubview:itemLabel];
            SafeRelease(itemLabel);
            [self.mCellItemArray addObject:itemLabel];
            currY = currY+yItemPending;
        }
    }
    return self;


}
- (id)initWithFrame:(CGRect)frame withTitleArray:(NSArray*)titleArray withTitle:(NSString*)title  withValueAtrArray:(NSArray*)valueArray withItemPending:(CGFloat)yItemPending withOrderCell:(BOOL)isOrder
{
    if(self = [super initWithFrame:frame]){
        
        self.frame = frame;
        self.clipsToBounds = YES;
        if(kDeviceCheckIphone5){
            //currY = 5.f;
        }
        [self setRowLineHidden:YES];
        [self setClounmLineHidden:YES];
        //for header title
        CGRect headRect = CGRectMake(self.xStartLeftPendingX,0.f,kDeviceScreenWidth, 30);
        self.headerLabel = [UIComUtil createLabelWithFont:[UIFont boldSystemFontOfSize:16] withTextColor:[UIColor blackColor] withText:title withFrame:headRect];
        self.headerLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.headerLabel];
        //headerLabel.backgroundColor = [UIColor blueColor];
        SafeRelease(self.headerLabel);
        
        
        [self setRowLineHidden:YES];
        [self setClounmLineHidden:YES];
        CGFloat currX = self.xStartLeftPendingX;
        CGFloat currY =35.f;
        int columCount = [titleArray count];
        for(int i = 0;i<columCount;i++)
        {
            UILabel *itemLabel = [[UILabel alloc]initWithFrame:CGRectMake(currX,currY,80,15)];
            itemLabel.font = [UIFont systemFontOfSize:kTitleFontSize];
            itemLabel.textColor = [UIColor blackColor];
            itemLabel.backgroundColor = [UIColor clearColor];
            //itemLabel.textAlignment = NSTextAlignmentCenter;
            itemLabel.text = titleArray[i];
            
            [self addSubview:itemLabel];
            SafeRelease(itemLabel);
            
            itemLabel = [[UILabel alloc]initWithFrame:CGRectMake(currX+100.f,currY,180,15)];
            itemLabel.font = [UIFont systemFontOfSize:kTitleFontSize];
            itemLabel.textColor = [UIColor blackColor];
            itemLabel.backgroundColor = [UIColor clearColor];
            //itemLabel.textAlignment = NSTextAlignmentCenter;
            itemLabel.text = @"";
            if(i ==13){
                itemLabel.numberOfLines = 0;
                itemLabel.lineBreakMode = NSLineBreakByWordWrapping;
            }
            [self addSubview:itemLabel];
            SafeRelease(itemLabel);
            [self.mCellItemArray addObject:itemLabel];
            currY = currY+yItemPending;
        }
    }
    return self;
    
}

- (id)initWithFrame:(CGRect)frame withTitleArray:(NSArray*)titleArray withTitleAttributeArray:(NSArray*)titleAtrArray withValueAttributeArray:(NSArray*)valueAtrArray withHeightArray:(NSArray*)heightArray
{
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.frame = frame;
        self.clipsToBounds = YES;
        if(kDeviceCheckIphone5){
            //currY = 5.f;
        }
        [self initWithTitleArray:titleAtrArray withTitleAttributeArray:titleAtrArray withValueAttributeArray:valueAtrArray withHeightArray:heightArray];
        
    }
    return self;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withTitleArray:(NSArray*)titleArray withTitleAttributeArray:(NSArray*)titleAtrArray withValueAttributeArray:(NSArray*)valueAtrArray withHeightArray:(NSArray*)heightArray{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initWithTitleArray:titleArray withTitleAttributeArray:titleAtrArray withValueAttributeArray:valueAtrArray withHeightArray:heightArray];
    }
    return self;

}
#define kItemPendingX 80
- (void)initWithTitleArray:(NSArray*)titleArray withTitleAttributeArray:(NSArray*)titleAtrArray withValueAttributeArray:(NSArray*)valueAtrArray withHeightArray:(NSArray*)heightArray{

    // Initialization code
 
    self.clipsToBounds = YES;
    if(kDeviceCheckIphone5){
        //currY = 5.f;
    }
    
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
        //itemLabel.numberOfLines = 0;
        [self addSubview:itemLabel];
        SafeRelease(itemLabel);
        [self.mCellItemArray addObject:itemLabel];
        currY = currY+height;
    }

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (BOOL)setCellItemValue:(NSString*)value withRow:(NSInteger)row {
    UILabel *textLabel =  self.mCellItemArray[row];
    
    UIFont *curFont = textLabel.font;
    CGFloat curWidth = textLabel.frame.size.width;
    CGFloat curHeight = textLabel.frame.size.height;
    CGRect rect = textLabel.frame;
    CGSize size = CGSizeMake(curWidth,130.f);
    
    if(kIsIOS7Check){
        size = [value boundingRectWithSize:size  options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:curFont} context:nil].size;
    }
    else{
        CGFloat height = [value sizeWithFont:curFont forWidth:curWidth lineBreakMode:NSLineBreakByWordWrapping].height;
        size.height = height;
    }
    if(size.height>curHeight && row ==13){
        
        //textLabel.numberOfLines = 0;
        /*
        textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        textLabel.numberOfLines = 0;
        textLabel.contentMode = UIViewContentModeTopLeft;
         */
//        int num  = size.height/curHeight;
//        CGFloat realHeight = (num+3)*curFont.pointSize;
        //textLabel.backgroundColor = [UIColor cl];
        textLabel.frame = CGRectMake(rect.origin.x-5, rect.origin.y, rect.size.width, size.height);
        textLabel.backgroundColor = [UIColor clearColor];
    }

    textLabel.text = value;
    return YES;
}
- (BOOL)setCellItemValue:(NSString*)value withRow:(NSInteger)row withCol:(NSInteger)col{
    /*
    UILabel *textLabel =  self.mCellItemArray[row];
    textLabel.text = value;
    return YES;
    */
    return [self setCellItemValue:value withRow:col ];// withCol:<#(NSInteger)#>]
}
- (void)setValueColorByIndex:(NSInteger)index withColor:(UIColor*)color{

    UILabel *textLabel =  self.mCellItemArray[index];
    textLabel.textColor = color;
    
}

- (void)setTitleHidden:(BOOL)status withIndex:(int)index{
    UILabel *textLabel =  self.mCellTitleArray[index];
    textLabel.hidden = status;
    textLabel =  self.mCellItemArray[index];
    textLabel.hidden = status;
    
}

- (void)setTitleHidden:(BOOL)status withIndex:(int)index withAdjust:(BOOL)adjust
{
    UILabel *textLabel =  self.mCellTitleArray[index];
    textLabel.hidden = status;
    textLabel =  self.mCellItemArray[index];
    textLabel.hidden = status;
    UILabel *adjustLabel = self.mCellItemArray[index +1];
    UILabel *adjustValueLabel  = self.mCellTitleArray[index+1];
    if(adjust){
        adjustValueLabel.frame = CGRectOffset(adjustValueLabel.frame, 0,-adjustValueLabel.frame.size.height-5);
        adjustLabel.frame = CGRectOffset(adjustLabel.frame, 0,-adjustLabel.frame.size.height-5);
    }
}


@end
