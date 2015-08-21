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

#import "UserDinnerWatingMgr.h"
#import "RegisterView.h"

typedef enum resetPasswStage{
    ResetStageOne,
    ResetStageTwo,
}ResetPasswStage;

@interface CardShopResignViewController () {

    ResetPasswStage resetStage;
    
    RegisterView    *registerView;
    
    NSInteger       count;
    
}

@property (nonatomic, strong)  NSTimer         *timer;

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
    //if(kDeviceCheckIphone6 || kDeviceCheckIphone6Plus)
    {
    NSArray *nibArray = [[NSBundle  mainBundle] loadNibNamed:@"CardShopResignViewController" owner:self options:nil];
    NSInteger index = 0;
    
    if(kDeviceCheckIphone6){
        index = 1;
    }else if(kDeviceCheckIphone6Plus){
        index = 2;
    }
    registerView = nibArray[index];
    }
    self.view = registerView;
    
    self.view.backgroundColor = kNavBarColor;
    
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
        registerView.navTitleLabel.text = @"注册";
    }
    else
    {
        registerView.navTitleLabel.text = @"找回密码";
    }
    registerView.mobilePhoneTextFied.text = self.mobilePhoneNumStr;
    if(mobilePhoneTextFied.placeholder)
    {
        registerView.mobilePhoneTextFied.attributedPlaceholder = [UIComUtil getCustomAttributeString:registerView.mobilePhoneTextFied.placeholder withFont:registerView.mobilePhoneTextFied.font withColor:HexRGB(137, 137, 137)];
    }
    registerView.mobilePhoneTextFied.textColor =  HexRGB(137, 137, 137);
    
    if(registerView.radomCodeTextFied.attributedPlaceholder){
        registerView.radomCodeTextFied.attributedPlaceholder = [UIComUtil getCustomAttributeString:registerView.radomCodeTextFied.placeholder withFont:registerView.radomCodeTextFied.font withColor:HexRGB(137, 137, 137)];
        registerView.radomCodeTextFied.textColor = HexRGB(137, 137, 137);
    }
    if(registerView.passwordTextFied.attributedPlaceholder){
        registerView.passwordTextFied.attributedPlaceholder = [UIComUtil getCustomAttributeString:registerView.passwordTextFied.placeholder withFont:registerView.passwordTextFied.font withColor:HexRGB(137, 137, 137)];
        
        registerView.passwordTextFied.textColor =  HexRGB(137, 137, 137);
    }
    
    
    UIButton *btn = [UIComUtil createButtonWithNormalBGImageName:nil withHightBGImageName:nil withTitle:@"" withTag:0];
    
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0.f, 0.f, kDeviceScreenWidth,btn.frame.size.height)];
    btn.frame = CGRectMake(kDeviceScreenWidth-btn.frame.size.width, 0.f, btn.frame.size.width, btn.frame.size.height);
    [bgView addSubview:btn];
    
    [btn addTarget:self action:@selector(doneInput) forControlEvents:UIControlEventTouchUpInside];
    //[self.view addSubview:btn];
    registerView.radomCodeTextFied.inputAccessoryView = bgView;
    registerView.mobilePhoneTextFied.delegate = self;
    // Do any additional setup after loading the view from its nib.
    /*
    if(self.type == 1){
    
    }else {
    
    }*/
    [self reflushRandomCodeImage:nil];
    
    self.view.backgroundColor = kNavBarColor;
}
- (void)doneInput{
    [registerView.radomCodeTextFied resignFirstResponder];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    registerView.mobilePhoneTextFied = nil;
    registerView.passwordTextFied = nil;
    registerView.confirmPasswordTextFied = nil;
    registerView.radomCodeTextFied  = nil;
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
    if(self.cancelBlock){
    
        self.cancelBlock(nil);
        self.cancelBlock = nil;
        self.doneBlock = nil;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)reflushRandomCodeImage:(id)sender {

    if(self.type == 1)
    {
    
        
    
    } else {
        
       
    }
    
    [self startLoadRandomCodeImage];

}

- (IBAction)reflushPhoneRandomCode:(id)sender {

    
    [[UserDinnerWatingMgr sharedInstance] startGetRegisterUserSMSWithDone:^(id error){

        if(error == nil) {
            kUIAlertView(@"提示", @"短信已发送到手机");
            [self startTimer];
        }
        
    }];
}

- (void)startTimer {
    registerView.phoneCodeBtn.enabled = NO;
    count = 60.f;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(scheduleTimer) userInfo:nil repeats:YES];
    [self.timer fire];
}

- (void)scheduleTimer {

    count = count -1;
    if(count <= 0){
    
        [self  stopTimer];
        return;
    }
    NSString *timerStr = [NSString stringWithFormat:@"(%d)秒后重新发送",count];
    [registerView.phoneCodeBtn setTitle:timerStr forState:UIControlStateNormal];

}

- (void)stopTimer {

    [self.timer invalidate];
    self.timer = nil;
    registerView.phoneCodeBtn.enabled = YES;
    [registerView.phoneCodeBtn setTitle:@"获取手机验证码" forState:UIControlStateNormal];
}


-(IBAction)login_click:(id)sender
{
    
    [registerView.mobilePhoneTextFied resignFirstResponder];
    [registerView.radomCodeTextFied resignFirstResponder];
    [registerView.passwordTextFied resignFirstResponder];
    [registerView.confirmPasswordTextFied resignFirstResponder];
    if([registerView.mobilePhoneTextFied.text isEqualToString:@""] || [registerView.mobilePhoneTextFied.text length] <11){
        
        kUIAlertView(@"提示", @"手机号码输入不对");
        [registerView.mobilePhoneTextFied becomeFirstResponder];
        return;
    }
    if([registerView.passwordTextFied.text isEqualToString:@""]){
        kUIAlertView(@"提示", @"密码不能为空");
        [registerView.passwordTextFied becomeFirstResponder];
        return;
    }
    if([self.radomCodeTextFied.text isEqualToString:@""])
    {
       kUIAlertView(@"提示", @"验证码不能为空");
        [registerView.radomCodeTextFied becomeFirstResponder];
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
        if(resetStage == ResetStageOne){
        
            kNetStartShow(@"短信验证中...",self.view);
            
            /*
             appkey	string	应用appkey	必填
             phone	string	电话号码	必填(不带区号电话号码 eg.13121222212)
             zone	string	区号	必填(纯数字区号 eg.86)
             code	string	需要验证的验证码
             */
            NSDictionary *verfyData = @{@"phone":registerView.mobilePhoneTextFied.text,
                                        @"code":registerView.radomCodeTextFied.text};
            
            [[UserDinnerWatingMgr sharedInstance] startVeryRegisterUserSMS:verfyData
                                                                  withDone:^(id data ){
                                                                      if(data){
                                                                          
                                                                          [self startLogin];
                                                                      }
                                                                      
                }
                                                                 withError:^(id data){
            
                                                                     if(data){
                                                                     
                                                                         kUIAlertView(@"提示", @"请检查手机号和验证码是否正确!!");
                                                                         
                                                                     }
                                                                    kNetEnd(self.view);
                                                                 }];
            
        }
        
        kNetStartShow(@"发送中...",self.view);
    }
    MobileOrderNetDataMgr *cardShopMgr = [MobileOrderNetDataMgr getSingleTone];
    
    NSDictionary *param = nil;
    if(type == 0)
    {
        param = [NSDictionary dictionaryWithObjectsAndKeys:
                           registerView.mobilePhoneTextFied.text,@"mobile",
                           [registerView.passwordTextFied.text getMd5String],@"password",
                           //self.confirmPasswordTextFied.text,@"repassword",
                           nil];
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:param];
        if(![registerView.radomCodeTextFied.text isEqualToString:@""]){
            [dict setValue:registerView.radomCodeTextFied.text forKey:@"captcha"];
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
                 registerView.mobilePhoneTextFied.text,@"mobile",
                 [registerView.passwordTextFied.text getMd5String],@"password",
                 //registerView.confirmPasswordTextFied.text,@"repassword",
                 //registerView.radomCodeTextFied.text,@"sms",
                 nil];
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:param];
        if(![registerView.radomCodeTextFied.text isEqualToString:@""]){
            [dict setValue:registerView.radomCodeTextFied.text forKey:@"captcha"];
        }
        self.request = [cardShopMgr userResetPassword:param];
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
    if(self.request == respRequest&&([resKey isEqualToString:kNetResignRes]|| [resKey isEqualToString:@"resetpassword"]))
    {
        self.request = nil;
        kNetEnd(self.view);
        //if([[_data objectForKey:@"retType"]intValue] == 0)
        {
            //[AppSetting setLoginUserInfo:param];
#if 1
            [AppSetting setLoginUserId:registerView.mobilePhoneTextFied.text];
            [AppSetting setLoginUserPassword:[registerView.passwordTextFied.text getMd5String]];
#endif
            NE_LOG(@"%@",[_data description]);
            //[self stopShowLoadingView];
            //[Ap]
            
            //[ZCSNotficationMgr postMSG:kCheckCardRecentRun obj:nil];
            
        }
        if([resKey isEqualToString:kNetResignRes])
        {
            kUIAlertView(@"提示", @"注册成功");
            [ZCSNotficationMgr postMSG:kUserDidResignOK obj:@{@"mobile":registerView.mobilePhoneTextFied.text,
                                                              @"password":registerView.passwordTextFied.text,}];
        } else {
            kUIAlertView(@"提示", @"修改密码成功");
            if(self.doneBlock){
            
                self.doneBlock(@{@"mobile":registerView.mobilePhoneTextFied.text,
                                 @"password":registerView.passwordTextFied.text,});
                self.doneBlock = nil;
                self.cancelBlock = nil;
            }
        }
        //else
        
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
        //kUIAlertView(@"提示",@"网络错误");
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
#if 0
    NTESMBIconDownloader *_downloader = [[NTESMBIconDownloader alloc]initWithUrlString:randURLStr];
    _downloader.delegate = self;
    _downloader.cellIndex = index;
    [[NTESMBServer getInstance] addRequest:_downloader];
    SafeRelease(_downloader);
#else
    NSError *error = nil;
    NSData *data =  nil;
    
    NSURL *url = [NSURL URLWithString:randURLStr];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    //NSURLConnection *connet = [NSURLConnection connectionWithRequest:urlRequest delegate:self];
    //[connet start];
    NSURLResponse *respond = nil;
    data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&respond error:&error];
    if(respond){
    
        [self setImageWithData:data];
    }
#endif
    
}

#pragma mark -
#pragma mark -

- (void) setImageWithData:(NSData*)receiveData {

    UIImage *image = [UIImage imageWithData:receiveData];
    
    [registerView.radomCodeBtn setImage:image forState:UIControlStateNormal];
    [registerView.radomCodeBtn setImage:image forState:UIControlStateSelected];
}

- (void) requestCompleted:(MemoPhotoDownloader *) request{
    //if (request == _downloader)
    {
        if(request.receiveData){
            //[[NTESMBLocalImageStorage getInstance] saveImageDataToOriginalDir:request.receiveData urlString:request.urlString];
        }
        
        UIImage *image = [UIImage imageWithData:request.receiveData];
        
        [registerView.radomCodeBtn setImage:image forState:UIControlStateNormal];
        [registerView.radomCodeBtn setImage:image forState:UIControlStateSelected];
        
    }
    request.delegate = nil;
    request = nil;
}

- (void) requestFailed:(MemoPhotoDownloader *) request{
    
    
}

@end
