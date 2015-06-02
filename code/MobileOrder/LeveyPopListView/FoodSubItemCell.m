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

    UILabel *numberLabel;
}

@property (nonatomic, strong) SubCatagoryItem *item;

@end


@implementation FoodSubItemCell

- (void)dealloc {
    self.item = nil;
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
        UIButton *addBtn  = [UIComUtil createButtonWithNormalBGImage:image withHightBGImage:image withTitle:@"" withTag:0 withTarget:self withTouchEvent:@selector(didPrecessBtn:)];
        [self addSubview:addBtn];
        //[addBtn sizeToFit];
        CGSize  btnSize = addBtn.frame.size;
        CGFloat currX = self.frame.size.width-kPendingX-addBtn.frame.size.width;
        CGFloat currY = self.frame.size.height-kPendingY-addBtn.frame.size.height;
        addBtn.frame = CGRectMake(currX,currY,btnSize.width, btnSize.height);
       
        currX = currX-kPendingX;
        CGSize labelSize = CGSizeMake(40.f,20.f);
        
        numberLabel = [UIComUtil createLabelWithFont:kGoodsSubCatagoryTextFont withTextColor:[UIColor blackColor] withText:@"11" withFrame:CGRectMake(currX-labelSize.width,currY,labelSize.width,labelSize.height)];
        [self addSubview:numberLabel];
        
        UIImageAutoScaleWithFileName(image, @"auto_sub");
        UIButton *subBtn  = [UIComUtil createButtonWithNormalBGImage:image withHightBGImage:image withTitle:@"" withTag:1 withTarget:self withTouchEvent:@selector(didPrecessBtn:)];
        [self addSubview:subBtn];
      
        currX =  currX-kPendingX-labelSize.width;
        btnSize = subBtn.frame.size;
        
        subBtn.frame = CGRectMake(currX,currY,btnSize.width, btnSize.height);
        
     
        
    }
    return self;
}

- (void)didPrecessBtn:(id)sender {
    switch ([sender tag]) {
        case 0:
            self.item.number = self.item.number+1;
            break;
        case 1:
            
            self.item.number = self.item.number-1;
            if(self.item.number<=0)
                self.item.number = 0;
            break;
        default:
            break;
    }
    [self setNeedsLayout];
}
- (void)setCellItem:(SubCatagoryItem*)item {

    self.item = item;
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textLabel.text = _item.name;
    numberLabel.text = [NSString stringWithFormat:@"%ld",_item.number];
    //self.imageView.frame = CGRectOffset(self.imageView.frame, 6, 0);
    //self.textLabel.frame = CGRectOffset(self.textLabel.frame, 6, 0);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
