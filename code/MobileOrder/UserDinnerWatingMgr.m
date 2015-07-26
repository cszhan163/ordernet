//
//  UserDinnerWatingMgr.m
//  MobileOrder
//
//  Created by cszhan on 15-7-19.
//  Copyright (c) 2015年 com.ximalaya. All rights reserved.
//

#import "UserDinnerWatingMgr.h"

static UserDinnerWatingMgr *staticInstance = nil;

@implementation UserDinnerWatingMgr

+ (instancetype)sharedInstance {
    if(staticInstance == nil){
    
        staticInstance = [[self alloc]init];
    }
    return staticInstance;
}

- (void)startCheckDinnerWaitingByOrderId:(NSString*)orderId {

    
    
}

@end
