//
//  UserFeedBackViewController.m
//  MobileOrder
//
//  Created by kuben on 15/7/24.
//  Copyright (c) 2015年 com.ximalaya. All rights reserved.
//

#import "UserFeedBackViewController.h"

#define kLeftPendingX   10.f

@implementation UserFeedBackViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]){
        
        [self setNavgationBarTitle:kOrderFeedBackTitle];
    }
    return self;
}

- (void)viewDidLoad {

    [super viewDidLoad];
    
    CGFloat currY = 20.f;
    if(kIsIOS7Check){
        
        currY =  currY + kMBAppTopToolBarHeight + kMBAppStatusBar;
    }
    
  
    UIImage *image = nil;
    CGFloat textViewHeight = 200.f;
    
    UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(kLeftPendingX, currY, kDeviceScreenWidth-2*kLeftPendingX,textViewHeight)];
    
    textView.editable = YES;
    textView.text = @"";
    textView.layer.cornerRadius = 5.f;
    [self.view addSubview:textView];
    
    [textView becomeFirstResponder];
    
    SafeRelease(textView);
    currY = currY + textView.frame.size.height+ 20.f;
    
    UIImageAutoScaleWithFileName(image, @"user_btn_h");
    
    UIButton *feedBackBtn = [UIComUtil createButtonWithNormalBGImage:image withHightBGImage:image withTitle:@"发送" withTag:0 withTarget:self  withTouchEvent:@selector(didButtonPress:)];
    //showOrderBtn.backgroundColor = [UIColor redColor];
    [self.view addSubview:feedBackBtn];
    
    feedBackBtn.frame = CGRectMake(0.f,currY,120,40);
    feedBackBtn.center = CGPointMake(kDeviceScreenWidth/2.f,feedBackBtn.center.y);
    [self.view addSubview:feedBackBtn];

}

- (void)didButtonPress:(id)sender {

    
}
@end
