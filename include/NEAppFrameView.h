//
//  NEAppFrameView.h
//  NeteaseMicroblog
//
//  Created by cszhan on 1/30/11.
//  Copyright 2011 NetEase.com, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NETabNavBar.h"
#import "NETopNavBar.h"
typedef enum NEAppFrameViewStyle{
	NEAppFrameViewDefault			= 1<<0,
	NEAppFrameViewTopBarNone		= 1<<1,
	NEAppFrameViewBottomBarNone		= 1<<2,
}NEAppFrameViewStyle;
@interface NEAppFrameView : UIView {
	NETopNavBar					*_topBarView;
	UIView						*_mainFrameView;
	NETabNavBar						*_bottomBarView;
	UIImageView					*_leftPendingView;
	UIImageView					*_rightPendingView;
	NEAppFrameViewStyle			_style;
	BOOL						_isImageDefault;
}
@property(nonatomic,retain)	 NETopNavBar		*topBarView;
@property(nonatomic,retain)  UIView		*mainFramView;
@property(nonatomic,retain)  NETabNavBar		*bottomBarView;
@property(nonatomic,retain)  UIImage	*bgImage;
- (id)initWithFrame:(CGRect)frame;
- (id)initWithFrame:(CGRect)frame style:(NEAppFrameViewStyle)style;
- (id)initWithFrame:(CGRect)frame withImageDict:(NSDictionary*)imgDict withImageDefault:(BOOL)isDefault;
//-(id)initWithUIConfig:(NSMutableDictionary*)uicfgdict;
-(void)setTopNavBarTitle:(NSString*)title;
@end
