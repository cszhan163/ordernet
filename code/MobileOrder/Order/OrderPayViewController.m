//
//  OrderPayViewController.m
//  MobileOrder
//
//  Created by cszhan on 15-6-17.
//  Copyright (c) 2015年 com.ximalaya. All rights reserved.
//

#import "OrderPayViewController.h"

#import "DinnerWaitingViewController.h"

@interface OrderPayViewController ()

@end

@implementation OrderPayViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]){
        
        [self setNavgationBarTitle:kOrderPayTitle];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.orderItem.orderId = @"SD12346789110";
    self.orderItem.orderTime = @"2015年5月1日19时20分";
    
    UIImage *image =nil;
    UIImageWithFileName(image, @"pay_dis_confirm_pay.png");
    UIButton *feedBackBtn = [UIComUtil createButtonWithNormalBGImage:image withHightBGImage:image withTitle:@"" withTag:0 withTarget:self  withTouchEvent:@selector(didButtonPress:)];
    //showOrderBtn.backgroundColor = [UIColor redColor];
    [self.view addSubview:feedBackBtn];
    
    feedBackBtn.frame = CGRectMake(40.f,300.f,image.size.width,image.size.height);
    //[self.view addSubview:feedBackBtn];
    
}

- (void)didButtonPress:(id)sender {

    DinnerWaitingViewController *waitingViewCtrl = [[DinnerWaitingViewController alloc]init];
    waitingViewCtrl.orderItem = self.orderItem;
    [self.navigationController pushViewController:waitingViewCtrl animated:YES];
    SafeRelease(waitingViewCtrl);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
