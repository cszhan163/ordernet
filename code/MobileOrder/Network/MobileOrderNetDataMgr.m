//
//  DressMemoNetDataMgr.m
//  DressMemo
//
//  Created by  on 12-6-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MobileOrderNetDataMgr.h"
//#import "ZCSNetClientNetInterfaceMgr.h"
#import "AppConfig.h"
#import "ZCSNetClient.h"
#import "AppSetting.h"
#define  kRequestApiRoot                @"http://121.40.239.155/1.0/"

#import <CommonCrypto/CommonDigest.h> // Need to import for CC_MD5 access

@implementation NSString (MyExtensions)
- (NSString *) getMd5String
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, strlen(cStr), result ); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}
@end

@implementation NSData (MyExtensions)
- (NSString*)md5
{
    unsigned char result[16];
    CC_MD5( self.bytes, self.length, result ); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];  
}
@end

@interface MobileOrderNetDataMgr()
@property(nonatomic,retain)NSMutableDictionary *requestResourceDict;
//@property(nonatomic,assign)BOOL isUserLogOut;
@end
static MobileOrderNetDataMgr *sharedInstance = nil;
static ZCSNetClientNetInterfaceMgr *dressMemoInterfaceMgr = nil;
@implementation MobileOrderNetDataMgr
@synthesize requestResourceDict;
+(id)getSingleTone{
    @synchronized(self)
    {
        if(sharedInstance == nil)
            sharedInstance = [[self alloc] init];
        
    }
    return sharedInstance;
}
-(id)init
{
    if(self = [super init])
    {
        dressMemoInterfaceMgr = [ZCSNetClientNetInterfaceMgr getSingleTone];
        NSDictionary *requestResouceMapDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                               
                                               @"user/login",        kNetLoginRes,
                                               @"user/register",             kNetResignRes,
                                               @"product/list", @"getgoodslist",
                                               @"dining/list",    @"getdinglist",
                                               @"user", @"getuserInfo",
                                               
                                               @"search_goodDetail",@"getGoodDetail",
                                               @"search_orders_old",@"search_orders_old",
                                               @"search_orders_month",@"search_orders_month",
                                               @"search_good_ad",@"getGoodAd",
                                               @"search_good_ad",@"getGoodMap",
                                               @"search_category",@"search_category",
                                               @"search_orders",@"search_orders",
                                               @"search_ordergoods",@"search_ordergoods",
                                               @"search_orderDetail",@"search_orderDetail",
                                               @"search_fav",@"search_fav",
                                               @"search_delivery",@"search_delivery",
                                               @"pay",@"pay",
                                               @"search_address",@"search_address",
                                               @"add_address",@"add_address",
                                               @"edit_address",@"edit_address",
                                               
                                               @"search_province",@"search_province",
                                               @"search_city",@"search_city",
                                               @"search_good_map",@"search_good_map",
                                               
                                               @"delete_order",@"delete_order",
                                               @"update",       @"update",
                                               @"getsms",       @"getsms",
                                               @"update_contacts",@"update_contacts",
                                               @"getsmsfindpassword",@"getsmsfindpassword",
                                               @"findpassword",@"findpassword",
                                               
                                               @"new_order",    @"new_order",
                                               @"search_ad",@"search_ad",
                                               @"search_good_ad",@"search_good_ad",
                                               @"search_good_map",@"search_good_map",
                                               @"update_userico",@"update_userico",
                                              @"search_deliveryDetail",@"search_deliveryDetail",
                                               @"",@"opensession",
                                               
                                               nil];
        dressMemoInterfaceMgr.requestResourceDict = requestResouceMapDict;
        
        dressMemoInterfaceMgr.netInterfaceDataSource = self;
        dressMemoInterfaceMgr.netInterfaceDelegate = self;
        [dressMemoInterfaceMgr setRequestUrl:kRequestApiRoot];
        //requestResourceDict = [[NSMutableDictionary alloc]init];
#if 0
        [ZCSNotficationMgr addObserver:self call:@selector(didGetDataFromNet:) msgName:kZCSNetWorkOK];
        [ZCSNotficationMgr addObserver:self call:@selector(didGetDataFromNetFailed:) msgName:kZCSNetWorkRequestFailed];
#endif
        //dbMgr = [DBManage getSingleTone];
    }
    return self;
}

#pragma mark login user data source
-(NSDictionary*)getUserLoginData
{
    
    //NSString *loginUser = [AppSetting getCurrentLoginUser];
    
    //[AppSetting setLoginUserInfo:data withUserKey:loginUserId];
    NSString *userName = @"";
    NSString *userPassword = @"";
    
#if 0
    NSString *loginUser = [AppSetting getLoginUserId];
    NSDictionary *loginData = [AppSetting getLoginUserInfo];                       
    userName = [loginData objectForKey:@"username"];
    userPassword = [loginData objectForKey:@"password"];
#else
    userName = @"admin";
    userPassword = @"1";
#endif
    
    NSString *pasMd5Str = [userPassword getMd5String];
    NSString *finalMd5Str = [[NSString stringWithFormat:@"%@%@",pasMd5Str,pasMd5Str] getMd5String];
    NSDictionary *userData = [NSDictionary dictionaryWithObjectsAndKeys:
                              userName,@"user",
                              finalMd5Str,@"password",
                                pasMd5Str,@"salt",
                              nil]; //[AppSetting getLoginUserInfo:loginUser];
   
    
//    NSMutableDictionary * paramsDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:
//                                              
//                                              [userData objectForKey:@"username"],@"username",
//                                              
//                                              [userData objectForKey:@"password"],@"password",
//                                                                                                                              
//                                              nil];
    return userData;
}


#pragma mark user login delegate
-(void)didLoginUser:(ZCSNetClient*)sender withLoginUserData:(NSDictionary*)data
{
    NSLog(@"%@",[data description]);
    NSDictionary *dataDict = [data objectForKey:@"data"];
    id userid = [dataDict objectForKey:@"userName"];
    if([userid isKindOfClass:[NSNumber class]])
    {
        userid = [NSString stringWithFormat:@"%lld",[userid longLongValue]];
    }
    [AppSetting setLoginUserId:userid];
    NSString *loginUserId = [AppSetting getLoginUserId];
    //[AppSetting setLoginUserInfo:[sender requestParam]];
    if(0){
        [AppSetting setLoginUserDetailInfo:dataDict userId:loginUserId];
    }
    [ZCSNotficationMgr postMSG:kUserDidLoginOk obj:nil];

}
-(void)didServerRespond:(ZCSNetClient*)sender withErrorData:(NSDictionary*)data
{
    NSLog(@"%@",[data description]);
    id dataDict = [data objectForKey:@"data"];
    //id data = [dataDict objectForKey:@"data"];
    if([[dataDict objectForKey:@"code"]isEqualToString:@"-2"])//need to relogin
    {
        //[request reloadRequest];
        /*
        [dressMemoInterfaceMgr setLogin:NO];
        ZCSNetClient *newRequest = [self startAnRequestByResKey:sender.resourceKey needLogIn:YES withParam:sender.requestParam withMethod:sender.request.httpMethod withData:sender.isPostData];
        [ZCSNotficationMgr postMSG:kZCSNetWorkReloadRequest obj:newRequest];
         */
        //[self startRequest:newRequest];
        return;
    }
    if(dataDict == nil)
    {
        kUIAlertView(@"提示",@"网络好像有问题,请检查网络");
    }
    else
    {
        id inforStr = [dataDict objectForKey:@"info"];
        if([inforStr isKindOfClass:[NSString class]])
        {
            kUIAlertView(@"提示",inforStr);
        }
    }
}
-(void)didRequestRespond:(ZCSNetClient*)sender withErrorData:(NSDictionary*)data
{
    kUIAlertView(@"提示",@"网络好像有问题,请检查网络");
}
#if 0
- (void)didGetRawRespond:(ZCSNetClient*)sender withRawData:(NSData*)data {

     NSLog(@"%@",SafeAutoRelease([[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]));
    
}
#endif
#pragma mark -
#pragma mark
-(NSDictionary*)addUserIdParam:(NSDictionary*)param
{
    
   // return [NSDictionary dictionaryWithObject:@"13611694780" forKey:@"username"];
    
    
    NSMutableDictionary *newParam = [NSMutableDictionary dictionaryWithDictionary:param];
    NSString *loginUserId = [AppSetting getLoginUserId];
#if 0
    id userId = [[AppSetting getLoginUserInfo:loginUserId] objectForKey:@"user_id"];
    if([userId isKindOfClass:[NSNumber class]])
    {
        userId = [NSString stringWithFormat:@"%lld",[userId longLongValue]];
    }
    [newParam setValue:userId forKey:@"user_id"];
#else
    //userId = loginUserId;
    [newParam setValue:loginUserId forKey:@"username"];
#endif
    return newParam;
}
#pragma mark user login

- (id)openSession {

    return [dressMemoInterfaceMgr startAnRequestByResKey:@"opensession"
                                        needLogIn:NO
                                        withParam:nil
                                       withMethod:@"GET"
                                         withData:NO];
}

-(id)userLogin:(NSDictionary*)param
{
    param = [self getUserLoginData];
    return [dressMemoInterfaceMgr startAnRequestByResKey:kNetLoginRes
                                        needLogIn:NO
                                        withParam:param
                                       withMethod:@"POST"
                                         withData:NO];
    
}
-(id)userResign:(NSDictionary*)param

{
    BOOL isHasData = NO;
    if([param objectForKey:@"avatar"])
    {
        
        isHasData  = YES;
        
    }
    return [dressMemoInterfaceMgr startAnRequestByResKey:@"register"
                                               needLogIn:NO
                                               withParam:param
                                              withMethod:@"POST"
                                                withData:isHasData];
    
}

-(id)userResetPassword:(NSDictionary*)param
{
    //search_category
    //param = [self addUserIdParam:param];
    return [dressMemoInterfaceMgr startAnRequestByResKey:@"register"
                                               needLogIn:NO
                                               withParam:param
                                              withMethod:@"PUT"
                                                withData:NO];
}

-(id)userInfoUpdate:(NSDictionary*)param
{
    param = [self addUserIdParam:param];
    return [dressMemoInterfaceMgr startAnRequestByResKey:@"update"
                                        needLogIn:YES
                                        withParam:param
                                       withMethod:@"POST"
                                         withData:NO];
    
}
-(id)userResignRandomCode:(NSDictionary*)param
{
    
    return [dressMemoInterfaceMgr startAnRequestByResKey:@"getsms"
                                        needLogIn:NO
                                        withParam:param
                                       withMethod:@"POST"
                                         withData:NO];
    
}
-(id)userFavProducts:(NSDictionary*)param
{
    //search_category
    param = [self addUserIdParam:param];
    return [dressMemoInterfaceMgr startAnRequestByResKey:@"search_fav"
                                               needLogIn:YES
                                               withParam:param
                                              withMethod:@"GET"
                                                withData:NO];
}
-(id)userResetPwdRadomCode:(NSDictionary*)param
{
    //search_category
    //param = [self addUserIdParam:param];
    return [dressMemoInterfaceMgr startAnRequestByResKey:@"getsmsfindpassword"
                                               needLogIn:NO
                                               withParam:param
                                              withMethod:@"POST"
                                                withData:NO];
}
/**
 接口名
 update_userico
 接口方式
 POST
 接口参数
 username
 head_icon
 */
-(id)userProfileIconUpdate:(NSDictionary*)param
{
    param = [self addUserIdParam:param];
    return [dressMemoInterfaceMgr startAnRequestByResKey:@"update_userico"
                                               needLogIn:YES
                                               withParam:param
                                              withMethod:@"POST"
                                                withData:YES];

}
/*
 *update_contacts	POST	username
 telnum[]	用户联系人信息更新
 */
-(id)uploadUserPhoneContactorsPhoneNumber:(NSDictionary*)param
{
    param = [self addUserIdParam:param];
    return [dressMemoInterfaceMgr startAnRequestByResKey:@"update_contacts"
                                               needLogIn:YES
                                               withParam:param
                                              withMethod:@"POST"
                                                withData:NO];
}

-(id)userUser:(NSDictionary*)param {
    //param = [self addUserIdParam:param];
    return [dressMemoInterfaceMgr startAnRequestByResKey:@"getuserInfo"
                                               needLogIn:YES
                                               withParam:nil
                                              withMethod:@"GET"
                                                withData:NO];
    
}
#pragma mark -
#pragma mark address
/**
 search_address	GET	username
 用户常用地址取得
 add_address	GET	username
 accept_name
 province
 city
 area
 address
 telphone
 mobile
 zip
 default	用户常用地址新增
 edit_address	GET	username
 id
 accept_name
 province
 city
 area
 address
 telphone
 mobile
 zip
 default 	用户常用地址修改
 */
-(id)getUserContactAddress:(NSDictionary*)param
{
    //search_category
    param = [self addUserIdParam:param];
    return [dressMemoInterfaceMgr startAnRequestByResKey:@"search_address"
                                               needLogIn:YES
                                               withParam:param
                                              withMethod:@"GET"
                                                withData:NO];

}
-(id)addUserContactAddress:(NSDictionary*)param
{
    //search_category
    param = [self addUserIdParam:param];
    return [dressMemoInterfaceMgr startAnRequestByResKey:@"add_address"
                                               needLogIn:YES
                                               withParam:param
                                              withMethod:@"POST"
                                                withData:NO];


}
-(id)editUserContactAddress:(NSDictionary*)param
{
    //search_category
    param = [self addUserIdParam:param];
    return [dressMemoInterfaceMgr startAnRequestByResKey:@"edit_address"
                                               needLogIn:YES
                                               withParam:param
                                              withMethod:@"POST"
                                                withData:NO];

}
/*
 *search_province	GET		省份信息查询
 search_city	GET	province_id	城市信息查询
 search_area	GET	city_id	区县信息查询
 province_id
 city_id
 */
-(id)getProvinceData:(NSDictionary*)param
{
    return [dressMemoInterfaceMgr startAnRequestByResKey:@"search_province"
                                               needLogIn:NO
                                               withParam:param
                                              withMethod:@"GET"
                                                withData:NO];

}
-(id)getCityData:(NSDictionary*)param
{
    return [dressMemoInterfaceMgr startAnRequestByResKey:@"search_city"
                                               needLogIn:NO
                                               withParam:param
                                              withMethod:@"GET"
                                                withData:NO];

}
-(id)getAreaData:(NSDictionary*)param
{
    return [dressMemoInterfaceMgr startAnRequestByResKey:@"search_area"
                                               needLogIn:YES
                                               withParam:param
                                              withMethod:@"GET"
                                                withData:NO];

}
#pragma mark -
#pragma mark ad
-(id)getHomePageAd:(NSDictionary*)param
{
    return [dressMemoInterfaceMgr startAnRequestByResKey:@"search_ad"
                                               needLogIn:NO
                                               withParam:param
                                              withMethod:@"GET"
                                                withData:NO];

}
/*
 search_good_ad
 */
-(id)getProductAd:(NSDictionary*)param
{
    return [dressMemoInterfaceMgr startAnRequestByResKey:@"search_good_ad"
                                               needLogIn:NO
                                               withParam:param
                                              withMethod:@"GET"
                                                withData:NO];

}

-(id)getProductMap:(NSDictionary*)param
{
    return [dressMemoInterfaceMgr startAnRequestByResKey:@"search_good_map"
                                               needLogIn:NO
                                               withParam:param
                                              withMethod:@"GET"
                                                withData:NO];
    
}
#pragma mark -
#pragma mark 
-(id)getProductSiteMap:(NSDictionary*)param
{
//
    return [dressMemoInterfaceMgr startAnRequestByResKey:@"search_good_map"
                                               needLogIn:NO
                                               withParam:param
                                              withMethod:@"GET"
                                                withData:NO];

}
#pragma mark -
#pragma mark goods
-(id)getProductsList:(NSDictionary*)param
{
    return [dressMemoInterfaceMgr startAnRequestByResKey:@"getgoodslist"
                                        needLogIn:NO
                                        withParam:param
                                       withMethod:@"GET"
                                         withData:NO];
    
}
- (id)getDingList:(NSDictionary*)param {
    
    return [dressMemoInterfaceMgr startAnRequestByResKey:@"getdinglist"
                                               needLogIn:NO
                                               withParam:param
                                              withMethod:@"GET"
                                                withData:NO];
    
}
/*
 *
 search_goodDetail	GET
 search_good_ad	GET
 search_good_map	GET
 */
-(id)getProductDetail:(NSDictionary*)param
{
    //search_category
    return [dressMemoInterfaceMgr startAnRequestByResKey:@"getGoodDetail"
                                               needLogIn:NO
                                               withParam:param
                                              withMethod:@"GET"
                                                withData:NO];
    
}
-(id)getProductDetailAd:(NSDictionary*)param
{
    return [dressMemoInterfaceMgr startAnRequestByResKey:@"getGoodAd"
                                               needLogIn:NO
                                               withParam:param
                                              withMethod:@"GET"
                                                withData:NO];

    
}
-(id)getProductDetailMap:(NSDictionary*)param
{
    return [dressMemoInterfaceMgr startAnRequestByResKey:@"getGoodMap"
                                               needLogIn:NO
                                               withParam:param
                                              withMethod:@"GET"
                                                withData:NO];

    
}


#pragma mark -
#pragma mark my order
-(id)getProductOrderDetailGoodsList:(NSDictionary*)param
{
    //search_ordergoods
    //search_category
    //param = [self addUserIdParam:param];
    return [dressMemoInterfaceMgr startAnRequestByResKey:@"search_ordergoods"
                                               needLogIn:YES
                                               withParam:param
                                              withMethod:@"GET"
                                                withData:NO];

}
-(id)getProductOrderDetail:(NSDictionary*)param
{
    return [dressMemoInterfaceMgr startAnRequestByResKey:@"search_orderDetail"
                                               needLogIn:YES
                                               withParam:param
                                              withMethod:@"GET"
                                                withData:NO];

}
-(id)getProductsOrderList:(NSDictionary*)param
{
    //search_category
    param = [self addUserIdParam:param];
    return [dressMemoInterfaceMgr startAnRequestByResKey:@"search_orders_old"
                                               needLogIn:YES
                                               withParam:param
                                              withMethod:@"GET"
                                                withData:NO];
}
-(id)getProductsOrderListOld:(NSDictionary*)param
{
    param = [self addUserIdParam:param];
    return [dressMemoInterfaceMgr startAnRequestByResKey:@"search_orders_old"
                                               needLogIn:YES
                                               withParam:param
                                              withMethod:@"GET"
                                                withData:NO];


}
-(id)getProductsOrderListNew:(NSDictionary*)param
{
    param = [self addUserIdParam:param];
    return [dressMemoInterfaceMgr startAnRequestByResKey:@"search_orders_month"
                                               needLogIn:YES
                                               withParam:param
                                              withMethod:@"GET"
                                                withData:NO];
    
    
}

/**
 order_id
 */

-(id)cancelProductOrder:(NSDictionary*)param
{
    param = [self addUserIdParam:param];
    return [dressMemoInterfaceMgr startAnRequestByResKey:@"delete_order"
                                               needLogIn:YES
                                               withParam:param
                                              withMethod:@"POST"
                                                withData:NO];

}
-(id)getOrderDelivery:(NSDictionary*)param
{
    param = [self addUserIdParam:param];
    return [dressMemoInterfaceMgr startAnRequestByResKey:@"search_delivery"
                                               needLogIn:YES
                                               withParam:param
                                              withMethod:@"GET"
                                                withData:NO];

}
-(id)newProductOrder:(NSDictionary*)param
{
//    param = [self addUserIdParam:param];
    return [dressMemoInterfaceMgr startAnRequestByResKey:@"new_order"
                                               needLogIn:YES
                                               withParam:param
                                              withMethod:@"POST"
                                                withData:NO];
}
/*
 order_id
 订单ID
 必须
 *search_deliveryDetail
 */
-(id)getOrderDeliveryDetail:(NSDictionary *)param
{

    return [dressMemoInterfaceMgr startAnRequestByResKey:@"search_deliveryDetail"
                                               needLogIn:YES
                                               withParam:param
                                              withMethod:@"GET"
                                                withData:NO];
}
#pragma mark -
#pragma mark pay
-(id)orderPay:(NSDictionary*)param
{

    return [dressMemoInterfaceMgr startAnRequestByResKey:@"pay"
                                               needLogIn:YES
                                               withParam:param
                                              withMethod:@"POST"
                                                withData:NO];

}
@end
