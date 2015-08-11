//
//  frmRegist.m
//  kkshop
//
//  Created by apple  on 12-8-7.
//
//

#import "CardShopResignViewController.h"
//#import "AppDelegate.h"
#import "AppConfig.h"
#import "DressMemoPhotoCache.h"
#import "MemoPhotoDownloader.h"
@interface CardShopResignViewController ()

@end

@implementation CardShopResignViewController
@synthesize navTitleLabel;
@synthesize confirmPasswordTextFied;
@synthesize mobilePhoneTextFied;
@synthesize passwordTextFied;
@synthesize radomCodeTextFied;
@synthesize mobilePhoneNumStr;
@synthesize type;

-(void)dealloc
{
    self.navTitleLabel = nil;
    self.mobilePhoneTextFied = nil;
    self.passwordTextFied = nil;
    self.confirmPasswordTextFied = nil;
    self.radomCodeTextFied  = nil;
    self.mobilePhoneNumStr = nil;
    SuperDealloc;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}
- (void)awakeFromNib{

    
    
}
- (void)viewDidLoad
{
    //[super viewDidLoad];
    if(kDeviceCheckIphone6 || kDeviceCheckIphone6Plus){
    NSArray *nibArray = [[NSBundle  mainBundle] loadNibNamed:@"CardShopResignViewController" owner:self options:nil];
    NSInteger index = 0;
    
    if(kDeviceCheckIphone6){
        index = 1;
    }else if(kDeviceCheckIphone6Plus){
        index = 2;
    }
    self.view = nibArray[index];
    }

    self.view.backgroundColor = kViewBGColor;
    UIScrollView *bgScrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0.f,0.f, kDeviceScreenWidth, kDeviceScreenHeight-kMBAppStatusBar)];
    for(id item in [self.view subviews]){
        [item removeFromSuperview];
        [bgScrollerView addSubview:item];
    }
    [self.view addSubview:bgScrollerView];
    bgScrollerView.contentSize = CGSizeMake(kDeviceScreenWidth, kDeviceScreenHeight-kMBAppStatusBar-40.f);
    
    UIImage *bgImage = nil;
    UIImageWithFileName(bgImage, @"car_bg.png");
    self.view.layer.contents = (id)bgImage.CGImage;
    if(type ==0)
    {
        navTitleLabel.text = @"注册";
    }
    else
    {
        navTitleLabel.text = @"找回密码";
    }
    mobilePhoneTextFied.text = self.mobilePhoneNumStr;
    
    mobilePhoneTextFied.attributedPlaceholder = [UIComUtil getCustomAttributeString:mobilePhoneTextFied.placeholder withFont:mobilePhoneTextFied.font withColor:HexRGB(137, 137, 137)];
    
    mobilePhoneTextFied.textColor =  HexRGB(137, 137, 137);
    
    radomCodeTextFied.attributedPlaceholder = [UIComUtil getCustomAttributeString:radomCodeTextFied.placeholder withFont:radomCodeTextFied.font withColor:HexRGB(137, 137, 137)];
    self.radomCodeTextFied.textColor = HexRGB(137, 137, 137);
    
     passwordTextFied.attributedPlaceholder = [UIComUtil getCustomAttributeString:passwordTextFied.placeholder withFont:passwordTextFied.font withColor:HexRGB(137, 137, 137)];
    
    self.passwordTextFied.textColor =  HexRGB(137, 137, 137);
    
    
    
    UIButton *btn = [UIComUtil createButtonWithNormalBGImageName:nil withHightBGImageName:nil withTitle:@"" withTag:0];
    
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0.f, 0.f, kDeviceScreenWidth,btn.frame.size.height)];
    btn.frame = CGRectMake(kDeviceScreenWidth-btn.frame.size.width, 0.f, btn.frame.size.width, btn.frame.size.height);
    [bgView addSubview:btn];
    
    [btn addTarget:self action:@selector(doneInput) forControlEvents:UIControlEventTouchUpInside];
    //[self.view addSubview:btn];
    self.radomCodeTextFied.inputAccessoryView = bgView;
    mobilePhoneTextFied.delegate = self;
    // Do any additional setup after loading the view from its nib.
    [self startLoadRandomCodeImage];
}
- (void)doneInput{
    [self.radomCodeTextFied resignFirstResponder];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    self.mobilePhoneTextFied = nil;
    self.passwordTextFied = nil;
    self.confirmPasswordTextFied = nil;
    self.radomCodeTextFied  = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction)goBack:(id)sender
{
    /*
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    int count=[delegate.navi.viewControllers  count ]-1;
	[delegate.navi popToViewController: [self.navigationController.viewControllers objectAtIndex: count-1] animated:YES];
    */
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)reflushRandomCodeImage:(id)sender {

    [self startLoadRandomCodeImage];
}

-(IBAction)login_click:(id)sender
{
    
    [self.mobilePhoneTextFied resignFirstResponder];
    [self.radomCodeTextFied resignFirstResponder];
    [self.passwordTextFied resignFirstResponder];
    [self.confirmPasswordTextFied resignFirstResponder];
    if([self.mobilePhoneTextFied.text isEqualToString:@""] || [self.mobilePhoneTextFied.text length] <11){
        
        kUIAlertView(@"提示", @"手机号码输入不对");
        [self.mobilePhoneTextFied becomeFirstResponder];
        return;
    }
    if([self.passwordTextFied.text isEqualToString:@""]){
        kUIAlertView(@"提示", @"密码不能为空");
        [self.passwordTextFied becomeFirstResponder];
        return;
    }
    if([self.radomCodeTextFied.text isEqualToString:@""])
    {
       kUIAlertView(@"提示", @"验证码不能为空");
        [self.radomCodeTextFied becomeFirstResponder];
        return;
    }
    [self startLogin];
}

/*
 *username	用户名	必须 ，格式是手机号
 password	密码	必须
 repassword	密码	必须
 captcha	验证码	必须，验证码
 */

-(void)startLogin
{
    //if([self check])
    if(type == 0){
        kNetStartShow(@"注册中...",self.view);
    }
    else
    {
        kNetStartShow(@"发送中...",self.view);
    }
    MobileOrderNetDataMgr *cardShopMgr = [MobileOrderNetDataMgr getSingleTone];
    
    NSDictionary *param = nil;
    if(type == 0)
    {
        param = [NSDictionary dictionaryWithObjectsAndKeys:
                           self.mobilePhoneTextFied.text,@"mobile",
                           self.passwordTextFied.text,@"password",
                           //self.confirmPasswordTextFied.text,@"repassword",
                           nil];
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:param];
        if(![self.radomCodeTextFied.text isEqualToString:@""]){
            [dict setValue:self.radomCodeTextFied.text forKey:@"captcha"];
         }
        /**
         userName, String password, String mobile
         */
        //self.radomCodeTextFied.text,@"phoneNumber",
         self.request = [cardShopMgr  userResign:dict];
        
    }
    else
    {
        param = [NSDictionary dictionaryWithObjectsAndKeys:
                 self.mobilePhoneTextFied.text,@"username",
                 self.passwordTextFied.text,@"password",
                 self.confirmPasswordTextFied.text,@"repassword",
                 self.radomCodeTextFied.text,@"sms",
                 nil];
        //self.request = [cardShopMgr userResetPassword:param];
    }
   
    
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
    id _data = [obj objectForKey:@"data"];
    NSString *resKey = [respRequest resourceKey];
    if(self.request == respRequest&&([resKey isEqualToString:kNetResignRes]|| [resKey isEqualToString:@"findpassword"]))
    {
        self.request = nil;
        kNetEnd(self.view);
        //if([[_data objectForKey:@"retType"]intValue] == 0)
        {
            //[AppSetting setLoginUserInfo:param];
#if 1
            [AppSetting setLoginUserId:self.mobilePhoneTextFied.text];
            [AppSetting setLoginUserPassword:self.passwordTextFied.text];
#endif
            NE_LOG(@"%@",[_data description]);
            //[self stopShowLoadingView];
            //[Ap]
            /*
            [ZCSNotficationMgr postMSG:kCheckCardRecentRun obj:nil];
            [ZCSNotficationMgr postMSG:kDisMissModelViewController obj:nil];
            */
        }
        //else
        {
            kUIAlertView(@"提示", @"注册失败,用户名已存在");
        }
    }
    
}
-(void)didNetDataFailed:(NSNotification*)ntf
{
      id obj = [ntf object];
    id respRequest = [obj objectForKey:@"request"];
    id _data = [obj objectForKey:@"data"];
    NSString *resKey = [respRequest resourceKey];
    if([resKey isEqualToString:kNetResignRes]){
        kNetEnd(self.view);
        kUIAlertView(@"提示",@"网络错误");
    }
    //NE_LOG(@"warning not implemetation net respond");
}
-(void)textFieldDidEndEditing:(id)sender
{
    //if(sender == self.confirmPasswordTextFied)
    if(sender == self.passwordTextFied)
        [sender resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
//    if(textField == self.mobilePhoneTextFied){
//        [self.passwordTextFied becomeFirstResponder];
//        return NO;
//    }
    //if(textField == self.passwordTextFied)
    [textField resignFirstResponder];
    return YES;
}

- (void)startLoadRandomCodeImage {

    NSString *randURLStr = [NSString stringWithFormat:@"%@/account/captcha.html",kRequestApiRoot];
    NTESMBIconDownloader *_downloader = [[NTESMBIconDownloader alloc]initWithUrlString:randURLStr];
    _downloader.delegate = self;
    _downloader.cellIndex = index;
    [[NTESMBServer getInstance] addRequest:_downloader];
    SafeRelease(_downloader);
}

#pragma mark -
#pragma mark -

- (void) requestCompleted:(MemoPhotoDownloader *) request{
    //if (request == _downloader)
    {
        if(request.receiveData){
            //[[NTESMBLocalImageStorage getInstance] saveImageDataToOriginalDir:request.receiveData urlString:request.urlString];
        }
        
        UIImage *image = [UIImage imageWithData:request.receiveData];
        
        [self.radomCodeBtn setImage:image forState:UIControlStateNormal];
        [self.radomCodeBtn setImage:image forState:UIControlStateSelected];
        
    }
    request.delegate = nil;
    request = nil;
}

- (void) requestFailed:(MemoPhotoDownloader *) request{
    
    
}

@end
