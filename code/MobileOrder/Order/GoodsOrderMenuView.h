//
//  OrderMenuView.h
//  MobileOrder
//
//  Created by cszhan on 15-6-6.
//  Copyright (c) 2015年 com.ximalaya. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GoodsCatagoryView.h"

@interface GoodsOrderMenuView : GoodsCatagoryView

- (void)updateDataByOrderListArray:(NSArray*)data;

@end
