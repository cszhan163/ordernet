//
//  OrderTableViewCell.h
//  BSTell
//
//  Created by cszhan on 14-2-18.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "UIBaseTableViewCell.h"

@interface VendorTableViewCell : UIBaseTableViewCell
@property(nonatomic,weak)IBOutlet UILabel *distanceLabel;
@property(nonatomic,weak)IBOutlet UILabel *locationNameIdLabel;
@property(nonatomic,weak)IBOutlet UILabel *vendorNameLabel;
@property(nonatomic,weak)IBOutlet UILabel *avPricesLabel;
@property(nonatomic,weak)IBOutlet UIImageView *vendorImageView;
@end
