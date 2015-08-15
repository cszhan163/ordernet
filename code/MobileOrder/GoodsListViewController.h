//
//  BidViewController.h
//  BSTell
//
//  Created by cszhan on 14-1-30.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "UIBaseViewController.h"
//#import "UIImageNetBaseViewController.h"
#import "BSTellNetListBaseViewController.h"
//@class UIImageNetBaseViewController;
//@protocol UIBaseViewControllerDelegate;
#import "OrderItem.h"
@interface GoodsListViewController:BSTellNetListBaseViewController

@property (nonatomic, strong) ShopItem *shopItem;

@end
