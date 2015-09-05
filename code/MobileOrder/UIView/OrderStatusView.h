//
//  OrderStatusView.h
//  MobileOrder
//
//  Created by cszhan on 15-7-26.
//  Copyright (c) 2015年 com.ximalaya. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
   ActionArrived,
   ActionTimer,
}ActionType;


@protocol OrderStatusActionDelegate <NSObject>

- (void)didPressActionButton:(id)sender withType:(ActionType)type;

@end

@interface OrderStatusView : UIView


@property (nonatomic, strong) UILabel *timerLabel;

@property (nonatomic, strong) UIButton *arriveBtn;

@property (nonatomic, assign)id<OrderStatusActionDelegate>       delegate;

@end
