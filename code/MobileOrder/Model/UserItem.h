//
//  UserItem.h
//  MobileOrder
//
//  Created by cszhan on 15-6-13.
//  Copyright (c) 2015年 com.ximalaya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserItem : NSObject

@property (nonatomic, strong) NSString *phoneNum;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, assign) NSInteger totalPoints;

@property (nonatomic, strong) NSDictionary *otherInfo;


- (id)initWithDictionary:(NSDictionary*)data ;

@end
