//
//  OrderItem.m
//  MobileOrder
//
//  Created by cszhan on 15-6-13.
//  Copyright (c) 2015年 com.ximalaya. All rights reserved.
//

#import "OrderItem.h"
#import "GoodsCatagoryItem.h"
@implementation ShopItem

- (id)initWithDictonary:(NSDictionary*)item {

    if(self = [super init]) {
    self.name = [item objectForKey:@"name"];
    self.position = [item objectForKey:@"location"];
        self.avPrice = [[item objectForKey:@"averagePrice"]floatValue];
        self.imageURL = [item objectForKey:@"url"];
    }
    return self;
}

- (void)dealloc {

    self.name = nil;
    self.position = nil;
    self.imageURL = nil;
    SuperDealloc;
}

@end

@implementation OrderItem


- (NSDictionary*)getOrderDictionaryData {

    /*
     {
     "serialNum": "SN432423424",
     "totalPrice": "20",
     "status": "1",
     "userId": "1",
     "payType": "1",
     "paySerialNum": "2",
     "orderDetail":[{"price":5,"totalPrice":10,"num":2,"status":1,"productId":1}]
     }
     {
     "arriveTimes": 3600000,
     "peopleCount": 2,
     "orderDetail": [
     {
     "productId": "3",
     "tasteId": "",
     "num": "2"
     },
     {
     "productId": "4",
     "tasteId": "",
     "num": "1"
     }
     ]
     }
     */
    NSMutableDictionary *postDict = [NSMutableDictionary dictionary];
    //[postDict setValue:self.orderId forKey:@"serialNum"];
    //[postDict setValue:[NSString stringWithFormat:@"%0.2lf",self.totalPrice]  forKey:@"totalPrice"];
    [postDict setValue:@"1" forKey:@"peopleCount"];
    [postDict setValue:@"0" forKey:@"arriveTimes"];
    //[postDict setValue:@"3" forKey:@"paySerialNum"];

    NSMutableArray *dataArray = [NSMutableArray array];
    for(GoodsOrderItem *orderItem in self.menuData){
        SubCatagoryItem *item = orderItem.subCatagoryItem;
        //if([item isKindOfClass:[SubCatagoryItem class]])
        {
            
            [dataArray addObject:@{
                                   @"num":[NSString stringWithFormat:@"%ld",item.number],
                                   @"productId":[NSString stringWithFormat:@"%ld",item.itemId],
                                   //@"catagoryId":[NSString stringWithFormat:@"%ld",item.catagoryId],
                                   //@"status":@"1",
                                   @"tasteId":[NSString stringWithFormat:@"%ld",item.tasteId]}
             ];
        }
        
    }
    [postDict setValue:dataArray forKey:@"orderDetail"];
    return postDict;
}


@end
