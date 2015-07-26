//
//  DressMemoNetDataMgr.h
//  DressMemo
//
//  Created by  on 12-6-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCSNetClientDataMgr.h"
@protocol ZCSNetClientNetInterfaceMgrDataSource;
@protocol ZCSNetClientNetInterfaceMgrDelegate;
@interface MobileOrderNetDataMgr : NSObject<ZCSNetClientNetInterfaceMgrDataSource,
ZCSNetClientNetInterfaceMgrDelegate>

- (id)openSession;
/*user*/
+(id)getSingleTone;
-(id)userLogin:(NSDictionary*)param;
-(id)userResign:(NSDictionary*)param;
-(id)userUser:(NSDictionary*)param;


/*order*/
- (id)getDingList:(NSDictionary*)param;
- (id)getProductsList:(NSDictionary*)param;
- (id)newOrder:(NSDictionary*)param;

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
