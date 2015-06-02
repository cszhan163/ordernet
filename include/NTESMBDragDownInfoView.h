//
//  DragDownInfoView.h
//  TweetieTableView
//
//  Created by Xu Han Jie on 10-5-20.
//  Copyright 2010 NetEase.com, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef enum {
    DragDownInfoViewStateInit = -1,
	DragDownInfoViewStateNormal = 0,
	DragDownInfoViewStateRefresh = 1,
	DragDownInfoViewStateRefreshing = 2
} DragDownInfoViewState;

@interface NTESMBDragDownInfoView : UIView {
	DragDownInfoViewState _state;
	
	UILabel *infoLabel;
    UILabel *updateLabel;
	UIImageView *background;
	UIImageView *midBackground;
	CALayer *arrowImage;
	UIActivityIndicatorView *activityView;
	
	NSDate *lastUpdateDate;
}
@property (nonatomic,retain)UIFont *font;
@property (nonatomic,retain)UIColor *color;
@property (nonatomic, retain) NSDate *lastUpdateDate;

- (void) setState:(DragDownInfoViewState) state;
- (DragDownInfoViewState) getState;

@end
