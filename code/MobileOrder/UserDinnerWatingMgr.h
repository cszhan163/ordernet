//
//  UserDinnerWatingMgr.h
//  MobileOrder
//
//  Created by cszhan on 15-7-19.
//  Copyright (c) 2015年 com.ximalaya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDinnerWatingMgr : NSObject

- (void)startCheckDinnerWaitingByOrderId:(NSString*)orderId;

@end
