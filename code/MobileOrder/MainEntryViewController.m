//
//  ViewController.m
//  MobileOrder
//
//  Created by cszhan on 15-5-26.
//  Copyright (c) 2015年 com.ximalaya. All rights reserved.
//

#import "MainEntryViewController.h"

#import "BSTellBaseViewController.h"


#define kMenuTitleArray   @[@"候餐",@"点餐",@"我"]

@interface MainEntryViewController ()

@end

@implementation MainEntryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kViewBGColor;
    
    self.navigationController.navigationBar.backgroundColor = kNavBarColor;
    //self.navigationController.navigationBar.
    //self.title = @"私人厨房";
    //self.
    UIImage *image = nil;
    CGFloat currY = self.view.bounds.size.height;
    
    CGFloat step = 170/4.f;
    CGFloat currX = step;
    CGFloat viewWidth = (kDeviceScreenWidth-2)/3;
    step = 1.f;
    currX = 0.f;
    for (int i = 0; i<3;i++) {
        /*
        NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@""  ofType:@"png"]];
        image = [UIImage imageWithData:data scale:[UIScreen mainScreen].scale];
        */
        
        UIView *btnBgView = [[[UIView alloc]initWithFrame:CGRectMake(0.f, 0.f,viewWidth, viewWidth)] autorelease];
        btnBgView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:btnBgView];
        
        
        CGSize size = btnBgView.frame.size;
        
        btnBgView.frame = CGRectMake(currX, currY-size.height, size.width,size.height);
        
        
        NSString *imageName = [NSString stringWithFormat:@"main_collview_%d",i+1];
        UIImageAutoScaleWithFileName(image,imageName);
        assert(image);
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [btn setImage:image forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(didPressBtn:) forControlEvents:UIControlEventTouchUpInside];
        //[self.view addSubview:btn];
        [btn sizeToFit];
        [btnBgView addSubview:btn];
        
        btn.center = CGPointMake(size.width/2.f, size.height/2.f);
        
        //UILabel *title = [UILabel alloc]initWithFrame:CGRectMake(0.f, 0.f,size.width,20.f);
        
        UILabel *title = [UIComUtil createLabelWithFont:[UIFont systemFontOfSize:10.f] withTextColor:[UIColor blackColor] withText:kMenuTitleArray[i] withFrame:CGRectMake(0.f,btnBgView.frame.size.height-20.f-10.f,btnBgView.frame.size.width,20.f)];
        
        [btnBgView addSubview:title];
        
        currX = currX+btnBgView.frame.size.width+step;
        
    }
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didPressBtn:(id)sender {

    BSTellBaseViewController *orderViewCtrl = [[BSTellBaseViewController alloc]init];
    
    [self.navigationController pushViewController:orderViewCtrl animated:YES];
    
    [orderViewCtrl release];

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
