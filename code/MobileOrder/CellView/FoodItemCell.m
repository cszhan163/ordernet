//
//  FoodItemCell.m
//  MobileOrder
//
//  Created by cszhan on 15-5-31.
//  Copyright (c) 2015年 com.ximalaya. All rights reserved.
//

#import "FoodItemCell.h"

#import "GoodsCatagoryItem.h"

@interface FoodItemCell() {
}

@property (nonatomic, strong) GoodsCatagoryItem *item;

@end
@implementation FoodItemCell

- (void)awakeFromNib {
    // Initialization code
    [self.addNumBtn addTarget:self action:@selector(numberBtnPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.addNumBtn setTag:1];
    [self.minNumBtn addTarget:self action:@selector(numberBtnPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.minNumBtn setTag:0];
    
    [self.markBtn addTarget:self action:@selector(numberBtnPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.markBtn setTag:2];
}

- (void)numberBtnPress:(id)sender{
    //has sub
    NSInteger index = [sender tag];
    
    if([self.item.subCatogoryArray count] && index == 2){
        
        if(self.delegate && [self.delegate respondsToSelector:@selector(cellDidClickOrderDetailBtn:withIndexPath:)]){
        
            [self.delegate cellDidClickOrderDetailBtn:self.item withIndexPath:self.indexPath];
        }
        
    }else {
    
        if(self.delegate && [self.delegate respondsToSelector:@selector(cellDidClickOrderBtn:withIndexPath:)]){
            
            switch ([sender tag]) {
                    //min
                case 0:
                    self.item.number = self.item.number-1;
                    if(self.item.number<=0)
                        self.item.number = 0;
                    break;
                    //add
                case 1:
                    self.item.number = self.item.number+1;
                    break;
                default:
                    break;
            }
            
            [self.delegate cellDidClickOrderBtn:self.item withIndexPath:self.indexPath];
            //[self setNeedsLayout];
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setCellItem:(GoodsCatagoryItem*)item {

#if 1
    self.item = item;
    self.priceLabel.text = [NSString stringWithFormat:@"¥ %0.2lf",self.item.price];
    self.foodNameLabel.text = item.name;
    
    if([self.item.subCatogoryArray count]){
        NSInteger number = 0;
        for (SubCatagoryItem *item in self.item.subCatogoryArray){
            
            number = number+item.number;
        }
        if(number == 0)
            [self.indictTextLabel setHidden:YES];
        else{
            [self.indictTextLabel setText:[NSString stringWithFormat:@"口味:%ld",number]];
            [self.indictTextLabel setHidden:NO];
        }
        [self.markBtn setHidden:NO];
    }else {
        
        //number = self.item.number;
        [self.markBtn setHidden:YES];
        [self.indictTextLabel setHidden:YES];
        
    }
    self.numberLabel.text = [NSString stringWithFormat:@"%ld",self.item.number];
#endif
}

@end
