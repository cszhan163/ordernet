//
//  OrderConfirmViewController.h
//  MobileOrder
//
//  Created by cszhan on 15-6-12.
//  Copyright (c) 2015年 com.ximalaya. All rights reserved.
//

#import "BSTellNetListBaseViewController.h"

#import "OrderItem.h"

@interface OrderConfirmViewController : BSTellNetListBaseViewController

@property(nonatomic,strong)  OrderItem *orderItem;

@end
