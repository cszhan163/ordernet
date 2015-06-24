//
//  OrderMenuView.h
//  MobileOrder
//
//  Created by cszhan on 15-6-6.
//  Copyright (c) 2015年 com.ximalaya. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GoodsCatagoryView.h"

@protocol GoodsOrderMenuDelegate <NSObject>

- (void)didChangeOrderMenu:(id)sender;

@end


@interface GoodsOrderMenuView : GoodsCatagoryView

@property (nonatomic, assign) id<GoodsOrderMenuDelegate> orderDelegate;

- (void)updateDataByOrderListArray:(NSArray*)data;

@property (nonatomic, strong) UIView *bgView;


- (void)showInView:(UIView*)view  withOffsetY:(CGFloat)offsetY animated:(BOOL) animated;

- (void)disMiss:(BOOL)animated;

@end
