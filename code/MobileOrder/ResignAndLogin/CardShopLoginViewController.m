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
#import "CarServiceNetDataMgr.h"
#import "AppSetting.h"
#import "DeviceVersion.h"
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
@interface CardShopLoginViewController ()

@end

@implementation CardShopLoginViewController
@synthesize txtusername;
@synthesize txtpassword;
@synthesize request;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString  *username=@"";
    NSString  *password=@"";
    
//    UIImage *bgImage = nil;
//    UIImageWithFileName(bgImage, @"login_bg.png");
//    self.view.layer.contents = (id)bgImage.CGImage;
    navBarView.backgroundColor = HexRGB(1, 159, 233);
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
    self.txtpassword.text = @"";
    self.txtusername.text = @"";
    if (![username isEqualToString:@""])
    {
        self.txtpassword.text=password;
        self.txtusername.text=username;
        
        //[self login_click:nil];
    }
    
  
    if(self.txtpassword)
    {
        if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"6.0")){
            NSMutableAttributedString *ms = [[NSMutableAttributedString alloc] initWithString:self.txtpassword.placeholder];
            UIFont *placeholderFont = self.txtpassword.font;
            NSRange fullRange = NSMakeRange(0, ms.length);
            NSDictionary *newProps = @{NSForegroundColorAttributeName: HexRGB(137, 137, 137), NSFontAttributeName:placeholderFont};
            [ms setAttributes:newProps range:fullRange];
            self.txtpassword.attributedPlaceholder = ms;
            SafeRelease(ms);
        }

    }
    //self.txtpassword.placeholder
    self.txtpassword.textColor = HexRGB(137, 137, 137);
    
    if(self.txtusername)
    {
       if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"6.0")){
           NSMutableAttributedString *ms = [[NSMutableAttributedString alloc] initWithString:txtusername.placeholder];
           UIFont *placeholderFont = self.txtusername.font;
           NSRange fullRange = NSMakeRange(0, ms.length);
           NSDictionary *newProps = @{NSForegroundColorAttributeName: HexRGB(137, 137, 137), NSFontAttributeName:placeholderFont};
           [ms setAttributes:newProps range:fullRange];
           self.txtusername.attributedPlaceholder = ms;
           SafeRelease(ms);
       }
    }
    
    self.txtusername.textColor = HexRGB(137, 137, 137);
    
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
-(IBAction)login_click:(id)sender
{
    
    //[ZCSNotficationMgr postMSG:kDisMissModelViewController obj:nil];
    
    [self.txtusername resignFirstResponder];
    [self.txtpassword resignFirstResponder];
//    if([self.txtusername.text length]<11)
//    {
//        kUIAlertView(@"提示", @"输入的手机号码不对");
//        [self.txtusername becomeFirstResponder];
//        return;
//    }
    if([self.txtusername.text length] == 0|| [self.txtpassword.text length] ==0){
        kUIAlertView(@"提示", @"帐号或密码不能为空");
        [self.txtusername becomeFirstResponder];
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
    [frmobj release];
#endif
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
    CarServiceNetDataMgr *cardShopMgr = [CarServiceNetDataMgr getSingleTone];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                              self.txtusername.text,@"umcLoginName",
                              self.txtpassword.text,@"loginPassword",
                              nil];
   
    self.request = [cardShopMgr  carUserLogin:param];
#else
    [self didNetDataOK:[NSNotification notificationWithName:kNetLoginRes object:[NSDictionary  dictionaryWithObjectsAndKeys:kNetLoginRes,@"key",nil]]];
#endif

}
-(IBAction)cancelLogin:(id)sender
{
    [ZCSNotficationMgr postMSG:kDisMissModelViewController obj:nil];
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
            CarServiceNetDataMgr *cardShopMgr = [CarServiceNetDataMgr getSingleTone];
            
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
            [AppSetting setLoginUserDetailInfo:userData userId:self.txtusername.text];
            //[AppSetting setLoginUserInfo:];
            [AppSetting setLoginUserId:self.txtusername.text];
            [AppSetting setLoginUserPassword:self.txtpassword.text];
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
