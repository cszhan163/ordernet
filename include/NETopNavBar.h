//
//  NETopNavBar.h
//  NeteaseMicroblog
//
//  Created by cszhan on 2/10/11.
//  Copyright 2011 NetEase.com, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol NETopNavBarDelegate<NSObject>
-(void)didSelectorTopNavItem:(id)navObj;
@end
@interface NETopNavBar : UIView {
	UIImage		*_bgImage;
	NSString	*_navTitle;
	NSArray		*_navbtnArray;
	CGRect		_navTitleRect;
	UIFont		*_navTitleFont;
	UIColor		*_navTitleColor;
	id<NETopNavBarDelegate> _delegate;
}
@property(nonatomic,retain) UIImage *bgImage;
@property(nonatomic,retain) NSString   *navTitle;
@property(nonatomic,retain) UIFont	   *navTitleFont;
@property(nonatomic,retain) NSArray  *navBtnArray;
@property(nonatomic,unsafe_unretained) id<NETopNavBarDelegate> delegate;
@property(nonatomic,assign) CGRect	navTitleRect;
- (id)initWithFrame:(CGRect)frame withBgImage:(UIImage*)bgImage;
- (id)initWithFrame:(CGRect)frame withBgImage:(UIImage*)bgImage withBtnArray:(NSArray*)btnArr selIndex:(NSInteger)seldex;

@end
