//
//  GoodsCatagoryItem.h
//  MobileOrder
//
//  Created by cszhan on 15-5-30.
//  Copyright (c) 2015年 com.ximalaya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubCatagoryItem:NSObject

@property (nonatomic, strong) NSString *name;

@property (nonatomic, assign) NSInteger number;

@property (nonatomic, assign) CGFloat cellHeight;

@end


@interface GoodsCatagoryItem : SubCatagoryItem


@property (nonatomic, strong) NSMutableArray *subCatogoryArray;


@end
