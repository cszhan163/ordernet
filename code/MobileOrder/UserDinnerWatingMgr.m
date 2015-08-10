//
//  UserDinnerWatingMgr.m
//  MobileOrder
//
//  Created by cszhan on 15-7-19.
//  Copyright (c) 2015年 com.ximalaya. All rights reserved.
//

#import "UserDinnerWatingMgr.h"




static UserDinnerWatingMgr *staticInstance = nil;



@implementation UserDinnerWatingMgr

+ (instancetype)sharedInstance {
    if(staticInstance == nil){
    
        staticInstance = [[self alloc]init];
    }
    return staticInstance;
}

- (id)init {

    if(self = [super init]){
    
        [ZCSNotficationMgr addObserver:self call:@selector(didNetWorkOK:) msgName:kZCSNetWorkOK];
        [ZCSNotficationMgr addObserver:self call:@selector(didNetWorkFailed:) msgName:
         kZCSNetWorkRespondFailed];

    }
    return self;
}

- (void)startGetOrderListByStatus:(OrderStatus) status {
    /*
     order/list?status=0
     */
    
    [[MobileOrderNetDataMgr getSingleTone] getWaitingOrderList:@{@"status":[NSString stringWithFormat:@"%ld",status]}];
}

- (void)startCheckDinnerWaitingByOrderId:(NSString*)orderId {

    
}


-(void)didNetDataOK:(NSNotification*)ntf
{

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
        
    }
}



@end
