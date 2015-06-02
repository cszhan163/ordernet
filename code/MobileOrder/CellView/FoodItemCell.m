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
    [self.minNumBtn addTarget:self action:@selector(numberBtnPress:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)numberBtnPress:(id)sender{
    //has sub
    if([self.item.subCatogoryArray count]){
        if(self.delegate && [self.delegate respondsToSelector:@selector(cellDidClickOrderDetailBtn:withIndexPath:)]){
        
            [self.delegate cellDidClickOrderDetailBtn:self.item withIndexPath:self.indexPath];
        }
        
    }else {
    
        if(self.delegate && [self.delegate respondsToSelector:@selector(cellDidClickOrderBtn:withIndexPath:)]){
            
            [self.delegate cellDidClickOrderBtn:self.item withIndexPath:self.indexPath];
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
    NSInteger number = 0;
    if([self.item.subCatogoryArray count]){
        
        for (SubCatagoryItem *item in self.item.subCatogoryArray){
            
            number = number+item.number;
        }
        
    }else {
        
        number = self.item.number;
    }
    self.numberLabel.text = [NSString stringWithFormat:@"%ld",number];
#endif
}

@end
