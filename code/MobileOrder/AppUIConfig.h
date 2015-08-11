//
//  APPUIConfig.h
//  MobileOrder
//
//  Created by cszhan on 15-5-26.
//  Copyright (c) 2015年 com.ximalaya. All rights reserved.
//

#ifndef MobileOrder_APPUIConfig_h
#define MobileOrder_APPUIConfig_h

/*
 750 x 1334 (@2x) for portrait
 1334 x 750 (@2x) for landscape
 For iPhone 6 Plus:
 1242 x 2208 (@3x) for portrait
 2toobar(241,241,241)
 3 background (212,212,212)
 */

#define  kViewBGColor                       HexRGB(212, 212,212)

#define  kNavBarColor                       HexRGB(241,241,241)

#define  kOrderPanelColor                   HexRGB(239,239,239)

#define  kNavBarTextColor                   HexRGB(251,53,29)

#define  kGoodCatagoryTextColor             HexRGB(0,0,0)
#define  kGoodCatagorySelectedTextColor     HexRGB(251,53,29)

#define  kCommonButtonBgColor               HexRGB(205, 86, 55)

#define  kOrderPayAndWaitingColor           HexRGB(144,200,144)


#define  kGoodCatagoryTextFont          [UIFont systemFontOfSize:12]
#define  kGoodsSubCatagoryTextFont          [UIFont systemFontOfSize:10]

#define  kGoodsOrderMenuTextFont        [UIFont   systemFontOfSize:14]

#define  kGoodsOrderShopTitle         [UIFont   systemFontOfSize:16]

#define  kOrderDetailTextFont         [UIFont   systemFontOfSize:18]


#define kMenuTitle        @"私人厨房"
#define kMenuTitleArray   @[@"候餐",@"点餐",@"我"]
#define kVendorTitle      @"餐馆选择"
#define kOrderMenuTitle   @"点餐"
#define kOrderFeedBackTitle  @"意见反馈"

#define kOrderConfirmTitle @"下单确认"
#define kOrderPayTitle      @"订单支付"

#define kMeCenterTitle      @"个人中心"
#define kOrderListTitle     @"我的订单"

#define kConfirmOrderNetIndicText   @"订单生成中..."


#endif
