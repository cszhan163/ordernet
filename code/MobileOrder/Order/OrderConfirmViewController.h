//
//  OrderConfirmViewController.h
//  MobileOrder
//
//  Created by cszhan on 15-6-12.
//  Copyright (c) 2015年 com.ximalaya. All rights reserved.
//

#import "BSTellBaseViewController.h"

#import "OrderItem.h"

@interface OrderConfirmViewController : BSTellBaseViewController

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic,strong)  OrderItem *orderItem;

@end
