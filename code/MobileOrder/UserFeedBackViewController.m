//
//  UserFeedBackViewController.m
//  MobileOrder
//
//  Created by kuben on 15/7/24.
//  Copyright (c) 2015年 com.ximalaya. All rights reserved.
//

#import "UserFeedBackViewController.h"

#define kLeftPendingX   10.f

@interface UserFeedBackViewController(){

    UITextView *textView;
}
@end

@implementation UserFeedBackViewController

- (void)dealloc {

    self.orderItem = nil;
    SuperDealloc;
}

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
    
    textView = [[UITextView alloc]initWithFrame:CGRectMake(kLeftPendingX, currY, kDeviceScreenWidth-2*kLeftPendingX,textViewHeight)];
    
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

    if([textView.text isEqualToString:@""] ){
        kUIAlertViewNoDelegate(@"提示", @"评论不许为空!!");
        return;
    }
    kNetStartShow(@"发送中...", self.view);
    [[MobileOrderNetDataMgr getSingleTone] newOrderCommnent:@{@"orderId":[NSString stringWithFormat:@"%lld",self.orderItem.orderId],@"comment":textView.text}];
}


-(void)didNetDataOK:(NSNotification*)ntf
{
    //return;
    [super didNetDataOK:ntf];
    
    id obj = [ntf object];
    id respRequest = [obj objectForKey:@"request"];
    id objData = [obj objectForKey:@"data"];
    NSString *resKey = [respRequest resourceKey];
    //NSString *resKey = [respRequest resourceKey];
    if([resKey isEqualToString:@"newComment"])
    {
        //        if ([self.externDelegate respondsToSelector:@selector(commentDidSendOK:)]) {
        //            [self.externDelegate commentDidSendOK:self];
        //        }
                  kNetEndSuccStr(@"评论成功",self.view);
        //        [self dismissModalViewControllerAnimated:YES];
#if 0
        [self reloadNetData:data];
#else
        //        if([[data objectForKey:@"data"] count]<10.f){
        //            isRefreshing = YES;
        //        }
        
        NSDictionary *data = objData;
#endif
        //self.dataArray = [data objectForKey:@"data"];
        //        if([[data objectForKey:@"data"]count])
        //            self.pageNum = self.pageNum +1;
        [self performSelectorOnMainThread:@selector(updateUIData:) withObject:data waitUntilDone:NO];
        
    }
}

- (void)updateUIData:(NSDictionary*)netData{
    
    [self.navigationController popViewControllerAnimated:YES];
    kNetEnd(self.view);
}
-(void)didNetDataFailed:(NSNotification*)ntf
{
    kNetEnd(self.view);
}


@end
