//
//  UserDinnerWatingMgr.h
//  MobileOrder
//
//  Created by cszhan on 15-7-19.
//  Copyright (c) 2015年 com.ximalaya. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "OrderItem.h"

typedef void (^CompleteBlock)(BOOL isOk);

@interface UserDinnerWatingMgr : NSObject


@property (nonatomic ,copy) CompleteBlock doneBlock;

+ (instancetype)sharedInstance;


- (void)startGetOrderListByStatus:(OrderStatus) status;

- (void)startCheckDinnerWaitingByOrderId:(NSString*)orderId;

@end
