//
//  UserDinnerWatingMgr.m
//  MobileOrder
//
//  Created by cszhan on 15-7-19.
//  Copyright (c) 2015年 com.ximalaya. All rights reserved.
//

#import "UserDinnerWatingMgr.h"

#import <SMS_SDK/SMS_SDK.h>

#define kDinnerWaitingCheck   10.f

@interface UserDinnerWatingMgr(){

}

@property (nonatomic ,strong) NSTimer *timer;

@property (nonatomic, strong) OrderItem *orderItem;

@property (nonatomic, strong) OrderItem *userOrderItem;

@end

static UserDinnerWatingMgr *staticInstance = nil;



@implementation UserDinnerWatingMgr

+ (instancetype)sharedInstance {
    if(staticInstance == nil){
    
        staticInstance = [[self alloc]init];
    }
    return staticInstance;
}

- (void)dealloc {
    self.netDoneBlock = nil;
    self.netFailedBlcok = nil;
    [self stopTimer];
    self.orderItem = nil;
    SuperDealloc;
}

- (OrderItem*)getUserCurrentOrderItem {

    if(self.userOrderItem == nil){
    
        self.userOrderItem = [[OrderItem alloc]initWithDictionary:nil];
        
    }
    return self.userOrderItem;
}

- (id)init {

    if(self = [super init]){
    
        [ZCSNotficationMgr addObserver:self call:@selector(didNetWorkOK:) msgName:kZCSNetWorkOK];
        [ZCSNotficationMgr addObserver:self call:@selector(didNetWorkFailed:) msgName:
         kZCSNetWorkRespondFailed];
        [ZCSNotficationMgr addObserver:self call:@selector(didNetWorkFailed:) msgName:kZCSNetWorkConnectionFailed];
        [ZCSNotficationMgr addObserver:self call:@selector(didNetWorkFailed:) msgName:kZCSNetWorkRequestFailed];

    }
    return self;
}

- (void)startGetOrderListByStatus:(OrderStatus) status {
    /*
     order/list?status=0
     */
    
    [[MobileOrderNetDataMgr getSingleTone] getWaitingOrderList:@{@"status":[NSString stringWithFormat:@"%ld",status]}];
}


- (void)dinnerWaitingTimer:(id)userInfo{

    [self startCheckDinnerWaitingByOrderId:0];
    
}

- (void)stopTimer {

    [self.timer invalidate];
    self.timer = nil;
}

- (void)startDinnerWaitingCheck:(OrderItem*) orderItem {

    self.orderItem = orderItem;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:kDinnerWaitingCheck target:self selector:@selector(dinnerWaitingTimer:) userInfo:nil repeats:YES];
}

- (void)startCheckDinnerWaitingByOrderId:(long long)orderId {

    [[MobileOrderNetDataMgr getSingleTone] getRealTimeOrder:nil];
}



-(void)didNetDataOK:(NSNotification*)ntf {
    
}

- (void)didNetWorkOK:(NSNotification*) ntf {

    id obj = [ntf object];
    id respRequest = [obj objectForKey:@"request"];
    id objData = [obj objectForKey:@"data"];
    NSString *resKey = [respRequest resourceKey];
    //NSString *resKey = [respRequest resourceKey];
    if([resKey isEqualToString:@"waitingOrderList"])
    {
        //        if ([self.externDelegate respondsToSelector:@selector(commentDidSendOK:)]) {
        //            [self.externDelegate commentDidSendOK:self];
        //        }
        //        kNetEndSuccStr(@"评论成功",self.view);
        //        [self dismissModalViewControllerAnimated:YES];
#if 0
        [self reloadNetData:data];
#else
        //        if([[data objectForKey:@"data"] count]<10.f){
        //            isRefreshing = YES;
        //        }
        
        NSDictionary *data = objData;
        NSLog(@"waitingOrderData:%@",[data description]);
#endif
        //self.dataArray = [data objectForKey:@"data"];
        //        if([[data objectForKey:@"data"]count])
        //            self.pageNum = self.pageNum +1;
        //[self performSelectorOnMainThread:@selector(updateUIData:) withObject:data waitUntilDone:NO];
        
        if(self.netDoneBlock) {
            
            self.netDoneBlock(data);
            self.netDoneBlock = nil;
            self.netFailedBlcok = nil;
            //self.netDoneBlock = nil;
        }
        

    }
    if([resKey isEqualToString:@"realtime"]) {
    
        NSDictionary *data = objData;
        NSLog(@"realTimer OrderData:%@",[data description]);
        
        [ZCSNotficationMgr postMSG:kRealTimerOrderDataGetMSG obj:data];
        if(self.netDoneBlock) {
            
            self.netDoneBlock(data);
            self.netDoneBlock  = nil;
            self.netFailedBlcok = nil;
        }

    }
}

- (void)didNetWorkFailed:(NSNotification*) ntf {

    id obj = [ntf object];
    id respRequest = [obj objectForKey:@"request"];
    id objData = [obj objectForKey:@"data"];
    NSString *resKey = [respRequest resourceKey];
    //NSString *resKey = [respRequest resourceKey];
    //if([resKey isEqualToString:@"waitingOrderList"])
    {
    
        if(self.netFailedBlcok) {
        
            self.netFailedBlcok(nil);
            self.netDoneBlock = nil;
        }
    }
    
}

- (void)startGetRegisterUserSMSWithDone:(CompleteBlock) done {

    [SMS_SDK registerApp:@"98c5ef522a08" withSecret:@"8cc3b30270a8ad8c76f3fac4e6db5fe7"];
    [SMS_SDK getVerificationCodeBySMSWithPhone:@"18616643372" zone:@"86" result:^(SMS_SDKError *smsError){
       
        NSError *error = nil;
        if(smsError){
            kUIAlertViewNoDelegate(@"提示", smsError.errorDescription);
            error = [NSError errorWithDomain:@"" code:smsError.code userInfo:@{@"description":smsError.errorDescription}];
        }
        if(done){
            
            done(error);
        }
    }];
    
}

- (void)startVeryRegisterUserSMS:(NSDictionary*)param withDone:(CompleteBlock) done withError:(CompleteBlock) errorDone{

    NSMutableDictionary *finaParam = [NSMutableDictionary dictionaryWithDictionary:param];
    
    [finaParam setValue:@"98c5ef522a08" forKey:@"appkey"];
    [finaParam setValue:@"86" forKey:@"zone"];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://api.sms.mob.com/sms/verify"]
                                                cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:15];
    //[urlRequest setValue:@"application/www-url" forHTTPHeaderField:@"Content-Type"];
    [urlRequest setHTTPMethod:@"POST"];
    NSMutableString *finalStr = [NSMutableString string];
    for(id key in finaParam){
        id value = [finaParam objectForKey:key];
        [finalStr appendFormat:@"&%@=%@",key,value];
        
    }
    [urlRequest setHTTPBody:[finalStr dataUsingEncoding:NSUTF8StringEncoding]];
    
#if 1
    NSURLSession *urlSession = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *sessionTask = [urlSession dataTaskWithRequest:urlRequest  completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if(error){
        
             NSError *error = [NSError errorWithDomain:@"Network" code:-100 userInfo:@{}];
            if(error){
                errorDone(error);
            }
            if(done){
                done(nil);
            }
        }else {
        
            if([(NSHTTPURLResponse*)response statusCode]==200){
            
                if(error){
                    
                    errorDone(nil);
                }
                if(done){
                    
                    done(@1);
                }
                
                
            }else {
            
                NSError *error = [NSError errorWithDomain:@"Responde" code:100 userInfo:@{}];
                if(error){
                    
                    errorDone(nil);
                }
                if(done){
                    
                    done(nil);
                }
            }
            
        }
        
        
    }];
    [sessionTask  resume];
#else
    
    NSError *error = nil;
    NSURLResponse *urlResp = nil;
    [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&urlResp error:&error];
    
#endif
}


@end
