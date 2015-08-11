//
//  GoodsCatagoryItem.h
//  MobileOrder
//
//  Created by cszhan on 15-5-30.
//  Copyright (c) 2015年 com.ximalaya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubCatagoryItem:NSObject

@property (nonatomic, assign) long long itemId;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, assign) NSInteger number;

@property (nonatomic, assign) CGFloat   price;

@property (nonatomic, assign) CGFloat  basePrice;

@property (nonatomic, assign) long long catagoryId;

@property (nonatomic, assign) long long tasteId;

@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, strong) NSString *imageURL;

@property (nonatomic, assign) NSInteger  queueNum;

@end


@interface GoodsCatagoryItem : SubCatagoryItem


@property (nonatomic, strong) NSMutableArray *subCatogoryArray;


@end

@interface GoodsOrderItem : NSObject


@property (nonatomic, strong) NSString *goodsName;

@property (nonatomic, strong) SubCatagoryItem *subCatagoryItem;

- (id)initWithGoodsName:(NSString*)name withCatagoryItem:(SubCatagoryItem*)item;


@end
