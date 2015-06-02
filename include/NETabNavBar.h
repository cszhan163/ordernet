//
//  NETabNavBar.h
//  NeteaseMicroblog
//
//  Created by cszhan on 1/30/11.
//  Copyright 2011 NetEase.com, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "UIBaseViewController.h"
//#import "NENavItemController.h"
@protocol NETabNavBarDelegate<NSObject>
-(void)didSelectorNavBarItem:(NSDictionary*)navObj;
-(void)didSelectorNavBarItemIndex:(NSInteger)index;
-(void)didSelectorNavBarItemSame:(NSDictionary*)navObj;
@end
@interface NETabNavBar : UIView {
	NSArray					*_topBarViewArr;
	NSArray					*_navBtnArr;
	UITabBarController		*_tabNavBarcontroller;
	//NENavItemController		*_navItemVc;
	UIView					*_curtopBarItemView;
	NSInteger				_curSelIndex;
	//id<NETabNavBarDelegate> _delegate;
}
-(void)setBgImage:(UIImage*)bgImage;
-(NSInteger)getTabNavSelectIndex;
-(id)initWithFrame:(CGRect)frame	withNavItem:(NSArray*)navBtn withSplitTag:(UIImage*)splitTag;
-(id)initWithFrame:(CGRect)frame	withNavItem:(NSArray*)navBtn withNavTextLabelArray:(NSArray*)lableArray withSplitTag:(UIImage*)splitTag;
-(id)getCurrentSelItem;
@property(nonatomic,retain)NSArray* topBarViewArr;
@property(nonatomic,readonly)NSArray *navBarArr;
@property (nonatomic,readonly)NSArray *navTabTextArr;
//@property(nonatomic,retain)NENavItemController *navItemVc;
@property(nonatomic,retain) UITabBarController *tabNavBarcontroller;
@property(nonatomic,readonly)UIView *curtopBarItemView;
@property(nonatomic,unsafe_unretained) id<NETabNavBarDelegate> delegate;

@end
