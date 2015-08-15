//
//  MeViewController.m
//  MobileOrder
//
//  Created by cszhan on 15-6-24.
//  Copyright (c) 2015年 com.ximalaya. All rights reserved.
//

#import "MeViewController.h"

#import "FoodOrderListViewController.h"
#import "UserInfoViewController.h"
#import "SettingViewController.h"
#import "ZCSNetClient.h"

#import "CardShopLoginViewController.h"

#define kPendingY    20.f

#define kMeCellHeight    44.f

#define kUserHeaderViewHeight   140.f

#define kTableIconArray      @[@"",@"",@"",@"",@"user_setting.png"]

@interface MeViewController () {

    UITableView     *_tableView;
    
    UILabel         *_userNameLabel;
    UILabel         *_userMobileLabel;
    UIButton        *_userImageIconButton;
    UIButton        *_userLogStatusBtn;
    BOOL            isOffset;
}



@end

@implementation MeViewController

- (void)dealloc {

    SuperDealloc;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]){
        
        [self setNavgationBarTitle:kMeCenterTitle];
        //
        [ZCSNotficationMgr addObserver:self call:@selector(didUserLogin:) msgName:kUserDidLoginOk];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGFloat currY = kMBAppTopToolBarHeight;
    if(kIsIOS7Check)
    {
        currY += kMBAppStatusBar;
    }
    
    _tableView  = [[UITableView alloc]initWithFrame:CGRectMake(0.f,currY,kDeviceScreenWidth,kDeviceScreenHeight-kMBAppStatusBar-kMBAppTopToolBarHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _tableView.separatorColor = nil;
    //[_tableView registerClass:[GoodsCatagoryTableViewCell class] forCellReuseIdentifier:cellId];
    [self.view addSubview:_tableView];
    SafeRelease(_tableView);
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0.f, 0.f,kDeviceScreenWidth, kUserHeaderViewHeight)];
    UIImage *image = nil;
    UIImageAutoScaleWithFileName(image,@"user_img_default");
    assert(image);
    //
    _userImageIconButton = [UIComUtil createButtonWithNormalBGImage:image withHightBGImage:image withTitle:@"" withTag:1];
    _userImageIconButton.frame = CGRectMake((kDeviceScreenWidth-image.size.width)/2.f,kPendingY,image.size.width,image.size.height);
    [headerView addSubview:_userImageIconButton];
    [_userImageIconButton addTarget:self action:@selector(didPressUserIconAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageAutoScaleWithFileName(image,@"user_btn_h");
    _userLogStatusBtn = [UIComUtil createButtonWithNormalBGImage:image withHightBGImage:image withTitle:@"" withTag:1];
    _userLogStatusBtn.frame = CGRectMake((kDeviceScreenWidth-_userImageIconButton.frame.size.width)/2.f,2*kPendingY+_userImageIconButton.frame.size.height,60,20);
    [headerView addSubview:_userLogStatusBtn];
    [_userLogStatusBtn addTarget:self action:@selector(didPressUserLogincAction:) forControlEvents:UIControlEventTouchUpInside];

    currY = currY -60.f;
    currY = currY +20.f;
    _userNameLabel = [UIComUtil createLabelWithFont:[UIFont systemFontOfSize:13] withTextColor:kNavBarColor withText:@"" withFrame:CGRectMake(kDeviceScreenWidth/2.f, currY, kDeviceScreenWidth/2.f, 20.f)];
    [headerView addSubview:_userNameLabel];
    _userNameLabel.textAlignment = NSTextAlignmentLeft;
    currY = currY +20.f;
    _userMobileLabel = [UIComUtil createLabelWithFont:[UIFont systemFontOfSize:13] withTextColor:kNavBarColor withText:@"" withFrame:CGRectMake(kDeviceScreenWidth/2.f, currY, kDeviceScreenWidth/2.f, 20.f)];
    _userMobileLabel.textAlignment = NSTextAlignmentLeft;
    [headerView addSubview:_userMobileLabel];
    
    
    UIImageAutoScaleWithFileName(image,@"user_head_bg");
    assert(image);
    headerView.layer.contents = (id)image.CGImage;
    [_tableView setTableHeaderView:headerView];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"MeMenu" ofType:@"plist"];
    NSDictionary *meData = [NSDictionary dictionaryWithContentsOfFile:path];
    
    self.dataArray =  [meData objectForKey:@"data"];
    
    [self updateUIByUserInfoStatus];
    
}

- (void)updateUIByUserInfoStatus {
   
    if([AppSetting getLoginUserId]){
    
        [_userLogStatusBtn setTitle:@"注销" forState:UIControlStateNormal];
        if(isOffset == YES)
            return;
        NSDictionary *userData = [AppSetting getLoginUserData:[AppSetting getLoginUserId]];
        _userNameLabel.text = [userData objectForKey:@"userName"];
        _userMobileLabel.text = [userData objectForKey:@"mobile"];
        [UIView animateWithDuration:0.3 animations:^(){
        
            CGRect newRect = CGRectOffset(_userImageIconButton.frame, -_userImageIconButton.frame.size.width, 0);
            _userImageIconButton.frame = newRect;
            _userNameLabel.hidden = NO;
            _userMobileLabel.hidden = NO;
            
            isOffset = YES;
            
        }];
        
    } else {
    
        [_userLogStatusBtn setTitle:@"登录" forState:UIControlStateNormal];
        if(isOffset == NO)
            return;
        [UIView animateWithDuration:0.3 animations:^(){
            CGFloat offset = 0.f;
            if(isOffset){
                offset = _userImageIconButton.frame.size.width;
            }
            CGRect newRect = CGRectOffset(_userImageIconButton.frame,offset, 0);
            _userImageIconButton.frame = newRect;
            _userNameLabel.hidden = YES;
            _userMobileLabel.hidden = YES;
            isOffset = NO;
            
        }];
    }
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

- (void)didPressUserIconAction:(id)sender {

    
}

- (void)didPressUserLogincAction:(id)sener {
    if(isOffset){
        
        [AppSetting setLogoutUser];
        [self updateUIByUserInfoStatus];
        
    } else {
        /*
       [[MobileOrderNetDataMgr getSingleTone] userLogin:nil];
        kNetStartShow(@"注销中...",self.view);
        */
         __block UINavigationController *navCtl = nil;
        CardShopLoginViewController *cardLoginVCtl = [[CardShopLoginViewController alloc]init];
        
        [cardLoginVCtl setCompleteAction:^(id sender){
            
            SafeRelease(navCtl);
            /*
             OrderPayViewController *orderPayVCtrl = [[OrderPayViewController alloc]init];
             
             [self.navigationController pushViewController:orderPayVCtrl animated:YES];
             SafeRelease(orderPayVCtrl);
             */
            //[self startToConfirmOrder:nil];
            [cardLoginVCtl dismissViewControllerAnimated:YES completion:^(){
                  [self updateUIByUserInfoStatus];
            }];
          
            
        }];
        
        [cardLoginVCtl setCancelAction:^(id sender){
            
            [cardLoginVCtl dismissViewControllerAnimated:YES completion:^(){
            }];
            SafeRelease(navCtl);
        }];
        
        navCtl = [[UINavigationController alloc]initWithRootViewController:cardLoginVCtl];
        [navCtl setNavigationBarHidden:YES];
        //[ZCSNotficationMgr postMSG:kPresentModelViewController obj:cardLoginVCtl];
        [self presentViewController:navCtl animated:YES completion:^(){
            
        }];
        
        SafeRelease(cardLoginVCtl);

    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return  [self.dataArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    /*
     GoodsCatagoryItem *item = [self.dataArray objectAtIndex:indexPath.row];
     return item.cellHeight;
     */
    return kMeCellHeight;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"resumeMenuCellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(cell == nil){
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        SafeAutoRelease(cell);
        
    }
#if 0
    //cell.titleLable.text =  [NSString stringWithFormat:@"%@+%@",item.goodsName,item.name];

#else
    NSDictionary *item = self.dataArray[indexPath.row];
    NSString *iconName = [item objectForKey:@"iconName"];
    UIImage *image = nil;
    UIImageAutoScaleWithFileName(image,iconName);
    //assert(image);
    cell.imageView.image = image;
    cell.textLabel.text = [item objectForKey:@"text"];
#endif
    return cell;
}

- (void)neeUserLoginUserAction:(BlockWithSender) block {

    if([AppSetting getLoginUserId] == nil){
        
        
        UINavigationController *navCtl = nil;
        
        CardShopLoginViewController *cardLoginVCtl = [[CardShopLoginViewController alloc]init];
        
        [cardLoginVCtl setCompleteAction:^(id sender){
            
            [self dismissViewControllerAnimated:YES completion:^(){
                
                if(block){
                    block(nil);
                }
            }];
        }];
        
        [cardLoginVCtl setCancelAction:^(id sender){
            
            [cardLoginVCtl dismissViewControllerAnimated:YES completion:^(){
            }];
            SafeRelease(navCtl);
        }];
        
        navCtl = [[UINavigationController alloc]initWithRootViewController:cardLoginVCtl];
        [navCtl setNavigationBarHidden:YES];
        //[ZCSNotficationMgr postMSG:kPresentModelViewController obj:cardLoginVCtl];
        [self presentViewController:navCtl animated:YES completion:^(){
            
        }];
        
        
        SafeRelease(cardLoginVCtl);
        
        
        return;
    } else {
        
        
        if(block){
            block(nil);
        }

    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    /*
     vc.delegate = self;
     NSDictionary *item = [self.dataArray objectAtIndex:indexPath.row];
     //NSDictionary *data = [item objectForKey:@"DayDetailInfo"];
     vc.mData = item;
     */
    NSDictionary *item = self.dataArray[indexPath.row];
    
    
    
    NSString *key = [item objectForKey:@"key"];
    if([key isEqualToString:@"order"]){
        
        [self neeUserLoginUserAction:^(id sender){
            
            FoodOrderListViewController *foodOrderListVCtrl = [[FoodOrderListViewController alloc]init];
            [self.navigationController pushViewController:foodOrderListVCtrl animated:YES];
            SafeRelease(foodOrderListVCtrl);
        
        }];
        
    }
    if([key isEqualToString:@"userInfo"]) {
    
        [self neeUserLoginUserAction:^(id sender){
            
            UserInfoViewController *userVctl = [[UserInfoViewController alloc]init];
            
            [self.navigationController pushViewController:userVctl animated:YES];
            SafeRelease(userVctl);
            
        }];
        
        
        
    }
    if([key isEqualToString:@""]) {
    
        SettingViewController *setVctl = [[UserInfoViewController alloc]init];
        
        [self.navigationController pushViewController:setVctl animated:YES];
        SafeRelease(setVctl);
        
    }
}


-(void)didNetDataOK:(NSNotification*)ntf
{
    kNetEnd(self.view);
    //NE_LOG(@"warning not implemetation net respond");
    //self.view.userInteractionEnabled = YES;
    id obj = [ntf object];
    ZCSNetClient *respRequest = [obj objectForKey:@"request"];
    id _data = [obj objectForKey:@"data"];
    NSString *resKey = [respRequest resourceKey];
    if(resKey == @"userInfo")
    {
        
    }
    
}

- (void)didUserLogin:(NSNotification*) ntf {

    [self updateUIByUserInfoStatus];
}

-(void)didNetDataFailed:(NSNotification*)ntf
{
    //NE_LOG(@"warning not implemetation net respond");
    kNetEnd(self.view);
}

- (void)didUserRegister:(NSNotificationCenter*)ntf {
    
    [self dismissViewControllerAnimated:YES completion:^(){
        
    }];
}


@end
