//
//  GoodsCatagoryItem.m
//  MobileOrder
//
//  Created by cszhan on 15-5-30.
//  Copyright (c) 2015年 com.ximalaya. All rights reserved.
//

#import "GoodsCatagoryItem.h"

@implementation SubCatagoryItem

- (id)init {
    if(self= [super init]) {
        self.tasteId = -1;
        self.itemId = -1;
        self.catagoryId = -1;
    }
    return self;
}

- (void)dealloc {

    self.name = nil;
    SuperDealloc;
}


@end

@implementation GoodsCatagoryItem

- (void)dealloc {
    self.subCatogoryArray = nil;
    SuperDealloc;
}


@end

@implementation  GoodsOrderItem

- (void)dealloc {
    self.goodsName = nil;
    self.subCatagoryItem = nil;
    SuperDealloc;
}
- (id)initWithGoodsName:(NSString*)name withCatagoryItem:(SubCatagoryItem*)item
{
    if(self = [super init]){
        self.goodsName = name;
        self.subCatagoryItem = item;
    }
    return self;
}

@end
