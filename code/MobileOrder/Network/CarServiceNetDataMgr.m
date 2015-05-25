//
//  DressMemoNetDataMgr.m
//  DressMemo
//
//  Created by  on 12-6-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CarServiceNetDataMgr.h"
#import "ZCSNetClientNetInterfaceMgr.h"
#import "ZCSNetClientConfig.h"
#import "ZCSNetClient.h"
#import "ZCSNotficationMgr.h"
//#import "JQConnect_bsteelPay.h"
//#import "AppSetting.h"
//#import <iPlat4M_framework/iPlat4M_framework.h>
//#import "AppConfig_bak.h"
@interface CarServiceNetDataMgr()
@property(nonatomic,retain)NSMutableDictionary *requestResourceDict;
//@property(nonatomic,assign)BOOL isUserLogOut;
@end
static CarServiceNetDataMgr *sharedInstance = nil;
static ZCSNetClientNetInterfaceMgr *dressMemoInterfaceMgr = nil;
@implementation CarServiceNetDataMgr
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
                                               
                                               @"login",        kNetLoginRes,
                                               @"register",             kNetResignRes,
                                               @"search_goods", @"getgoodslist",
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
                                               @"getDetailByDay",@"getDetailByDay",
                                               @"getInfoByMonth",@"getInfoByMonth",
                                               @"check",@"check",
                                               nil];
        dressMemoInterfaceMgr.requestResourceDict = requestResouceMapDict;
        
        dressMemoInterfaceMgr.netInterfaceDataSource = self;
        dressMemoInterfaceMgr.netInterfaceDelegate = self;
        //requestResourceDict = [[NSMutableDictionary alloc]init];
#if 0
        [ZCSNotficationMgr addObserver:self call:@selector(didGetDataFromNet:) msgName:kZCSNetWorkOK];
        [ZCSNotficationMgr addObserver:self call:@selector(didGetDataFromNetFailed:) msgName:kZCSNetWorkRequestFailed];
#endif
        //dbMgr = [DBManage getSingleTone];
    }
    return self;
}
#pragma mark -
#pragma mark -common
- (id)sendRequest:(NSString*)method withVersion:(NSString*)ver withParam:(NSDictionary*)param
         withOkBack:(SEL)okCallBackFun  withFailedBack:(SEL)failedBack
{
    /*
    JQConnect_bsteelPay *connect = [[JQConnect_bsteelPay alloc] initWithDelegate:self successCallBack:okCallBackFun failedCallBack:failedBack andMethodName:[NSString stringWithFormat:@"%@_%@",method,ver]];
    for (id key in param) {
        [connect addParam:[param objectForKey:key] forKey:key];
    }
    [connect sendRequest];
    return  connect;
     */
    return nil;
     
}

- (void)sendFinalOkData:(id)data withKey:(NSString*)key{
    
#if OneLine
    id tempData = [data objectForKey:@"result"];
    if(tempData == nil){
        /*
        NSLog(@"return data framework  error,no result key");
        assert(tempData);
         */
    }
    if([tempData isKindOfClass:[NSString class]]){
        //data = [tempData JSONValue];
        NSError *error = nil;
        tempData = [tempData stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
        tempData = [tempData stringByReplacingOccurrencesOfString:@"\r" withString:@"\\r"];
        tempData = [tempData stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
        data = [NSJSONSerialization JSONObjectWithData:[tempData dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if(error){
            NSLog(@"error json data error");
        }
        //assert(error!=nil);
    }
    else if(tempData){
        data = tempData;
    }
    
    //data = [data objectForKey:@"data"];
#else
    
#endif
    /*
     {"code":"4003","messsage":"requncname: /app/ZYgetSourceList_v1 post data is not available.","name":"SessionNotFound"}

     */
    NSDictionary *item = [NSDictionary dictionaryWithObjectsAndKeys:
                          data,@"data",
                          key,@"key",
                          nil];
    [ZCSNotficationMgr postMSG:kZCSNetWorkOK obj:item];
}
- (void)sendFinalFailedData:(id)data withKey:(NSString*)key{
    NSDictionary *item = [NSDictionary dictionaryWithObjectsAndKeys:
                          data,@"data",
                          key,@"key",
                          nil];
    [ZCSNotficationMgr postMSG:kZCSNetWorkRequestFailed obj:item];
}
#pragma mark -
#pragma mark - info 
//
- (void)getHgbZXInfoDetail:(NSDictionary*)param{
    /*
     systemId
     接口访问的系统来源
     zxid
     资讯ID

     
     */
    if(param == nil){
        param = [NSDictionary dictionaryWithObjectsAndKeys:
                 @"001",@"systemId",
                 @"10",@"zxid",
                 nil];
    }
    [self sendRequest:@"getHgbZXInfoDetail" withVersion:kUrlVer withParam:param withOkBack:@selector(getHgbZXInfoDetailOk:) withFailedBack:@selector(getHgbZXInfoDetailFailed:)];
}
- (void)getHgbZXInfoDetailOk:(NSString*)result{
    
    id data = [result JSONValue];
    
    NSDictionary  *finalData = nil;
    finalData = data;
    [self sendFinalOkData:finalData withKey:kResNoteInfoDetail];
}
- (void)getHgbZXInfoDetailFailed:(NSString*)error{
    
}

- (void)getHgbZXInfoList:(NSDictionary*)param{
    /*
     zxsearchstr
     检索内容
     limit
     一页的数据条数
     offset
     第几页
     
     */
    if(param == nil){
        param = [NSDictionary dictionaryWithObjectsAndKeys:
                 @"苯酚",@"zxsearchstr",
                 @"10",@"limit",
                 @"1",@"offset",
                 nil];
    }
    [self sendRequest:@"getHgbZXInfoList" withVersion:kUrlVer withParam:param withOkBack:@selector(getHgbZXInfoListOk:) withFailedBack:@selector(getHgbZXInfoListFailed:)];
}
- (void)getHgbZXInfoListOk:(NSString*)result{
    
    id data = [result JSONValue];
    
    NSDictionary  *finalData = nil;
    finalData = data;
    [self sendFinalOkData:finalData withKey:kResNoteInfoData];
    
}
- (void)getHgbZXInfoListFailed:(NSString*)error{
    
}
- (void)getHgbZXTitleSearch:(NSDictionary*)param{
    /*
     zxsearchstr
     检索内容
     limit
     一页的数据条数
     offset
     第几页
     
     */
    if(param == nil){
        param = [NSDictionary dictionaryWithObjectsAndKeys:
                 @"苯酚",@"zxsearchstr",
                 @"10",@"limit",
                 @"1",@"offset",
                 nil];
    }
    [self sendRequest:@"getHgbZXTitleSearch" withVersion:kUrlVer withParam:param withOkBack:@selector(getHgbZXTitleSearchOk:) withFailedBack:@selector(getHgbZXTitleSearchFailed:)];
}
- (void)getHgbZXTitleSearchOk:(NSString*)result{
    
    id data = [result JSONValue];
    
    NSDictionary  *finalData = nil;
    finalData = data;
    [self sendFinalOkData:finalData withKey:kResNoteSearchData];
}
- (void)getHgbZXTitleSearchFailed:(NSString*)error{
    
}

//getHgbZXReportList
- (void)getHgbZXReportList:(NSDictionary*)param{
    /*
     zxsearchstr
     检索内容
     limit
     一页的数据条数
     offset
     第几页
     
     */
    if(param == nil){
        param = [NSDictionary dictionaryWithObjectsAndKeys:
                 @"苯酚",@"zxsearchstr",
                 @"10",@"limit",
                 @"1",@"offset",
                 nil];
    }
    [self sendRequest:@"getHgbZXReportList" withVersion:kUrlVer withParam:param withOkBack:@selector(getHgbZXReportListOk:) withFailedBack:@selector(getHgbZXReportListFailed:)];
}
- (void)getHgbZXReportListOk:(NSString*)result{
    
    id data = [result JSONValue];
    
    NSDictionary  *finalData = nil;
    finalData = data;
    [self sendFinalOkData:finalData withKey:kResNoteSearchData];
}
- (void)getHgbZXReportListFailed:(NSString*)error{
    
}

#pragma mark -
#pragma mark -public New
- (void)querySitePubmsg4Move:(NSDictionary*)param{
    
   
    
    [self sendRequest:@"querySitePubmsg4Move" withVersion:kUrlVer withParam:param withOkBack:@selector(querySitePubmsg4MoveOK:) withFailedBack:@selector(querySitePubmsg4MoveFailed:)];
}
- (void)querySitePubmsg4MoveOK:(NSString*)result{
    
    id data = [result JSONValue];
    
    NSDictionary  *finalData = nil;
    finalData = data;
    [self sendFinalOkData:finalData withKey:kResNoteNewsData];
}
- (void)querySitePubmsg4MoveFailed:(NSString*)error{
    
}
- (void)getBidPubmsgById4Move:(NSDictionary*)param{

    /*
     公告ID	ggid
     会员代码	hydm
     */
    if(param == nil){
    param = [NSDictionary dictionaryWithObjectsAndKeys:
             @"0",@"ggid",
             @"0",@"hydm",
             nil];
    }
    [self sendRequest:@"getBidPubmsgById4Move" withVersion:kUrlVer withParam:param withOkBack:@selector(getBidPubmsgById4MoveOk:) withFailedBack:@selector(getBidPubmsgById4MoveFailed:)];
}
- (void)getBidPubmsgById4MoveOk:(NSString*)result{
    
    id data = [result JSONValue];
    
    NSDictionary  *finalData = nil;
    finalData = data;
    [self sendFinalOkData:finalData withKey:kResNoteBidDetail];
}
- (void)getBidPubmsgById4MoveFailed:(NSString*)error{
    
}

//getSitePubmsgById4Move
- (void)getSitePubmsgById4Move:(NSDictionary*)param{
    
    /*
     公告ID	ggid
     会员代码	hydm
     */
    if(param == nil){
        param = [NSDictionary dictionaryWithObjectsAndKeys:
                 @"0",@"ggid",
                 @"0",@"hydm",
                 nil];
    }
    [self sendRequest:@"getSitePubmsgById4Move" withVersion:kUrlVer withParam:param withOkBack:@selector(getSitePubmsgById4MoveOk:) withFailedBack:@selector(getSitePubmsgById4MoveFailed:)];
}
- (void)getSitePubmsgById4MoveOk:(NSString*)result{
    
    id data = [result JSONValue];
    
    NSDictionary  *finalData = nil;
    finalData = data;
    [self sendFinalOkData:finalData withKey:kResNoteNewsDetail];
}
- (void)getSitePubmsgById4MoveFailed:(NSString*)error{
    
}
#pragma mark -
#pragma mark -bid
- (void)queryBidPubmsg4Move:(NSDictionary*)param{

    /*
     调用资源接口参数	参数名称	参数类型	备注	 (参数值)
     gglx	公告类型		0  交易预告
     1  竞价公告
     2  市场公告
     zc	专场类型（循环物资，钢材正品）		1 钢材正品
     2 循环物资
     limit	数据条数默认10条
     offset	第几页
     */
    if(param == nil){
        param = [NSDictionary dictionaryWithObjectsAndKeys:
                 @"0",@"gglx",
                 @"0",@"zc",
                 @"10",@"limit",
                 @"1",@"offset",
                 nil];
    }
    [self sendRequest:@"queryBidPubmsg4Move" withVersion:kUrlVer withParam:param withOkBack:@selector(queryBidPubmsg4MoveOk:) withFailedBack:@selector(queryBidPubmsg4MoveFailed:)];

}
- (void)queryBidPubmsg4MoveOk:(NSString*)result{
  
    id data = [result JSONValue];
    
    NSDictionary  *finalData = nil;
    finalData = data;
    [self sendFinalOkData:finalData withKey:kResNoteBidData];

}
- (void)queryBidPubmsg4MoveFailed:(NSString*)error{

}

- (void)queryAuctionPps4Move:(NSDictionary*)param{
    /*
    
     hydm	会员代码
     zc	专场代码
     wtzt	场次状态
     limit	数据条数默认10条
     offset	第几页
     rqStart	竞价日期1
     rqEnd	竞价日期2
     */
    if(param == nil){
        param = [NSDictionary dictionaryWithObjectsAndKeys:
             @"001",@"hydm",
             @"10",@"limit",
             @"1",@"offset",
             nil];
    }
    [self sendRequest:@"queryAuctionPps4Move" withVersion:kUrlVer withParam:param withOkBack:@selector(queryAuctionPps4MoveOk:) withFailedBack:@selector(queryAuctionPps4MoveFailed:)];


}
- (void)queryAuctionPps4MoveII:(NSDictionary*)param{
    /*
     
     hydm	会员代码
     zc	专场代码
     wtzt	场次状态
     limit	数据条数默认10条
     offset	第几页
     rqStart	竞价日期1
     rqEnd	竞价日期2
     */
    if(param == nil){
        param = [NSDictionary dictionaryWithObjectsAndKeys:
                 @"001",@"hydm",
                 @"10",@"limit",
                 @"1",@"offset",
                 nil];
    }
    [self sendRequest:@"queryAuctionPps4Move" withVersion:kUrlVer withParam:param withOkBack:@selector(queryAuctionPps4MoveIIOk:) withFailedBack:@selector(queryAuctionPps4MoveIIFailed:)];
    
    
}
- (void)queryAuctionPps4MoveIIOk:(NSString*)result{

    id data = [result JSONValue];
    
    NSDictionary  *finalData = nil;
    finalData = data;
    [self sendFinalOkData:finalData withKey:kResBidAllListDataII];

}
- (void)queryAuctionPps4MoveIIFailed:(NSString*)error{
    id data = [error JSONValue];
    
    NSDictionary  *finalData = nil;
    finalData = data;
    [self sendFinalFailedData:finalData withKey:kResBidAllListDataII];
}
- (void)queryAuctionPps4MoveOk:(NSString*)result{
    
#if 0
    [NSJSONSerialization )JSONObjectWithData:(NSData *)data options:(NSJSONReadingOptions)opt error:(NSError **)error;];
#else
    id data = [result JSONValue];

    NSDictionary  *finalData = nil;
#if 0
    NSMutableArray *key_value_array = [NSMutableArray array];
    for(id key in data){
        
        id value = [data  objectForKey:key];
        /*
        if([value  isKindOfClass:[NSArray Class]]){
            
        }
        */
        [key_value_array addObject:key];
        [key_value_array addObject:value];
    }
    NSMutableArray *finalDataArray = [NSMutableArray array];
    int itemNumber = [key_value_array count]/2;
    for(int i = 0;i< itemNumber;i++){
        NSMutableDictionary *item =[NSMutableDictionary dictionary];
        [finalDataArray addObject:item];
    }
    for(int i = 0;i< itemNumber;i=i+2){
        NSString *key = key_value_array[i];
        int itemCount  = [key_value_array[i+1] count];
        id value  = nil;
        for(int j = 0;j<itemCount;j++){
           value  = [key_value_array[i+1] objectAtIndex:j];
            [finalDataArray[j] setValue:value forKey:key];
        }
    }
    data = finalDataArray;
    finalData = [NSDictionary dictionaryWithObject:data forKey:@"data"];
#else
    finalData = data;
#endif
    
#endif
    
    [self sendFinalOkData:finalData withKey:kResBidAllListData];
}
- (void)queryAuctionPps4MoveFailed:(NSString*)error{
    [self sendFinalFailedData:error withKey:kResBidAllListData];
}
- (void)queryAuctionWts4Move:(NSDictionary*)param{
    /*
     
     hydm	会员代码
     zc	专场代码
     wtzt	场次状态
     limit	数据条数默认10条
     offset	第几页
     rqStart	竞价日期1
     rqEnd	竞价日期2
     */
    if(param == nil){
        param = [NSDictionary dictionaryWithObjectsAndKeys:
                 @"001",@"hydm",
                 @"1",@"zc",
                 @"001",@"wtzt",
                 @"10",@"limit",
                 @"1",@"offset",
                 @"",@"rqStart",
                 @"",@"rqEnd",
                 
                 nil];
    }
    [self sendRequest:@"queryAuctionWts4Move" withVersion:kUrlVer withParam:param withOkBack:@selector(queryAuctionWts4MoveOk:) withFailedBack:@selector(queryAuctionWts4MoveFailed:)];
    
    
}
- (void)queryAuctionWts4MoveOk:(NSString*)result{
    
    id data = [result JSONValue];
    
    NSDictionary  *finalData = nil;
    finalData = data;
    [self sendFinalOkData:finalData withKey:kResBidListData];
}
- (void)queryAuctionWts4MoveFailed:(NSString*)error{
    
    [self sendFinalFailedData:error withKey:kResBidListData];
}

- (void)queryAuctionPpInfo4Move:(NSDictionary*)param{

    /*
     hydm	会员代码
     limit	数据条数默认10条
     offset	第几页
     
     */
    if(param == nil){
        param = [NSDictionary dictionaryWithObjectsAndKeys:
                 @"001",@"hydm",
                 @"10",@"id",
                 //@"1",@"offset",
                 nil];
    }
    [self sendRequest:@"queryAuctionPpInfo4Move" withVersion:kUrlVer withParam:param withOkBack:@selector(queryBidDetailOk:) withFailedBack:@selector(queryBidDetailFailed:)];
}
- (void)queryBidDetailOk:(NSString*)result{

    id data = [result JSONValue];
    
    NSDictionary  *finalData = nil;
    finalData = data;
    [self sendFinalOkData:finalData withKey:kResBidItemData];
}
- (void)queryBidDetailFailed:(NSString*)error{

    [self sendFinalFailedData:error withKey:kResBidItemData];
}

- (void)getAuctionWtInfo:(NSDictionary*)param{

    /*
     hydm	会员代码
     limit	数据条数默认10条
     offset	第几页
     
     */
    if(param == nil){
    param = [NSDictionary dictionaryWithObjectsAndKeys:
             @"001",@"wtid",
             //@"10",@"id",
             //@"1",@"offset",
             nil];
    }
    [self sendRequest:@"getAuctionWtInfo" withVersion:kUrlVer withParam:param withOkBack:@selector(getAuctionWtInfoOk:) withFailedBack:@selector(getAuctionWtInfoFailed:)];
}
- (void)getAuctionWtInfoOk:(NSString*)result{
    
    id data = [result JSONValue];
    
    NSDictionary  *finalData = nil;
    finalData = data;
    [self sendFinalOkData:finalData withKey:kResBidItemData];
}
- (void)getAuctionWtInfoFailed:(NSString*)error{
    
    [self sendFinalFailedData:error withKey:kResBidItemData];
}
//
- (void)saveAuction4MoveDetail:(NSDictionary*)param{
    
    
    /*
     hydm	会员代码
     limit	数据条数默认10条
     offset	第几页
     
     */
    if(param == nil){
        param = [NSDictionary dictionaryWithObjectsAndKeys:
                 @"001",@"wtid",
                 //@"10",@"id",
                 //@"1",@"offset",
                 nil];
    }
    [self sendRequest:@"saveAuction4Move" withVersion:kUrlVer withParam:param withOkBack:@selector(saveAuction4MoveDetailOk:) withFailedBack:@selector(saveAuction4MoveDetailFailed:)];
    
}
- (void)saveAuction4MoveDetailOk:(NSString*)result{
    id data = [result JSONValue];
    
    NSDictionary  *finalData = nil;
    finalData = data;
    [self sendFinalOkData:finalData withKey:kResBidDetailSaveData];
}
- (void)saveAuction4MoveDetailFailed:(NSString*)error{
    
    [self sendFinalFailedData:error withKey:kResBidDetailSaveData];
}

- (void)saveAuction4Move:(NSDictionary*)param{

    
    /*
     hydm	会员代码
     limit	数据条数默认10条
     offset	第几页
     
     */
    if(param == nil){
        param = [NSDictionary dictionaryWithObjectsAndKeys:
                 @"001",@"wtid",
                 //@"10",@"id",
                 //@"1",@"offset",
                 nil];
    }
    [self sendRequest:@"saveAuction4Move" withVersion:kUrlVer withParam:param withOkBack:@selector(saveAuction4MoveOk:) withFailedBack:@selector(saveAuction4MoveFailed:)];

}
- (void)saveAuction4MoveOk:(NSString*)result{
    id data = [result JSONValue];
    
    NSDictionary  *finalData = nil;
    finalData = data;
    [self sendFinalOkData:finalData withKey:kResBidSaveData];
}
- (void)saveAuction4MoveFailed:(NSString*)error{
    
    [self sendFinalFailedData:error withKey:kResBidSaveData];
}

- (void)quitWt4Move:(NSDictionary*)param{

    /*
     hydm	会员代码
     limit	数据条数默认10条
     offset	第几页
     
     */
    if(param == nil){
        param = [NSDictionary dictionaryWithObjectsAndKeys:
                 @"001",@"wtid",
                 //@"10",@"id",
                 //@"1",@"offset",
                 nil];
    }
    [self sendRequest:@"quitWt4Move" withVersion:kUrlVer withParam:param withOkBack:@selector(quitWt4MoveOk:) withFailedBack:@selector(quitWt4MoveFailed:)];

}
- (void)quitWt4MoveOk:(NSString*)result{
    id data = [result JSONValue];
    
    NSDictionary  *finalData = nil;
    finalData = data;
    [self sendFinalOkData:finalData withKey:kResBidQuit];
}
- (void)quitWt4MoveFailed:(NSString*)error{
    
    [self sendFinalFailedData:error withKey:kResBidQuit];
}
#pragma mark -
#pragma mark agreement 

- (void)showAgreement4Move:(NSDictionary*)param{
    
    /*
     接口参数	参数名称
     wtid	场次号
     hydm	会员代码
     *
     */
    if(param == nil){
        param = [NSDictionary dictionaryWithObjectsAndKeys:
                 @"001",@"hydm",
                 @"",@"wtid",
                 
                 nil];
    }
    [self sendRequest:@"showAgreement4Move" withVersion:kUrlVer withParam:param withOkBack:@selector(showAgreement4MoveOk:) withFailedBack:@selector(showAgreement4MoveFailed:)];
}
- (void)showAgreement4MoveOk:(NSString*)result{
    
    id data = [result JSONValue];
    
    NSDictionary  *finalData = nil;
    finalData = data;
    [self sendFinalOkData:finalData withKey:kResBidAgreementData];
}
- (void)showAgreement4MoveFailed:(NSString*)error{
    
    [self sendFinalFailedData:error withKey:kResBidAgreementData];
}
- (void)joinBuy4Move:(NSDictionary*)param{
    
    /*
     wtid	场次号
     hydm	会员代码
     czy	操作员代码
     *
     */
    if(param == nil){
        param = [NSDictionary dictionaryWithObjectsAndKeys:
                 @"001",@"hydm",
                 @"",@"wtid",
                 @"",@"czy",
                 nil];
    }
    [self sendRequest:@"joinBuy4Move" withVersion:kUrlVer withParam:param withOkBack:@selector(joinBuy4MoveOk:) withFailedBack:@selector(joinBuy4MoveFailed:)];
}
- (void)joinBuy4MoveOk:(NSString*)result{
    
    id data = [result JSONValue];
    
    NSDictionary  *finalData = nil;
    finalData = data;
    [self sendFinalOkData:finalData withKey:kResBidAgreeAction];
}
- (void)joinBuy4MoveFailed:(NSString*)error{
    
    [self sendFinalFailedData:error withKey:kResBidAgreeAction];
}
#pragma mark -
#pragma mark user

- (id)carUserLogin:(NSDictionary *)param{

    /*
     *
     */
    if(param == nil){
        param = [NSDictionary dictionaryWithObjectsAndKeys:
                 @"001",@"hydm",
                 nil];
    }
    [self sendRequest:@"HgbLogin" withVersion:kUrlVer withParam:param withOkBack:@selector(carUserLoginOk:) withFailedBack:@selector(carUserLoginFailed:)];
    return nil;
}

- (void)getUserAccountInfo:(NSDictionary *)param
{
    //getHydmByLoginName
       [self sendRequest:@"getHydmByLoginName" withVersion:kUrlVer withParam:param withOkBack:@selector(getUserAccountInfoOk:) withFailedBack:@selector(getUserAccountInfoFailed:)];
}

- (void)getUserAccountInfoOk:(NSString*)result{
    
    id data = [result JSONValue];
    
    NSDictionary  *finalData = nil;
    finalData = data;
    [self sendFinalOkData:finalData withKey:kResUserInfoData];
}
- (void)getUserAccountInfoFailed:(NSString*)error{
    
    [self sendFinalFailedData:error withKey:kResUserInfoData];
}


- (void)carUserLoginOk:(NSString*)result{
    
    id data = [result JSONValue];
    
    NSDictionary  *finalData = nil;
    finalData = data;
    [self sendFinalOkData:finalData withKey:kNetLoginRes];
}
- (void)carUserLoginFailed:(NSString*)error{
    
    [self sendFinalFailedData:error withKey:kNetLoginRes];
}
- (void)getAccountInfo:(NSDictionary*)param{
    
    /*
     *
     */
    if(param == nil){
    param = [NSDictionary dictionaryWithObjectsAndKeys:
             @"001",@"hydm",
             nil];
    }
    [self sendRequest:@"getAccountInfo" withVersion:kUrlVer withParam:param withOkBack:@selector(getAccountInfoOk:) withFailedBack:@selector(getAccountInfoFailed:)];
}
- (void)getAccountInfoOk:(NSString*)result{
    
    id data = [result JSONValue];
    
    NSDictionary  *finalData = nil;
    finalData = data;
    [self sendFinalOkData:finalData withKey:kCarUserInfo];

}
- (void)getAccountInfoFailed:(NSString*)error{
    id data = [error JSONValue];
    
    NSDictionary  *finalData = nil;
    finalData = data;
    [self sendFinalFailedData:finalData withKey:kCarUserInfo];
}

- (id)getOrderList:(NSDictionary*)param{

    /*
     *
     */
    if(param == nil){
    param = [NSDictionary dictionaryWithObjectsAndKeys:
             @"001",@"hydm",
             @"10",@"limit",
             @"1",@"offset",
             nil];
    }
    return [self sendRequest:@"getOrderList" withVersion:kUrlVer withParam:param withOkBack:@selector(getOrderListOk:) withFailedBack:@selector(getOrderListFailed:)];

}
- (id)getOrderListConfirmed:(NSDictionary*)param{

    
    return [self sendRequest:@"getOrderList" withVersion:kUrlVer withParam:param withOkBack:@selector(getConfirmedOrderListOk:) withFailedBack:@selector(getConfirmedOrderListFailed:)];
    
}
- (void)getConfirmedOrderListOk:(NSString*)result{

    NSDictionary  *finalData = nil;
    id data = [result JSONValue];
    finalData = data;
    [self sendFinalOkData:finalData withKey:kCarUserOrderComfirmedList];
    
}
- (void)getConfirmedOrderListFailed:(NSString*)result{

}
- (void)getOrderListOk:(NSString*)result{
    id data = [result JSONValue];
    
    NSDictionary  *finalData = nil;
    finalData = data;
    [self sendFinalOkData:finalData withKey:kCarUserOrderList];
}
- (void)getOrderListFailed:(NSString*)error{
    
}
- (void)getOrderDetail:(NSDictionary*)param{
    if(param == nil){
        param = [NSDictionary dictionaryWithObjectsAndKeys:
                 @"001",@"orderId",
                 nil];
    }
    [self sendRequest:@"getOrderDetail" withVersion:kUrlVer withParam:param withOkBack:@selector(getOrderDetailOk:) withFailedBack:@selector(getOrderDetailFailed:)];
    
}
- (void)getOrderDetailOk:(NSString*)result{
    id data = [result JSONValue];
    
    NSDictionary  *finalData = nil;
    finalData = data;
    [self sendFinalOkData:finalData withKey:kCarUserOrderDetail];
}
- (void)getOrderDetailFailed:(NSString*)error{
    
}
- (void)updateStatus4Move:(NSDictionary*)param{

    if(param == nil){
        param = [NSDictionary dictionaryWithObjectsAndKeys:
                 @"001",@"orderId",
                 nil];
    }
    [self sendRequest:@"updateStatus4Move" withVersion:kUrlVer withParam:param withOkBack:@selector(updateStatus4MoveOk:) withFailedBack:@selector(updateStatus4MoveFailed:)];
}
- (void)updateStatus4MoveOk:(NSString*)result{
    id data = [result JSONValue];
    
    NSDictionary  *finalData = nil;
    finalData = data;
    [self sendFinalOkData:finalData withKey:kResUserOrderConfirm];
}
- (void)updateStatus4MoveFailed:(NSString*)error{
    
}

@end
