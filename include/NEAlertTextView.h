//
//  NEAlertTextView.h
//  MP3Player
//
//  Created by cszhan on 12-2-5.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NEAlertTextView : UIWindow {

}
@property(nonatomic,assign)BOOL isHiddenAuto;
@property(nonatomic,retain)NSString *text;
-(id)initWithFrame:(CGRect)frame withText:(NSString*)text isWindow:(BOOL)isWindow;
- (void)setBGContent:(UIImage*)image;
- (void)hiddenAfterDelay:(NSTimeInterval)duration;
@end
