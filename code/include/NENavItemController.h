//
//  NENavItemController.h
//  NeteaseMicroblog
//
//  Created by cszhan on 2/12/11.
//  Copyright 2011 NetEase.com, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NETopNavBar.h"
#import "NETabNavBar.h"
//@protocol NENavItemControllerDelegate<

@interface NENavItemController : UIViewController<NETopNavBarDelegate,UINavigationControllerDelegate>{
	NETopNavBar			*_topNavBar;
	NSMutableArray			*_navControllersArr;
	NSMutableArray			*_navControllerStack;
	id						_currentRootViewController;
	
	UINavigationController	*gNavigationController;
	NETabNavBar			*_tabNavBar;
    
	//UINavigationController	*_navigationController
}
//@property(nonatomic,assign) NETopNavBar	*topNavBar;
//@property(nonatomic,retain) UIView *view;
@property(nonatomic,retain) NSMutableArray  *navControllersArr;
@property(nonatomic,unsafe_unretained) id		delegate;
@property(nonatomic,readonly) UIViewController	*currentViewController;
-(void)setTopNavBar:(NETopNavBar*)topNavBar;
-(void)setTabNavBar:(NETabNavBar*)tabNavBar;
-(void)didSelectorTopNavItem:(id)navObj;
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil 
withTopNavBar:(NETopNavBar*)topNavbar;
+(id)sharedNavigationController;
-(NETabNavBar*)getTabNavBar;
@end
