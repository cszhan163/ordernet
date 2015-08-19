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

@property (nonatomic, assign) CGFloat  avPrice;
@property (nonatomic, strong) NSString *position;

@property (nonatomic, strong) NSString *imageURL;

@property (nonatomic, assign) long long shopId;

- (id)initWithDictonary:(NSDictionary*)item;

@end

typedef NS_ENUM(NSInteger,OrderStatus){
    Order_Init, //0
    Order_NoArrived, //1, pay
    Order_Arrived ,   //2, pay
    Order_Done,     // 3, done
    Order_Cancel,
};

@interface OrderItem : NSObject

@property (nonatomic, strong) ShopItem * shopItem;

@property (nonatomic, strong) NSArray   *menuData;

@property (nonatomic, assign) NSInteger personNum;

@property (nonatomic, strong) UserItem *userItem;

@property (nonatomic, strong) NSString  *orderIdName;

@property (nonatomic, strong) NSString  *orderTime;

@property (nonatomic, assign) CGFloat consumePoints;

@property (nonatomic, assign) CGFloat totalPrice;

@property (nonatomic, assign) CGFloat payPrice;

@property (nonatomic, assign) long long  orderId;

@property (nonatomic, assign) NSInteger arriveTime;

@property (nonatomic, assign) OrderStatus status;

@property (nonatomic, assign) NSInteger  queueNum;

- (id)initWithDictionary:(NSDictionary*)orderDict;

- (NSDictionary*)getOrderDictionaryData;


@end
