//
//  NEDebugTool.h
//  NetEaseBlogIphone
//
//  Created by cszhan on 11/17/10.
//  Copyright 2010 NetEase Corp. All rights reserved.
//
//version

#define kBlogAppVersion		@" (1.1.1)"

#define _DEBUG_
//#define _IPHONE_
//#define _DRAGREFLUSH_
//#define _DEBUG_MOVEVIEW_
//#define APPTEST //use test data
//#define NE_NETCLIENT_DEBUG_
//App DEBUG 
#ifdef DEBUG
//_IPHONE_
#undef NE_LOG
#define NE_LOG(...)		NSLog(__VA_ARGS__)
#define NE_LOGRECT(r)		NSLog(@"(%.1fx%.1f)-(%.1fx%.1f)", r.origin.x, r.origin.y, r.size.width, r.size.height)
#define NE_LOGPOINT(p)		NSLog(@"(%.1f,%.1f",p.x,p.y);
#define NE_FUNNAME		NSLog(NSStringFromSelector(_cmd))
#define NE_LOGFUN		NSLog(@"%@##%@",NSStringFromClass([self class]),NSStringFromSelector(_cmd))
#define verbose			1  
#else
#define NE_LOG(...)  
#define NE_LOGRECT(r)
#define NE_LOGFUN
#define NE_FUNNAME
#define NE_LOGPOINT 
#define verbose			0
#endif
