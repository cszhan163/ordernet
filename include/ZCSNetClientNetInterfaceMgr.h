//
//  ZCSNetClientNetInterfaceMgr.h
//  DressMemo
//
//  Created by  on 12-6-26.
@class ZCSNetClient;

@protocol ZCSNetClientNetInterfaceMgrDataSource <NSObject>
@required
-(NSDictionary*)getUserLoginData;
@optional
@end
@protocol ZCSNetClientNetInterfaceMgrDelegate <NSObject>
@optional
-(void)didLoginUser:(ZCSNetClient*)sender withLoginUserData:(NSDictionary*)data;
-(void)didServerRespond:(ZCSNetClient*)sender withErrorData:(NSDictionary*)data;
-(void)didRequestRespond:(ZCSNetClient*)sender withErrorData:(NSDictionary*)data;
- (void)didGetRawRespond:(ZCSNetClient*)sender withRawData:(NSData*)data;
@end

@interface ZCSNetClientNetInterfaceMgr : NSObject

@property(nonatomic,retain)NSDictionary *requestResourceDict;
@property(nonatomic,assign)id<ZCSNetClientNetInterfaceMgrDataSource> netInterfaceDataSource;
@property(nonatomic,assign)id<ZCSNetClientNetInterfaceMgrDelegate> netInterfaceDelegate;

+(id)getSingleTone;
-(BOOL)isLoginStatus;
- (void)setRequestUrl:(NSString*)url;
-(NSString*)startAnRequestByKey:(NSString*)requestKey withParam:(NSDictionary*)params withMethod:(NSString*)method;
-(NSString*)startAnRequestByResKey:(NSString*)resKey needLogIn:(BOOL)needLogin withParam:(NSDictionary*)params withMethod:(NSString*)method;

-(id)startAnRequestByResKey:(NSString*)resKey needLogIn:(BOOL)needLogin withParam:(NSDictionary*)params withMethod:(NSString*)method withData:(BOOL)hasData;
-(id)startAnRequestByResKey:(NSString*)resKey needLogIn:(BOOL)needLogin withParam:(NSDictionary*)params withMethod:(NSString*)method withData:(BOOL)hasData withFileName:(NSString*)fileName;
@end
