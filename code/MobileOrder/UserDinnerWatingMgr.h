//
//  UserDinnerWatingMgr.h
//  MobileOrder
//
//  Created by cszhan on 15-7-19.
//  Copyright (c) 2015年 com.ximalaya. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "OrderItem.h"



@interface UserDinnerWatingMgr : NSObject


@property (nonatomic ,copy) CompleteBlock netDoneBlock;

@property (nonatomic, copy) CompleteBlock netFailedBlcok;

@property (nonatomic, assign) NSInteger   personNum;

@property (nonatomic, assign) NSInteger   arriveTime;



- (OrderItem*)getUserCurrentOrderItem;

+ (instancetype)sharedInstance;

- (void)stopTimer;

- (void)startDinnerWaitingCheck:(OrderItem*) orderItem;

- (void)startGetOrderListByStatus:(OrderStatus) status;

- (void)startCheckDinnerWaitingByOrderId:(long long)orderId;

- (void)startGetRegisterUserSMSWithPhoneNum:(NSString*)phoneNum withDone:(CompleteBlock) done;

- (void)startVeryRegisterUserSMS:(NSDictionary*)param withDone:(CompleteBlock) done withError:(CompleteBlock) errorDone;

@end
