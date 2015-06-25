//
//  ViewController.m
//  MobileOrder
//
//  Created by cszhan on 15-5-26.
//  Copyright (c) 2015年 com.ximalaya. All rights reserved.
//

#import "MainEntryViewController.h"

#import "BSTellBaseViewController.h"

#import "VendorListViewController.h"

#import "BSPreviewScrollView.h"

#import "OrderConfirmViewController.h"

#import "MeViewController.h"

#define  kIphone4ImageSize  CGSizeMake(kDeviceScreenWidth, 200.f)

#define  kIphone5ImageSize  CGSizeMake(kDeviceScreenWidth, 200.f+100.f)

#define  kIphone6ImageSize  CGSizeMake(kDeviceScreenWidth, 200.f+150.f)

#define  kIphone6PlusImageSize  CGSizeMake(kDeviceScreenWidth, 200.f+100.f)


@interface MainEntryViewController () {


    
}

@property (nonatomic,strong)  BSPreviewScrollView *scrollViewPreview;

@end

@implementation MainEntryViewController

- (void)dealloc {
    self.scrollViewPreview = nil;
    SuperDealloc;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {

    if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]){
    
        [self setNavgationBarTitle:kMenuTitle];
        [ZCSNotficationMgr addObserver:self call:@selector(needPresentLogin:) msgName:kPresentModelViewController];
    }
    return self;
};

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = kViewBGColor;
    
    self.navigationController.navigationBar.backgroundColor = kNavBarColor;

    [self setHiddenLeftBtn:YES];
    
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
        
        UIView *btnBgView = [[UIView alloc]initWithFrame:CGRectMake(0.f, 0.f,viewWidth, viewWidth)] ;
        btnBgView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:btnBgView];
        SafeAutoRelease(btnBgView);
        
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
        btn.tag = i;
        
        btn.center = CGPointMake(size.width/2.f, size.height/2.f);
        
        //UILabel *title = [UILabel alloc]initWithFrame:CGRectMake(0.f, 0.f,size.width,20.f);
        
        UILabel *title = [UIComUtil createLabelWithFont:[UIFont systemFontOfSize:10.f] withTextColor:[UIColor blackColor] withText:kMenuTitleArray[i] withFrame:CGRectMake(0.f,btnBgView.frame.size.height-20.f-10.f,btnBgView.frame.size.width,20.f)];
        
        [btnBgView addSubview:title];
        
        currX = currX+btnBgView.frame.size.width+step;
        
    }
    [self initFocusImageView];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)initFocusImageView {
    
    CGFloat currY = kMBAppTopToolBarHeight;
    CGSize size = kIphone4ImageSize;
    
    CGRect rect = [UIScreen mainScreen].bounds;
    
    if(kDeviceCheckIphone5) {
    
        size = kIphone5ImageSize;
        
    }
  
    
    self.scrollViewPreview = [[BSPreviewScrollView alloc]initWithFrame:CGRectMake(0.f,currY,size.width,size.height)];
    NE_LOGRECT(self.scrollViewPreview.frame);
    [self.scrollViewPreview setBackgroundColor:[UIColor clearColor]];
    self.scrollViewPreview.pageSize = size;
    // Important to listen to the delegate methods.
    self.scrollViewPreview.delegate = self;
    
    
    [self.scrollViewPreview setPageViewPendingWidth:0.f];
    [self.scrollViewPreview setPageControlHidden:NO];
    NE_LOGRECT(self.scrollViewPreview.frame);
    StyledPageControl *pageControl = [self.scrollViewPreview getPageControl];
    //    UIImage *image  = nil;
    //    UIImageWithFileName(image ,@"point-gray.png");
    //    pageControl.thumbImage = image;
    //    UIImageWithFileName(image ,@"point-red.png");
    //    pageControl.selectedThumbImage = image;
    pageControl.pageControlStyle = PageControlStyleDefault;
    [self.scrollViewPreview bringSubviewToFront:pageControl];
    pageControl.userInteractionEnabled = NO;
    //CGRect rect = pageControl.frame;
    //[self.scrollViewPreview setPageControlFrame:CGRectMake(0.f,rect.size.height-80.f,kDeviceScreenWidth, 40.f)];
    pageControl.frame = CGRectOffset(rect, 0.f, -50.f);
    
    [self.scrollViewPreview setScrollerZoom:NO];
    [self.view addSubview:self.scrollViewPreview];
    SafeRelease(self.scrollViewPreview);

}


- (void)didPressBtn:(id)sender {

    
    switch ([sender tag]) {
        case 0: {
            BSTellBaseViewController *orderViewCtrl = [[BSTellBaseViewController alloc]init];
            [self.navigationController pushViewController:orderViewCtrl animated:YES];
            
            SafeRelease(orderViewCtrl);
            }
            break;
        case 1: {
            VendorListViewController *vendorViewCtrl = [[VendorListViewController alloc]init];
            
            [self.navigationController pushViewController:vendorViewCtrl animated:YES];
            
            SafeRelease(vendorViewCtrl);
        
            }
            break;
        case 2: {
            
#if 0
            OrderConfirmViewController *orderConfirmCtlr =  [[OrderConfirmViewController alloc]init];
            
            [self.navigationController pushViewController:orderConfirmCtlr animated:YES];
            
            SafeRelease(orderConfirmCtlr);
#else
            MeViewController *meVCtl = [[MeViewController alloc]init];
            [self.navigationController pushViewController:meVCtl animated:YES];
            
            SafeRelease(meVCtl);
#endif
        
        }
            
            break;
        default:
            break;
    }
   

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark BSPreviewScrollViewDelegate methods
-(int)itemCount:(BSPreviewScrollView*)scrollView{
    
    return  4;
}
-(UIView*)viewForItemAtIndex:(BSPreviewScrollView*)scrollView index:(int)index
{
    
    UIImage *image  = nil;
    NSInteger type = 0;//self.indexType
    NSString *fileFormart = @"setting_help%d_%02d.png";
    if(kDeviceCheckIphone5){
        fileFormart = @"setting_help%d_%02d-568h@2x.png";
    }
    NSString *fileName  = [NSString stringWithFormat:fileFormart,type,index+1];
    UIImageWithFileName(image ,fileName);
    //assert(image);
    
    CGSize size = kIphone4ImageSize;
    if(kDeviceCheckIphone5){
        size = kIphone5ImageSize;
    }
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, 0.f,size.width,size.height)];
    imageView.backgroundColor = [UIColor greenColor];
    imageView.image = image;
   
    
    return  SafeAutoRelease(imageView);
}

- (void)needPresentLogin:(NSNotification*)ntf {

    UIViewController *vcCtrl = [ntf object];
    [self.navigationController presentViewController:vcCtrl animated:YES completion:^(){
    
        }];
}



@end
