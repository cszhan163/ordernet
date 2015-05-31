//
//  FoodItemCell.h
//  MobileOrder
//
//  Created by cszhan on 15-5-31.
//  Copyright (c) 2015年 com.ximalaya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodItemCell : UITableViewCell

@property(nonatomic,retain)IBOutlet UIImageView *foodIconImageView;
@property(nonatomic,retain)IBOutlet UILabel *foodNameLabel;
@property(nonatomic,retain)IBOutlet UILabel *priceLabel;
@property(nonatomic,strong)IBOutlet UILabel *indictTextLabel;
@property(nonatomic,retain)IBOutlet UIButton *addNumBtn;
@property(nonatomic,retain)IBOutlet UIButton *minNumBtn;
@property(nonatomic,retain)IBOutlet UIButton *markBtn;


@end
