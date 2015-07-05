//
//  BSTellNetListBaseViewController.m
//  BSTell
//
//  Created by cszhan on 14-2-7.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "BSTellNetListBaseViewController.h"
#import "CardShopLoginViewController.h"
@interface BSTellNetListBaseViewController ()

@end

@implementation BSTellNetListBaseViewController
- (void)dealloc{
    self.dataArray = nil;
    self.userId = nil;
    SuperDealloc;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.dataArray = [NSMutableArray array];
        self.userId = @"";
        self.isNeedLogin = YES;
    }
    return self;
}
- (void)addObservers{
    [super addObservers];
    [ZCSNotficationMgr addObserver:self call:@selector(didUserLogin:) msgName:kUserDidLoginOk];
    [ZCSNotficationMgr addObserver:self call:@selector(didUserLogout:) msgName:kUserDidLogOut];
    [ZCSNotficationMgr addObserver:self call:@selector(didUserLoginCancel:) msgName:kUserDidLoginCancel];
    //[ZCSNotficationMgr addObserver:self call:@selector(didTabItemChange:) msgName:kTabNavItemChangeMSG];
}

- (void)didTabItemChange:(NSNotification*)ntf{

    if(self.isShowLogin){
    
        [self.navigationController popToRootViewControllerAnimated:NO];
        self.isShowLogin = NO;
    }
}

- (void)didUserLogin:(NSNotification*)ntf{
  
}
- (void)didUserLogout:(NSNotification*)ntf{
    
}
- (void)didUserLoginCancel:(NSNotification*)ntf{

    //[ZCSNotficationMgr postMSG:kNavTabItemMSG obj:[NSNumber numberWithInt:2]];
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    NSString *usrId = [AppSetting getLoginUserId];
    if(usrId){
        NSDictionary *usrData = [AppSetting getLoginUserData:usrId];
        self.userId = [usrData objectForKey:@"hydm"];
    }
//    
//    if(self.isNeedLogin &&(!usrId || [usrId isEqualToString:@""])){
//        /*
//         [ZCSNotficationMgr postMSG:kNavTabItemMSG obj:[NSNumber numberWithInt:2]];
//         [ZCSNotficationMgr postMSG:kNeedUserLoginMSG obj:nil];
//         */
//        [self.navigationController popToRootViewControllerAnimated:NO];
//        CardShopLoginViewController *noteListVc = [[CardShopLoginViewController alloc]init];
//        //noteListVc.type = 1;
//        //[noteListVc setNavgationBarTitle:[sender titleLabel].text];
//        noteListVc.view.frame = CGRectMake(0.f,20.f, kDeviceScreenWidth, kDeviceScreenHeight);
//#if 1
//        [self.navigationController pushViewController:noteListVc  animated:NO];
//#else
//        [ZCSNotficationMgr postMSG:kPresentModelViewController  obj:noteListVc];
//        
//#endif
//        SafeRelease(noteListVc);
//        self.isShowLogin = YES;
//        return;
//    }

    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if([self.dataArray count] == 0 &&!isFromViewUnload)
    {
        currentPageNum = 1;
        self.pageNum = 1;
        if(isRefreshing)
            return;
        [self shouldLoadNewerData:tweetieTableView];
        isRefreshing = YES;
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self setLeftNavigationBarItem];
    mainView.topBarView.backgroundColor = HexRGB(1, 159, 233);
    mainView.backgroundColor = HexRGB(239, 239, 241);
    self.delegate = self;
    tweetieTableView.bounces = YES;
    [tweetieTableView setDragEffect:YES];
    
}
- (void)setTopNavBarHidden:(BOOL)status{
    if(status){
        mainView.topBarView.backgroundColor = [UIColor clearColor];
        [self setHiddenLeftBtn:YES];
        [self setHiddenRightBtn:YES];
    }
}

- (void)setLeftNavigationBarItem {
    
    //if(kIsIOS7Check)
    //UINavigationItem *navLeftItem = [[UINavigationItem alloc]initWithTitle:self.title];
    
    {  UIImage *image;
        UIImageAutoScaleWithFileName(image, @"btn-back");
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:image forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(didSelectorTopNavItem:) forControlEvents:UIControlEventTouchUpInside];
        //UIBarButtonItem *navItem = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(didSelectorTopNavItem:)];
        btn.enabled = NO;
        [btn sizeToFit];
        UIBarButtonItem *navItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
        [navItem setTitle:self.title];
        //self.navigationItem
        //if(self.navigationController.navigationBar.backItem){
        [self.navigationItem setLeftBarButtonItems:@[navItem]];
        //}
        //[self.navigationController.navigationBar setTranslucent:YES];
        //[self.navigationBar.backItem setHidesBackButton:YES];

        UIFont *font = [UIFont systemFontOfSize:16.0];
        NSDictionary *attrsDictionary =
        [NSDictionary dictionaryWithObjectsAndKeys:
         font,NSFontAttributeName,
         kNavBarTextColor,NSForegroundColorAttributeName,nil
         ];
        [self.navigationController.navigationBar setTitleTextAttributes:attrsDictionary];
      
        //[self.navigationController.navigationBar.topItem set]
    }
    //[self.navigationController.navigationBar setItems:@[navLeftItem] animated:NO];
    //[navLeftItem release];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) shouldLoadOlderData:(NTESMBTweetieTableView *) tweetieTableView
{
    [super shouldLoadOlderData:tweetieTableView];
    //[self startShowLoadingView];
}

- (void) shouldLoadNewerData:(NTESMBTweetieTableView *) tweetieTableView {
    [super shouldLoadNewerData:tweetieTableView];
    
}

-(void)processReturnData:(id)data;{

}

-(void)didNetDataOK:(NSNotification*)ntf
{
    
    [super didNetDataOK:ntf];
    isRefreshing = NO;
    currentPageNum = currentPageNum+1;
    if (self.reflushType == Reflush_OLDE)
    {
        [tweetieTableView closeBottomView];
        //[tweetieTableView closeInfoView];
    }
    else
    {
        [tweetieTableView closeInfoView];
    }
    
    
    
}
#pragma mark -
#pragma mark - override fun

- (void)reloadNetData:(id)data{
    id retData = nil;
    if([data isKindOfClass:[NSDictionary class]])
        retData = [data objectForKey:@"data"];
    else
        retData = data;
    if(retData){
        
        if([retData isKindOfClass:[NSArray class]])
        {
           
            if([retData count]>0)
                self.pageNum = self.pageNum +1;
            
            [self.dataArray addObjectsFromArray:retData];
        }
        for(id item in self.dataArray){
            
        }
    }
    else{
    
        id retData =  data;
        if([retData isKindOfClass:[NSArray class]])
        {
            if([retData count]>0)
                self.pageNum = self.pageNum +1;
            [self.dataArray addObjectsFromArray:retData];
        }
        for(id item in self.dataArray){
            
        }

    }
    [tweetieTableView reloadData];
}
@end
