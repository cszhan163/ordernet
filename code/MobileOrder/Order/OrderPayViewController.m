//
//  OrderPayViewController.m
//  MobileOrder
//
//  Created by cszhan on 15-6-17.
//  Copyright (c) 2015年 com.ximalaya. All rights reserved.
//

#import "OrderPayViewController.h"

#import "DinnerWaitingViewController.h"
#import "ZHPickView.h"


#import "Order.h"
#import <RSADataSigner.h>
#import <AlipaySDK/AlipaySDK.h>

#import "UserDinnerWatingMgr.h"

#define kLeftPendingX    10.f



#define kArriveTimeFormat   @"到店时间:    %ld 分"

#define kPayTotalFormat     @"支付金额:    %0.2lf 元"

#define kUserNameFormat     @"姓       名:     %@"

#define kPhoneNumberFormat  @"手机号   :     %@"



#define kAliPayPartner             @"2088021531094405"//@"2088911644524097"

#define kAliPaySaller              @"403145040@qq.com"//@"dashang@ximalaya.com"

//#define kAliPayKey                 @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDnP/nAYreX+RNSiDqgMysmkC9YYJtpNq3pl8HwxPw9duY8H18juRUvCf42zmviiaAdth1KTozFE4Rtv170wF2u8+BVGUwL85hs9GJAQ8BHc8RNdA20sSHuZZNUUXw+oudr2ZyvZXD+jGWanfOVdsVj4Fq9Lq7q7WrfC/pZ4fPz2QIDAQAB"
#define kAliPayKey                 @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAOc/+cBit5f5E1KI\
OqAzKyaQL1hgm2k2remXwfDE/D125jwfXyO5FS8J/jbOa+KJoB22HUpOjMUThG2/\
XvTAXa7z4FUZTAvzmGz0YkBDwEdzxE10DbSxIe5lk1RRfD6i52vZnK9lcP6MZZqd\
85V2xWPgWr0ururtat8L+lnh8/PZAgMBAAECgYEAsO57CZ6+N/Hjvc7rhC0CQ/Qn\
tWfdIKgsckChq7UcBW8Wg0PBiFSRB7eOoKJZWy/PqUvwpyzoedUQCuRUI9GXGtNV\
50Hod0Ip2GzALBE4196UMdPzEuLDpzO77quj27aC42KoPmNInpVVanFrO4WyBVRK\
xeVkxGovLuSPc84jnwECQQD+3avRskutJXeN44T9bz5UN7yBkSm0uhWLUQwF1KpD\
OBu7BeZUxGGmS0CkecNildQFpws4yuIWceJdjtYribvhAkEA6EdnBIb7l3NmVsXA\
8I0pVL88NlE8EpiX9gLcb5qn8N0s38d4Yw4QvuS7CLozMv/LsryBkMpPNStUuveg\
DLL2+QJAMgjOrHI2TR2n5OEfwKlQMTRn+3/GEkbd5+XXWGWxr1SajRLRbx7GlOD9\
Jc0JwJbtctaia1nZHNLqv7dE8HMvwQJBANPYq4BZjAUpXuEtIzdBx7xfXg88L8nW\
GmJpYZr4NstbLZ47UvUk0ukHu/3NtPyCh8nQW2su2ObpSjHrvrFWWCECQALT/X0k\
/yqq1TPAvoie/173o3pk4aaf+ZBSJQi+JMNd0vl6P72MIkNFysE2u7475DDwuKnb\
c3pMFKL9Sr6bpjQ="

@interface OrderPayViewController () {

    ZHPickView *_pickview ;
    UILabel    *_arriveTimeLabel;
    UILabel    *_userNameLabel;
    UILabel    *_phoneNumberLabel;
    UILabel    *_totalPayLabel;
    UIScrollView *contentView;
    
}

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
    NSDictionary *userData = [AppSetting getLoginUserData:[AppSetting getLoginUserId]];
    self.orderItem.userItem.name = [userData objectForKey:@"userName"];
    contentView =[[UIScrollView alloc]initWithFrame:CGRectMake(0.f, 0.f, kDeviceScreenWidth, kDeviceScreenHeight)];
    
    [self.view addSubview:contentView];
    
    SafeRelease(contentView);
    
    CGFloat orderHeaderViewHeight = 140.f;
    CGFloat orderPayViewHeight = 140.f;
    CGFloat orderNoteViewHeigt = 80.f;
    CGFloat itemPendinxY = 10.f;
    if(kDeviceCheckIphone5){
        
        orderNoteViewHeigt = 120.f;
        itemPendinxY = 30.f;
    }

    CGFloat currY = itemPendinxY+10.f;
    if(kIsIOS7Check){
    
        currY =  currY + kMBAppTopToolBarHeight + kMBAppStatusBar;
    }else {
    
        currY =  currY + kMBAppTopToolBarHeight;
    }

    CGFloat labelHeight = 30.f;
    UIView *orderHeaderView = [[UIView alloc]initWithFrame:CGRectMake(kLeftPendingX,currY, kDeviceScreenWidth-2*kLeftPendingX,orderHeaderViewHeight)];
    
    
    CGFloat headerCurrY = kLeftPendingX;
    orderHeaderView.backgroundColor = [UIColor whiteColor];
    orderHeaderView.layer.cornerRadius = 5.f;
    
    _totalPayLabel = [UIComUtil createLabelWithFont:kGoodsOrderMenuTextFont withTextColor:[UIColor blackColor] withText:@"" withFrame:CGRectMake(0,headerCurrY,orderHeaderView.frame.size.width,labelHeight)];
    //_totalPayLabel.backgroundColor = [UIColor clearColor];
    _totalPayLabel.textAlignment = NSTextAlignmentLeft;
    _totalPayLabel.text  = [NSString stringWithFormat:kPayTotalFormat,self.orderItem.payPrice];

     [orderHeaderView addSubview:_totalPayLabel];
    
    headerCurrY = headerCurrY+ labelHeight;
    
    _userNameLabel = [UIComUtil createLabelWithFont:kGoodsOrderMenuTextFont withTextColor:[UIColor blackColor] withText:@"" withFrame:CGRectMake(0,headerCurrY,orderHeaderView.frame.size.width,labelHeight)];
    //_userNameLabel.backgroundColor = [UIColor redColor];
    _userNameLabel.textAlignment = NSTextAlignmentLeft;
    _userNameLabel.text  = [NSString stringWithFormat:kUserNameFormat,self.orderItem.userItem.name];
    
    [orderHeaderView addSubview:_userNameLabel];
    
    headerCurrY = headerCurrY+ labelHeight;
    
    _phoneNumberLabel = [UIComUtil createLabelWithFont:kGoodsOrderMenuTextFont withTextColor:[UIColor blackColor] withText:@"" withFrame:CGRectMake(0,headerCurrY,orderHeaderView.frame.size.width,labelHeight)];
    //_phoneNumberLabel.backgroundColor = [UIColor redColor];
    _phoneNumberLabel.textAlignment = NSTextAlignmentLeft;
    _phoneNumberLabel.text  = [NSString stringWithFormat:kPhoneNumberFormat,self.orderItem.userItem.phoneNum];
    
    [orderHeaderView addSubview:_phoneNumberLabel];
    
     headerCurrY = headerCurrY+ labelHeight;
    
    _arriveTimeLabel = [UIComUtil createLabelWithFont:kGoodsOrderMenuTextFont withTextColor:[UIColor blackColor] withText:@"" withFrame:CGRectMake(0,headerCurrY,orderHeaderView.frame.size.width,labelHeight)];
    //_arriveTimeLabel.backgroundColor = [UIColor redColor];
    _arriveTimeLabel.textAlignment = NSTextAlignmentLeft;
    _arriveTimeLabel.text  = [NSString stringWithFormat:kArriveTimeFormat,self.orderItem.arriveTime];
    
    [orderHeaderView addSubview:_arriveTimeLabel];
    /*
    UIButton *personChooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [personChooseBtn addTarget:self action:@selector(personChooseAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [personChooseBtn setFrame:_arriveTimeLabel.frame];
    
    [orderHeaderView addSubview:personChooseBtn];
    */
    
    [contentView addSubview:orderHeaderView];
    SafeRelease(orderHeaderView);
    
 
    
    
    currY = currY +orderHeaderView.frame.size.height+itemPendinxY;
    
    UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(kLeftPendingX, currY, kDeviceScreenWidth-2*kLeftPendingX,orderNoteViewHeigt)];
    
    textView.text = @"1. 本店网络订餐须知第一条本店网络订餐须知第一条本店网络订餐须知第一条本店网络订餐须知第一条\n 2. 本店网络订餐须知第一条本店网络订餐须知第一条本店网络订餐须知第一条本店网络订餐须知第一条\n 3.本店网络订餐须知第一条本店网络订餐须知第一条本店网络订餐须知第一条";
    textView.layer.cornerRadius = 5.f;
    [contentView addSubview:textView];
    
    SafeRelease(textView);
    
    currY = currY +textView.frame.size.height+itemPendinxY;
    
    UIView *payContentView = [[UIView alloc]initWithFrame:CGRectMake(kLeftPendingX,currY, kDeviceScreenWidth-2*kLeftPendingX,orderPayViewHeight)];
    payContentView.backgroundColor = [UIColor whiteColor];
    payContentView.layer.cornerRadius = 5.f;

    UIImage *image =nil;
    UIImageWithFileName(image, @"pay_zfb.png");
    UIButton *payIcon = [UIComUtil createButtonWithNormalBGImage:image withHightBGImage:image withTitle:@"" withTag:0 withTarget:self  withTouchEvent:nil];
    payIcon.frame = CGRectMake(kLeftPendingX, kLeftPendingX*2,image.size.width, image.size.height);
    //showOrderBtn.backgroundColor = [UIColor redColor];
     payIcon.center = CGPointMake(payContentView.frame.size.width/2.f, payIcon.center.y);
    [payContentView addSubview:payIcon];
    
    UIImageWithFileName(image, @"pay_dis_confirm_pay.png");
    UIButton *payBtn = [UIComUtil createButtonWithNormalBGImage:image withHightBGImage:image withTitle:@"" withTag:0 withTarget:self  withTouchEvent:@selector(didButtonPress:)];
    //showOrderBtn.backgroundColor = [UIColor redColor];
    [payContentView addSubview:payBtn];
    
    payBtn.frame = CGRectMake(40.f,payContentView.frame.size.height/3*2,image.size.width,image.size.height);
    //[self.view addSubview:feedBackBtn];
    
    payBtn.center = CGPointMake(payContentView.frame.size.width/2.f, payBtn.center.y);
    
    
    
    [contentView addSubview:payContentView];
    
}

- (void)personChooseAction:(UIButton*)sender {
    
    
    NSMutableArray *totalCountArray = [NSMutableArray array];
    for (int i = 0;i<120;i++){
        
        [totalCountArray addObject:[NSString stringWithFormat:@"%d 分",i]];
    }
    //if(_pickview == nil)
    {
        _pickview=[[ZHPickView alloc] initPickviewWithArray:totalCountArray isHaveNavControler:NO];
        [_pickview  setDelegate:self];
        [_pickview setSelectorRow:self.orderItem.arriveTime];
        //[_pickview setToolbarTitle:[NSString stringWithFormat:kArriveTimeFormat,self.orderItem.arriveTime]];
        [_pickview show];
    }
    
}

- (void)didButtonPress:(id)sender {

    
#if 0
    
    [[UserDinnerWatingMgr sharedInstance] setArriveTime:0];
    [[UserDinnerWatingMgr sharedInstance] setPersonNum:0];
    
    [ZCSNotficationMgr postMSG:kOrderFoodDidSuccessMSG obj:self.orderItem];
    
    return;
    
#endif
    

    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *partner = kAliPayPartner;
    NSString *seller = kAliPaySaller;
    NSString *privateKey = kAliPayKey;
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    order.tradeNO = self.orderItem.orderIdName; //订单ID（由商家自行制定）
    order.productName = self.orderItem.shopItem.name; //商品标题
    order.productDescription = self.orderItem.shopItem.description; //商品描述
    order.amount = @"0.01";//[NSString stringWithFormat:@"%.2f",self.orderItem.payPrice]; //商品价格
    order.notifyURL =  @"http://www.xxx.com"; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"mobileOrder";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
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

-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString {
    resultString = [resultString stringByReplacingOccurrencesOfString:@"分" withString:@""];
    self.orderItem.arriveTime = [resultString integerValue];
    _arriveTimeLabel.text = [NSString stringWithFormat:kArriveTimeFormat,self.orderItem.arriveTime];
//    if(self.orderItem.arriveTime == 0) {
//        _totalPersonNumLabel.text = @"已经到店";
//    }
}

@end
