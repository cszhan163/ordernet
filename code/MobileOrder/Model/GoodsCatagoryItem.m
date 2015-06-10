//
//  GoodsCatagoryItem.m
//  MobileOrder
//
//  Created by cszhan on 15-5-30.
//  Copyright (c) 2015年 com.ximalaya. All rights reserved.
//

#import "GoodsCatagoryItem.h"

@implementation SubCatagoryItem

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
