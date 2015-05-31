//
//  OrderTableViewCell.h
//  BSTell
//
//  Created by cszhan on 14-2-18.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "UICarTableViewCell.h"

@interface OrderTableViewCell : UICarTableViewCell
@property(nonatomic,weak)IBOutlet UILabel *orderIdLabel;
@property(nonatomic,weak)IBOutlet UILabel *goodsIdLabel;
@property(nonatomic,weak)IBOutlet UILabel *classNameLabel;
@property(nonatomic,weak)IBOutlet UIImageView *bgImageView;
@end
