//
//  OrderItem.m
//  MobileOrder
//
//  Created by cszhan on 15-6-13.
//  Copyright (c) 2015年 com.ximalaya. All rights reserved.
//

#import "OrderItem.h"
#import "GoodsCatagoryItem.h"

#import "NSDate+Ex.h"


#define  kOrderDateFormat @"YYYY年MM月dd日hh时mm分"
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

- (id)initWithDictionary:(NSDictionary*)orderDict {

    /*
     *arriveTime = 1439606879000;
     arriveTimes = "<null>";
     comment = "<null>";
     createTime = 1439210461000;
     diningId = 1;
     id = 1;
     integral = 0;
     modifyTime = 1439210461000;
     orderDetail =             (
     {
     createTime = 1439210461000;
     id = 1;
     integration = 0;
     modifyTime = 1439210461000;
     num = 1;
     orderId = 1;
     product = "<null>";
     productId = 7;
     productPrice = 20;
     queuNum = "<null>";
     status = 1;
     taste = "<null>";
     tasteId = 1;
     tastePrice = 2;
     totalPrice = 22;
     },
     {
     createTime = 1439210461000;
     id = 2;
     integration = 0;
     modifyTime = 1439210461000;
     num = 1;
     orderId = 1;
     product = "<null>";
     productId = 7;
     productPrice = 20;
     queuNum = "<null>";
     status = 1;
     taste = "<null>";
     tasteId = 2;
     tastePrice = 2;
     totalPrice = 22;
     },
     {
     createTime = 1439210461000;
     id = 3;
     integration = 0;
     modifyTime = 1439210461000;
     num = 1;
     orderId = 1;
     product = "<null>";
     productId = 7;
     productPrice = 20;
     queuNum = "<null>";
     status = 1;
     taste = "<null>";
     tasteId = 3;
     tastePrice = 2;
     totalPrice = 22;
     },
     {
     createTime = 1439210461000;
     id = 4;
     integration = 0;
     modifyTime = 1439210461000;
     num = 1;
     orderId = 1;
     product = "<null>";
     productId = 7;
     productPrice = 20;
     queuNum = "<null>";
     status = 1;
     taste = "<null>";
     tasteId = 4;
     tastePrice = 6;
     totalPrice = 26;
     }
     );
     paySerialNum = alibabaSn1111;
     payType = 1;
     peopleCount = 1;
     queueNum = 1;
     rate = "<null>";
     serialNum = O2015810201439210461801v;
     status = 1;
     totalPrice = 92;
     userId = 1;
     },
     */
    
    if(self = [super init]) {
    
        self.orderId = [[orderDict objectForKey:@"id"] longLongValue];
        self.orderIdName = @"O20158102014";//[orderDict objectForKey:@"serialNum"];
        long long timeInterval = [[orderDict objectForKey:@"createTime"] longLongValue];
        NSDate *orderDate = [NSDate dateWithTimeIntervalSince1970:timeInterval/1000];
        self.orderTime = [NSDate formartDateTime:orderDate  withFormat:kOrderDateFormat];
        
        NSArray *orderProductArray = [orderDict objectForKey:@"orderDetail"];
        
        NSMutableArray *goodsOrderItemArray = [NSMutableArray array];
#if 1
        for (NSDictionary *itemDict in orderProductArray){
            
            id product = [itemDict objectForKey:@"product"];
            NSString *goodName = nil;
            if([product isKindOfClass:[NSDictionary class]]){
            
                goodName = [product objectForKey:@"name"];
            }
            if(goodName ==nil || [goodName isKindOfClass:[NSNull class]]){
                goodName = @"菜品名";
            }
            SubCatagoryItem *subItem = [[SubCatagoryItem alloc]init];
            id taste = [itemDict objectForKey:@"taste"];
            
            NSString *tasteName = nil;
            if([taste isKindOfClass:[NSDictionary class]]){
                
                tasteName = [taste objectForKey:@"name"];
            }
            if(tasteName ==nil || [tasteName isKindOfClass:[NSNull class]]){
                tasteName = @"口味名";
            }
            subItem.name =  tasteName;
            subItem.price = [[itemDict objectForKey:@"tastePrice"] floatValue];
            subItem.basePrice = [[itemDict objectForKey:@"productPrice"] floatValue];
            id value = [itemDict objectForKey:@"queuNum"];
            if(![value isKindOfClass:[NSNull class]]){
                subItem.queueNum = [value integerValue];
            }
            subItem.number = [[itemDict objectForKey:@"num"]integerValue];
            GoodsOrderItem *goodOrderItem = [[GoodsOrderItem alloc]initWithGoodsName:goodName withCatagoryItem:subItem];
            [goodsOrderItemArray addObject:goodOrderItem];
        }
#endif
        self.menuData = goodsOrderItemArray;
        self.personNum = [[orderDict objectForKey:@"peopleCount"] integerValue];
        self.payPrice =[[orderDict objectForKey:@"totalPrice"]floatValue];
        self.status = [[orderDict objectForKey:@"status"]integerValue];
        self.queueNum = [[orderDict objectForKey:@"queueNum"]integerValue];
            }
    return self;
}

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
    [postDict setValue:[NSNumber numberWithInteger:self.personNum] forKey:@"peopleCount"];
    [postDict setValue:[NSNumber numberWithInteger:self.arriveTime*60] forKey:@"arriveTimes"];
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
