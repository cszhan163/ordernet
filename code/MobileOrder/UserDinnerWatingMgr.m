//
//  UserDinnerWatingMgr.m
//  MobileOrder
//
//  Created by cszhan on 15-7-19.
//  Copyright (c) 2015年 com.ximalaya. All rights reserved.
//

#import "UserDinnerWatingMgr.h"

#define kDinnerWaitingCheck   10.f

@interface UserDinnerWatingMgr(){

}

@property (nonatomic ,strong) NSTimer *timer;

@property (nonatomic, strong) OrderItem *orderItem;

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
            self.netFailedBlcok = nil;
            //self.netDoneBlock = nil;
        }
        

    }
    if([resKey isEqualToString:@"realtime"]) {
    
        NSDictionary *data = objData;
        NSLog(@"realTimer OrderData:%@",[data description]);
        
        if(self.netDoneBlock) {
            
            self.netDoneBlock(data);
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


@end
