//
//  NETabNavBarController.h
//  NeteaseMicroblog
//
//  Created by cszhan on 2/15/11.
//  Copyright 2011 NetEase.com, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NETabNavBar.h"
//UITabBarController
@interface NETabNavBarController : UIViewController {
@private
    NETabNavBar               *_tabNavBar;
}
@property(nonatomic,readonly)NETabNavBar *tabNavBar;
-(id)initWithTabBar:(NETabNavBar*)tabBar;
@end
