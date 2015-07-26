//
//  AppSetting.m
//  BSTell
//
//  Created by cszhan on 14-2-27.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "AppSetting.h"

@implementation AppSetting
+(void)setLoginUserDetailInfo:(NSDictionary*)dict userId:(NSString*)userId{
    NSUserDefaults *udf = [NSUserDefaults standardUserDefaults];
    [udf setValue:dict forKey:userId];
    [udf synchronize];
}
+(NSDictionary*)getLoginUserData:(NSString*)usrId{

    NSUserDefaults *udf = [NSUserDefaults standardUserDefaults];
    return [udf objectForKey:usrId];
    
}
+(NSString*)getLoginUserId{
    NSUserDefaults *udf = [NSUserDefaults standardUserDefaults];
    return [udf objectForKey:@"userId"];
}

+ (BOOL)getFirstOpen{

    NSUserDefaults *udf = [NSUserDefaults standardUserDefaults];
    id value = [udf objectForKey:@"fristlaunch"];
    if(value == nil)
        return  YES;
    return [value boolValue];
    
}

+ (void)setFirstOpen:(BOOL)status{
    
    NSUserDefaults *udf = [NSUserDefaults standardUserDefaults];
    [udf setValue:[NSNumber numberWithBool:status] forKey:@"fristlaunch"];
    [udf synchronize];
    
}

+(void)setLoginUserId:(NSString*)userId{
    NSUserDefaults *udf = [NSUserDefaults standardUserDefaults];
    [udf setValue:userId forKey:@"userId"];
    [udf synchronize];
    
}
+(void)setLoginUserPassword:(NSString*)password{
    NSUserDefaults *udf = [NSUserDefaults standardUserDefaults];
    [udf setValue:password forKey:@"userPassword"];
    [udf synchronize];
    
}
+(void)setLogoutUser{
    NSUserDefaults *udf = [NSUserDefaults standardUserDefaults];
    [udf removeObjectForKey:@"userId"];
    [udf synchronize];
}
+(void)setUserAutoLogin:(BOOL)isAuto {
    NSUserDefaults *udf = [NSUserDefaults standardUserDefaults];
    [udf setValue:[NSNumber numberWithBool:isAuto] forKey:@"userLoginAuto"];
    [udf synchronize];
}

+ (BOOL)userAutoLogin {

    NSUserDefaults *udf = [NSUserDefaults standardUserDefaults];
    id value =  [udf valueForKey:@"userLoginAuto"];
    if(value == nil){
        return YES;
    }
    return [value boolValue];
}

+ (BOOL)pushEnable {
    
    NSUserDefaults *udf = [NSUserDefaults standardUserDefaults];
    id value =  [udf valueForKey:@"push"];
    if(value == nil){
        return YES;
    }
    return [value boolValue];
}

+ (void)setPushEnable:(BOOL)status {
    
    NSUserDefaults *udf = [NSUserDefaults standardUserDefaults];
    [udf setValue:[NSNumber numberWithBool:status] forKey:@"push"];
    [udf synchronize];
}

@end
