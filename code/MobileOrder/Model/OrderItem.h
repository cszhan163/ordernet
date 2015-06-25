//
//  OrderItem.h
//  MobileOrder
//
//  Created by cszhan on 15-6-13.
//  Copyright (c) 2015年 com.ximalaya. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UserItem.h"

@interface ShopItem : NSObject

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *position;

@end

typedef NS_ENUM(NSInteger,OrderStatus){
    Order_Pay,
    Order_Cancel,
    Order_Done,
};

@interface OrderItem : NSObject

@property (nonatomic, strong) ShopItem * shopItem;

@property (nonatomic, strong) NSArray   *menuData;

@property (nonatomic, assign) NSInteger personNum;

@property (nonatomic, strong) UserItem *userItem;

@property (nonatomic, strong) NSString  *orderId;

@property (nonatomic, strong) NSString  *orderTime;

@property (nonatomic, assign) CGFloat consumePoints;

@property (nonatomic, assign) CGFloat totalPrice;

@property (nonatomic, assign) CGFloat payPrice;

@property (nonatomic, assign) OrderStatus status;


@end
