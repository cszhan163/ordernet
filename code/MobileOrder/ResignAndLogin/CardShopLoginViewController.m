  //
//  CardShopLoginViewController.m
//  kkshop
//
//  Created by apple  on 12-8-7.
//
//

#import "CardShopLoginViewController.h"
#import "ResetPasswordViewController.h"
#import "CardShopResignViewController.h"
#import "MobileOrderNetDataMgr.h"
#import "AppSetting.h"
#import "DeviceVersion.h"
#import "LoginView.h"
/*
 
 
 
 */
//#define kUserDataDict  @{\
//                        @"shanghai_1":@{@"hydm":@"007624",@"czy":@"U64959"},\
//                        @"shanghai_2":@{@"hydm":@"007625 ",@"czy":@"U64979"},\
//                        @"shanghai_3":@{@"hydm":@"007626",@"czy":@"U64982"}\
//                        }

#define kUserDataDict  @{\
@"moni":@{@"hydm":@"007650",@"czy":@"U65243"},\
@"moni02":@{@"hydm":@"007654 ",@"czy":@"U65246"},\
@"moni03":@{@"hydm":@"007651",@"czy":@"U65247"},\
@"moni04":@{@"hydm":@"007652 ",@"czy":@"U65248"},\
@"moni05":@{@"hydm":@"007653",@"czy":@"U65249"},\
@"shanghai_1":@{@"hydm":@"007624",@"czy":@"U64959"},\
@"shanghai_2":@{@"hydm":@"007625",@"czy":@"U64979"},\
@"shanghai_3":@{@"hydm":@"007626",@"czy":@"U64982"}\
}
@interface CardShopLoginViewController () {

    BlockWithSender _doneBlock;
    BlockWithSender _cancelBlock;
    IBOutlet LoginView *loginView;
}

@end

@implementation CardShopLoginViewController
@synthesize request;

- (void)dealloc {
    [self setCompleteAction:nil];
    [self setCancelAction:nil];
    
    
    SuperDealloc;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
                // Custom initialization
    }
    return self;
}

- (void)awakeFromNib {

    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *nibArray = [[NSBundle  mainBundle] loadNibNamed:@"CardShopLoginViewController" owner:self options:nil];
    NSInteger index = 0;
    
    if(kDeviceCheckIphone6){
        index = 1;
    }else if(kDeviceCheckIphone6Plus){
        index = 2;
    }
    loginView = nibArray[index];
    
    
    self.view = loginView;
    

    
    NSString  *username=@"";
    NSString  *password=@"";
#if 0
    UIImage *image = nil;
    UIImageAutoScaleWithFileName(image,@"user_auto_no");
    assert(image);
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setImage:image forState:UIControlStateNormal];
    
    UIImageAutoScaleWithFileName(image,@"user_auto_yes");
    assert(image);
    
    [btn setImage:image forState:UIControlStateSelected];
    
    [btn addTarget:self action:@selector(autoLoginClick:) forControlEvents:UIControlEventTouchUpInside];
    //[self.view addSubview:btn];
    [btn sizeToFit];
    [self.view addSubview:btn];

    
    self.autoLoginBtn = btn;
#endif
    
   
    
//    UIImage *bgImage = nil;
//    UIImageWithFileName(bgImage, @"login_bg.png");
//    self.view.layer.contents = (id)bgImage.CGImage;
    self.view.backgroundColor = HexRGB(239, 239, 241);
    //self.txtpassword
    /*
    NSString   *filename=[self GetTempPath:@"username.txt"];
     NSError *err;
    if([self is_file_exist:filename]){
        
        username=[NSString stringWithContentsOfFile:filename encoding:NSUTF8StringEncoding error:&err];
    }
    
    filename=[self GetTempPath:@"password.txt"];
    if([self is_file_exist:filename]){
        
        password=[NSString stringWithContentsOfFile:filename encoding:NSUTF8StringEncoding error:&err];
    }
    */
   
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (IBAction)textFieldDidEndEditing:(id)sender
{
	[sender resignFirstResponder];

}

- (void)didLoginAction:(id)sender {

    [self login_click:nil];
}

-(IBAction)login_click:(id)sender
{
    //[ZCSNotficationMgr postMSG:kDisMissModelViewController obj:nil];
    [loginView.txtusername resignFirstResponder];
    [loginView.txtpassword resignFirstResponder];
        if([loginView.txtusername.text length]<11)
        {
            kUIAlertView(@"提示", @"输入的手机号码不对");
            [loginView.txtusername becomeFirstResponder];
            return;
        }
    if([loginView.txtusername.text length] == 0|| [loginView.txtpassword.text length] ==0){
        kUIAlertView(@"提示", @"帐号或密码不能为空");
        [loginView.txtusername becomeFirstResponder];
        return;
    }
    [self startLogin];
}
-(IBAction)regist_click:(id)sender
{
#if 0
    ResetPasswordViewController *frmobj=[[ResetPasswordViewController alloc] init];
    frmobj.type = 0;
    [self.navigationController pushViewController:frmobj animated:YES];
    [frmobj release];
#else
    CardShopResignViewController *frmobj=[[CardShopResignViewController alloc] init];
    /*
    frmobj.mobilePhoneNumStr = subClassInputTextField.text;
    frmobj.type = self.type;
     */
    [self.navigationController pushViewController:frmobj animated:YES];
    SafeRelease(frmobj);
#endif
}

- (IBAction)autoLoginClick:(id)sender {
    BOOL isSelected = loginView.autoLoginBtn.selected;
    loginView.autoLoginBtn.selected = !isSelected;
    
    [AppSetting setUserAutoLogin:isSelected];
}

-(IBAction)findpw_click:(id)sender
{
    /*
    ResetPasswordViewController *resPsVc=[[ResetPasswordViewController alloc] init];
    resPsVc.type = 1;//forget password
    [self.navigationController pushViewController:resPsVc animated:YES];
    [resPsVc release];
    */
//    if(self.isModel){
//        [ZCSNotficationMgr postMSG:kDisMissModelViewController obj:nil];
//    }
//    else{
//        [ZCSNotficationMgr postMSG:kUserDidLoginCancel obj:nil];
//        //[self.navigationController  popToRootViewControllerAnimated:YES];
//    }
//
    CardShopResignViewController *frmobj=[[CardShopResignViewController alloc] init];
    /*
     frmobj.mobilePhoneNumStr = subClassInputTextField.text;
     */
     frmobj.type = 1;
    
    [self.navigationController pushViewController:frmobj animated:YES];
    SafeRelease(frmobj);
    
    [ZCSNotficationMgr postMSG:kUserDidLoginCancel obj:nil];
}

-(void)startLogin
{
    //if([self check])
//    if([kUserDataDict objectForKey:self.txtusername.text]){
//        
//    }
//    else{
//        kUIAlertView(@"提示", @"没有该用户");
//        return;
//    }
    //kNetStartShow(@"登录中...",self.view);
#if 1
    MobileOrderNetDataMgr *cardShopMgr = [MobileOrderNetDataMgr getSingleTone];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                              loginView.txtusername.text,@"umcLoginName",
                              loginView.txtpassword.text,@"loginPassword",
                              nil];
   
    self.request = [cardShopMgr  userLogin:param];
#else
    [self didNetDataOK:[NSNotification notificationWithName:kNetLoginRes object:[NSDictionary  dictionaryWithObjectsAndKeys:kNetLoginRes,@"key",nil]]];
#endif

}
-(IBAction)cancelLogin:(id)sender
{
    //[ZCSNotficationMgr postMSG:kDisMissModelViewController obj:nil];
    
    if(_cancelBlock){
        _cancelBlock(nil);
        [self setCancelAction:nil];
    }
    [self setCompleteAction:nil];
}


- (void)setCompleteAction:(BlockWithSender) block {

    Block_release(_doneBlock);
    _doneBlock = Block_copy(block);
    
}

- (void)setCancelAction:(BlockWithSender) block {
    
    Block_release(_cancelBlock);
    _cancelBlock = Block_copy(block);
    
}


#pragma mark net work respond failed

-(void)didNetDataOK:(NSNotification*)ntf
{
    id obj = [ntf object];
    id respRequest = [obj objectForKey:@"request"];
    id data = [obj objectForKey:@"data"];
    NSString *resKey = [obj objectForKey:@"key"];//[respRequest resourceKey];
    if([resKey isEqualToString:kNetLoginRes])
    {
      
        self.request = nil;
        NE_LOG(@"%@",[data description]);
        //[self stopShowLoadingView];
        //[Ap]
        NSString *useDataString = [data objectForKey:@"dataString"];
        NSError *error = nil;
        
        //kNetEnd(self.view);
#if 1
        //[AppSetting setCurrentLoginUser:self.txtusername.text];
        NSDictionary *userReturnData = [NSJSONSerialization JSONObjectWithData:[useDataString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];; //[kUserDataDict objectForKey:self.txtusername.text];
        if([[userReturnData objectForKey:@"isSuccess"] isEqualToString:@"1"]){
        
            //hydm":@"007652 ",@"czy":@"U65248"},
            MobileOrderNetDataMgr *cardShopMgr = [MobileOrderNetDataMgr getSingleTone];
            
            self.useId = [userReturnData objectForKey:@"bspCompanyCode"];
            self.userName = [userReturnData objectForKey:@"chineseFullname"];
            NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                                   self.useId,@"bspCompanyCode",
                                   nil];
           
            [cardShopMgr  getUserAccountInfo:param];
            
            
        }
        else{
            //NSDictionary *msgDict = [userReturnData objectForKey:@"openAppClusters"];
            NSString *msg = [userReturnData objectForKey:@"resultDesc"];
            kUIAlertView(@"提示", msg);
        }
        
              //[self findpw_click:nil];
#endif
        
    }
    if([resKey isEqualToString:kResUserInfoData]){
        
        NSDictionary *userData = @{@"hydm":[data objectForKey:@"hydm"],@"czy":self.useId,@"company":self.userName};
        
        if(userData){
            [AppSetting setLoginUserDetailInfo:userData userId:loginView.txtusername.text];
            //[AppSetting setLoginUserInfo:];
            [AppSetting setLoginUserId:loginView.txtusername.text];
            [AppSetting setLoginUserPassword:loginView.txtpassword.text];
            
            if(_doneBlock) {
                
                _doneBlock(userData);
            }
            
            [ZCSNotficationMgr postMSG:kUserDidLoginOk obj:nil];

        }
        
    }
    
}
-(void)didNetDataFailed:(NSNotification*)ntf
{
    id obj = [ntf object];
    id respRequest = [obj objectForKey:@"request"];
    NSDictionary *_data = [obj objectForKey:@"data"];
     NSString *resKey = [obj objectForKey:@"key"];
    if([resKey isEqualToString:kNetLoginRes])
    {
        kNetEnd(self.view);
        //NSDictionary * _data = [obj objectForKey:@"data"];
        kUIAlertView(@"提示",[_data objectForKey:@"msg"]);
        
    }
    if([resKey isEqualToString:kCarInfoQuery]){
        kNetEnd(self.view);
        //NSDictionary * _data = [obj objectForKey:@"data"];
        kUIAlertView(@"提示",[_data objectForKey:@"msg"]);
    }
    NE_LOG(@"warning not implemetation net respond");
}
@end
