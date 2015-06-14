//
//  UserItem.m
//  MobileOrder
//
//  Created by cszhan on 15-6-13.
//  Copyright (c) 2015年 com.ximalaya. All rights reserved.
//

#import "UserItem.h"

@implementation UserItem

- (id)initWithDictionary:(NSDictionary*)data {

    if(self = [super init]) {
    
        self.phoneNum = [data objectForKey:@"phoneNumber"];
        self.name = [data objectForKey:@"userName"];
        self.totalPoints = [[data objectForKey:@"points"] integerValue];
    }
    return self;
}

@end
