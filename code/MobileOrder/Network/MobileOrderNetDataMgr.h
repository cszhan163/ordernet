//
//  DressMemoNetDataMgr.h
//  DressMemo
//
//  Created by  on 12-6-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCSNetClientDataMgr.h"


#import <CommonCrypto/CommonDigest.h> // Need to import for CC_MD5 access

@protocol ZCSNetClientNetInterfaceMgrDataSource;
@protocol ZCSNetClientNetInterfaceMgrDelegate;


//#define  kRequestApiRoot                @"http://192.168.10.119:8081/pxdc/1.0/"//@"http://121.40.239.155/1.0/"
#define  kRequestApiRoot                           @"http://121.40.239.155/pxdc/1.0/"
//#define  kRequestApiRoot                           @"http://192.168.15.119:8081/pxdc/1.0/"


@interface NSString (MyExtensions)

- (NSString *) getMd5String;

@end


@interface MobileOrderNetDataMgr : NSObject<ZCSNetClientNetInterfaceMgrDataSource,
ZCSNetClientNetInterfaceMgrDelegate>

- (id)openSession;
/*user*/
+(id)getSingleTone;
-(id)userLogin:(NSDictionary*)param;
-(id)userResign:(NSDictionary*)param;
-(id)userUser:(NSDictionary*)param;


/*order*/
- (id)getDingList:(NSDictionary*) param;
- (id)getProductsList:(NSDictionary*) param;
- (id)newOrder:(NSDictionary*) param;
- (id)getRealTimeOrder:(NSDictionary*) data;

- (id)getOrderList:(NSDictionary*) param ;
- (id)getWaitingOrderList:(NSDictionary*)param;

- (id)newOrderCommnent:(NSDictionary*) param ;

-(id)userInfoUpdate:(NSDictionary*)param;
-(id)userResignRandomCode:(NSDictionary*)param;
-(id)userFavProducts:(NSDictionary*)param;
-(id)userResetPwdRadomCode:(NSDictionary*)param;
-(id)userResetPassword:(NSDictionary*)param;
-(id)userProfileIconUpdate:(NSDictionary*)param;
-(id)uploadUserPhoneContactorsPhoneNumber:(NSDictionary*)param;

/*good*/

-(id)getProductDetail:(NSDictionary*)param;
-(id)getProductDetailAd:(NSDictionary*)param;
-(id)getProductDetailMap:(NSDictionary*)param;

/*address*/
-(id)getUserContactAddress:(NSDictionary*)param;
-(id)addUserContactAddress:(NSDictionary*)param;
-(id)editUserContactAddress:(NSDictionary*)param;
-(id)getProvinceData:(NSDictionary*)param;
-(id)getCityData:(NSDictionary*)param;
-(id)getAreaData:(NSDictionary*)param;

-(id)cancelProductOrder:(NSDictionary*)param;
-(id)getOrderDelivery:(NSDictionary*)param;
-(id)newProductOrder:(NSDictionary*)param;
-(id)getOrderDeliveryDetail:(NSDictionary *)param;

/*ad*/
-(id)getHomePageAd:(NSDictionary*)param;
-(id)getProductAd:(NSDictionary*)param;
-(id)getProductMap:(NSDictionary*)param;

@end
