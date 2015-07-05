//
//  OrderItem.m
//  MobileOrder
//
//  Created by cszhan on 15-6-13.
//  Copyright (c) 2015年 com.ximalaya. All rights reserved.
//

#import "OrderItem.h"

@implementation ShopItem

- (id)initWithDictonary:(NSDictionary*)item {

    if(self = [super init]) {
    self.name = [item objectForKey:@"name"];
    self.position = [item objectForKey:@"location"];
        self.avPrice = [[item objectForKey:@"averagePrice"]floatValue];
    }
    return self;
}

- (void)dealloc {

    self.name = nil;
    self.position = nil;
    SuperDealloc;
}

@end

@implementation OrderItem



@end
