//
//  PlanformTool.h
//  TVMobileSdk
//
//  Created by cszhan on 13-7-9.
//  Copyright (c) 2013年 yunzhisheng. All rights reserved.
//

#ifndef TVMobileSdk_PlanformTool_h
#define TVMobileSdk_PlanformTool_h

//#define DEBUG_UMENG
#define INFOR_TOP 1
#if __has_feature(objc_arc)
#define KokSafeRelease(x)   x
#define kokSafeRetain(x,y)  x = y
#define SafeRelease(x)      x
#define SafeAutoRelease(x)  x
#define SuperDealloc  
#else
#define KokSafeRelease(x)   [(x) release]
#define kokSafeRetain(x,y)  x = [(y) retain]
#define SafeRelease(x)      KokSafeRelease(x)
#define SafeAutoRelease(x)  [(x) autorelease]
#define SuperDealloc        [super dealloc]
#endif
#if __has_feature(objc_arc)
#else
#define     unsafe_unretain assign
#define     weak        assign
#define     __bridge
#endif

#define  kDeviceCheckIphone5 (([[UIScreen mainScreen] bounds].size.height <= 480.0) ? 0:1)

#define  kDeviceCheckIphone6 (([[UIScreen mainScreen] bounds].size.width == 375) ? 1:0)

#define  kDeviceCheckIphone6Plus (([[UIScreen mainScreen] bounds].size.width == 414) ? 1:0)

#define  kIsIOS7Check  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)

#endif
