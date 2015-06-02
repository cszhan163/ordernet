//
//  FoodItemCell.h
//  MobileOrder
//
//  Created by cszhan on 15-5-31.
//  Copyright (c) 2015年 com.ximalaya. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GoodsCatagoryItem;
@protocol FoodItemCellDelegate <NSObject>

- (void)cellDidClickOrderBtn:(id)sender  withIndexPath:(NSIndexPath*)indexPath;

- (void)cellDidClickOrderDetailBtn:(id)sender withIndexPath:(NSIndexPath *)indexPath;

@end



@interface FoodItemCell : UITableViewCell

@property(nonatomic,retain)IBOutlet UIImageView *foodIconImageView;
@property(nonatomic,retain)IBOutlet UILabel *foodNameLabel;
@property(nonatomic,retain)IBOutlet UILabel *priceLabel;
@property(nonatomic,strong)IBOutlet UILabel *indictTextLabel;
@property (nonatomic, strong) IBOutlet UILabel *numberLabel;
@property(nonatomic,retain)IBOutlet UIButton *addNumBtn;
@property(nonatomic,retain)IBOutlet UIButton *minNumBtn;
@property(nonatomic,retain)IBOutlet UIButton *markBtn;

@property(nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic,assign) id<FoodItemCellDelegate> delegate;

- (void)setCellItem:(GoodsCatagoryItem*)item;


@end
