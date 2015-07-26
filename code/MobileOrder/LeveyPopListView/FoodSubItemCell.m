//
//  LeveyPopListViewCell.m
//  LeveyPopListViewDemo
//
//  Created by Levey on 2/21/12.
//  Copyright (c) 2012 Levey. All rights reserved.
//

#import "FoodSubItemCell.h"

//#import ""

#import "GoodsCatagoryItem.h"

#define kPendingX 10
#define kPendingY 20


@interface FoodSubItemCell() {

   
    
}

@property (nonatomic, strong) SubCatagoryItem *item;

@end


@implementation FoodSubItemCell

- (void)dealloc {
    self.item = nil;
    self.foodName = nil;
    SuperDealloc;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.frame = CGRectMake(0.f, 0.f,280,50);
        self.backgroundColor = [UIColor whiteColor];
        self.textLabel.textColor = kGoodCatagoryTextColor;//[UIColor whiteColor];
        self.textLabel.font = kGoodsSubCatagoryTextFont;
        
    
        UIImage *image = nil;
        UIImageAutoScaleWithFileName(image, @"auto_add");
        _addBtn  = [UIComUtil createButtonWithNormalBGImage:image withHightBGImage:image withTitle:@"" withTag:0 withTarget:self withTouchEvent:@selector(didPrecessBtn:)];
        [self addSubview:_addBtn];
        //[addBtn sizeToFit];
        CGSize  btnSize = _addBtn.frame.size;
        CGFloat currX = self.frame.size.width-kPendingX-_addBtn.frame.size.width;
        CGFloat currY =(self.frame.size.height-_addBtn.frame.size.height)/2.f;
        _addBtn.frame = CGRectMake(currX,currY,btnSize.width, btnSize.height);
       
        currX = currX-kPendingX+6.f;
        CGSize labelSize = CGSizeMake(40.f,20.f);
        
        _numberLabel = [UIComUtil createLabelWithFont:kGoodsSubCatagoryTextFont withTextColor:[UIColor blackColor] withText:@"11" withFrame:CGRectMake(currX-labelSize.width,currY+2.f,labelSize.width,labelSize.height)];
        [self addSubview:_numberLabel];
        _numberLabel.backgroundColor = [UIColor redColor];
        
        
        UIImageAutoScaleWithFileName(image, @"auto_sub");
        _subBtn  = [UIComUtil createButtonWithNormalBGImage:image withHightBGImage:image withTitle:@"" withTag:1 withTarget:self withTouchEvent:@selector(didPrecessBtn:)];
        [self addSubview:_subBtn];
      
        currX =  currX-2*kPendingX-labelSize.width;
        btnSize = _subBtn.frame.size;
        
        _subBtn.frame = CGRectMake(currX,currY,btnSize.width, btnSize.height);
        
     
        _priceLabel = [UIComUtil createLabelWithFont:kGoodsSubCatagoryTextFont withTextColor:[UIColor blackColor] withText:@"11" withFrame:CGRectMake(currX-labelSize.width-80.f,currY+2.f,100.f,labelSize.height)];
        _priceLabel.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:_priceLabel];
        _priceLabel.backgroundColor = [UIColor greenColor];
        
    }
    return self;
}


- (void)didPrecessBtn:(id)sender {
    switch ([sender tag]) {
        case 0:{
            self.item.number = self.item.number+1;
            
            if(self.delegate && [self.delegate respondsToSelector:@selector(cellDidClickOrderAddBtn:withNumber:)]) {
                
                [self.delegate cellDidClickOrderAddBtn:self withNumber:self.item.number];
            }
        }
            break;
        case 1: {
            
            self.item.number = self.item.number-1;
            if(self.item.number<=0)
                self.item.number = 0;
            
            if(self.delegate && [self.delegate respondsToSelector:@selector(cellDidClickOrderAddBtn:withNumber:)]) {
                
                [self.delegate cellDidClickOrderSubBtn:self withNumber:self.item.number];
            }
        }
            break;
        default:
            break;
    }
    //[self layoutIfNeeded];
 
}
- (void)setCellItem:(SubCatagoryItem*)item {

    self.item = item;
    [self layoutIfNeeded];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSString *titleName = _item.name;
    if(self.foodName && ![self.foodName isEqualToString:@""]) {
        titleName = [NSString stringWithFormat:@"%@+%@",self.foodName,_item.name];
    }
    //titleName= @"很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长";
    self.textLabel.font = [UIFont systemFontOfSize:14];
    self.textLabel.text =titleName;
    self.textLabel.frame = CGRectMake(0.f, 0.f,self.frame.size.width/2.f, 40);
    _numberLabel.text = [NSString stringWithFormat:@"%ld",_item.number];
    _priceLabel.text =  [NSString stringWithFormat:@"¥ %0.2lf 元",_item.price];
    //self.imageView.frame = CGRectOffset(self.imageView.frame, 6, 0);
    //self.textLabel.frame = CGRectOffset(self.textLabel.frame, 6, 0);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
