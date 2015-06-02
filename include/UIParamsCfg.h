//
//  UIParamsCfg.h
//  NeteaseMicroblog
//
//  Created by cszhan on 1/28/11.
//  Copyright 2011 NetEase.com, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "AppCfg.h"
//for NEAlertTextView
#define kPlayViewTopBarTileFont             [UIFont boldSystemFontOfSize:16.f]

#define kTopNavItemFont                     [UIFont boldSystemFontOfSize:18.f]//[UIFont boldSystemFontOfSize:24.f]

#define  kNavgationItemButtonTextFont [UIFont boldSystemFontOfSize:15] //[UIFont systemFontOfSize:15]


#define  kAppTextSystemFont(x) [UIFont systemFontOfSize:x]
#define  kAppTextBoldSystemFont(x) [UIFont boldSystemFontOfSize:x]
#define  kAppTextItalicSystemFont(x) [UIFont italicSystemFontOfSize:x]

#define NEWUI
/*
 *
 */
#ifdef NEWUI
#define kScale                              (2.0)
#define kDeviceScreenWidth			[[UIScreen mainScreen]bounds].size.width
#define kDeviceScreenHeight			[[UIScreen mainScreen]bounds].size.height
#define kMBAppStatusBar						20.f  
#define kMBAppTopToolBarHeight				44.f
#define kMBAppBottomToolBarHeght			49.f



#define kMBAppRealViewXLeftPending			0.f
#define kMBAppRealViewXRightPending			0.f
//for top nav bar item left pending
#define kMBAppTopToolYPending				9.f
#define kMBAppTopToolXPending				9.f
//for top nav item text offset x
#define kMBAppTopToolTextXPending			100.f

#define kMBAppRealViewRadius				0.f

#define kMBAppRealViewWidth					kDeviceScreenWidth-kMBAppRealViewXLeftPending - kMBAppRealViewXRightPending
#define kMBAppRealViewHeight				kDeviceScreenHeight-kMBAppTopToolBarHeight-kMBAppBottomToolBarHeght-kMBAppStatusBar

#define UIImageScaleWithFileName(image,filename) \
{ \
if([[UIScreen mainScreen] respondsToSelector:@selector(scale)])\
	image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@2x",filename] ofType:@"png"]];\
else \
	image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",filename] ofType:@"png"]];\
}	

#define UIImageWithNibName(filename)   [UIImage imageNamed:filename]

#define UIImageWithFileName(image,filename) image = [UIImage imageNamed:filename]

#define UIImageAutoScaleWithFileName(image,filename) \
{ \
NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:filename  ofType:@"png"]]; \
image = [UIImage imageWithData:data scale:[UIScreen mainScreen].scale];\
}

/*
 * hometimelineviewController
 */
#define  kNewTimelineDownAlertViewFrame	
#else
#define kDeviceScreenWidth			[[UIScreen mainScreen]bounds].size.width
#define kDeviceScreenHeight			[[UIScreen mainScreen]bounds].size.height
#define kMBAppStatusBar						0.f
#define kMBAppTopToolBarHeight				0
#define kMBAppBottomToolBarHeght			0.f
#define kMBAppUITabBarViewOffset			0.f

#define kMBAppRealViewXLeftPending			0.f
#define kMBAppRealViewXRightPending			0.f
#define kMBAppRealViewRadius				5.f

#define kMBAppRealViewWidth					(320.f-kMBAppRealViewXLeftPending - kMBAppRealViewXRightPending)
#define kMBAppRealViewHeight				480.0-20.f-46.f-44.f 
#define kMBAppTopToolYPending				0.f
#define UIImageWithFileName(image,filename) 
#endif
//TimelineCell size, position
#define TIMELINE_CELL_TEXT_LEFT_OFFSET		60
#define TIMELINE_CELL_TEXT_TOP_OFFSET 34

#define kSkipTimelinePhotoTinySize	70

#define kMBAppMainDefaultBGColor				[UIColor clearColor] //[UIColor colorWithRed:0 green:111/255.0 blue:167/255.0 alpha:1]
#define kMBAppDownAlertViewHeight			40.f
//#define UIImageWithFileName(image,filename) image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:filename ofType:@""]]
#define UIImageWithFullPathName(image,filePath) image = [UIImage imageWithContentsOfFile:filePath]
#define UIPointCenterRightBottom(frame) CGPointMake(frame.origin.x+frame.size.width-5.f,frame.origin.y+frame.size.height-5.f)

#define HexRGB(x,y,z)  [UIColor colorWithRed:(x/255.f) green:(y/255.f) blue:(z/255.f) alpha:1]

#define HexRGBA(x,y,z,a) [UIColor colorWithRed:x/255.f green:y/255.f blue:z/255.f alpha:a]