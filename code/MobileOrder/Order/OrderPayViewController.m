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



#define kAliPayPartner             @"2088911644524097"

#define kAliPaySaller              @"dashang@ximalaya.com"

#define kAliPayKey                 @"MIICdQIBADANBgkqhkiG9w0BAQEFAASCAl8wggJbAgEAAoGBANLcFE2Xcc7Meoja8x+FGdSnsiqBRqEUChfVN74LplEUvI7eT41zOpwg/mBOHcT0VfN4UwbL1znz0eCEaFdWL9iUy5lsaIKL+qm7iCOfpXMhbp3cLkbESXYtmoTQOhy1yFVXK0irh3d+QDym3A7e5HERq5DwE1t3RvNmDBxdk7ZPAgMBAAECgYAXiDwz1Jz86VEbiOPtNpuFYhm+KKNLQsNFmaQY74/mKJxKjYDvVlbKKdx5vv4Phv04qMsLTSB99ToNBnnmlVXNcCG0ujTzzwSGJOK8GH9AT6IfvVMsFY8GGP9wWbnPFz7K0MHxXGEDjCiaKFje+sO1Is2tPh0DHCpyaXZI62tpkQJBAOlz6Kda/Ok6RSZiJXT/KCQnJu0JrUK1dteCawjS0m8Y8a1Mj+uLzsxTmQLjdg3E0DKrGhwiZU0cZSXO/oupKEUCQQDnOY8r5eZhbWYksXlUC0dReisj9o767JAZ6HOfJXWAO0CtjblwTot2fJ+v59HhwpknJWyLesEPuIBA6hRzMN+DAkAI11zuSaHea1iHFZx5i9hHVjxBKean6htwGf5XvTQ/BODSQV4J+6d/UYMv+tFTwCpqYNSCUEMp4nNqNSaqv2NJAkAZhACIl5YUqj3bTrpUy+nS0+huz4Z3qiM8uKoJpdiRjfhVLo6IFiLNsHLutmYyw4ajCz4vJhyn33RHtY0MKRiBAkBGexJdyu5XuJSVCYYEEOqiPAdSw3gbb9abSslMBN6u2LVJsDk/mHQwH8QgBy9XDC3woD0sjeKmskMYS0psazIW"

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

    
#if 1
    
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
    order.amount = [NSString stringWithFormat:@"%.2f",self.orderItem.payPrice]; //商品价格
    order.notifyURL =  @"http://www.xxx.com"; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"alisdkdemo";
    
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
