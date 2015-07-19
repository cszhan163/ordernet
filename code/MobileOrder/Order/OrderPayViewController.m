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

#define kLeftPendingX    10.f

#define kOrderHeaderHeightY       200.f

#define kArriveTimeFormat  @"到店时间:%ld 分"

@interface OrderPayViewController () {

    ZHPickView *_pickview ;
    UILabel    *_arriveTimeLabel;
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
    
    self.orderItem.orderId = @"SD12346789110";
    self.orderItem.orderTime = @"2015年5月1日19时20分";
    CGFloat currY = 40.f;
    if(kIsIOS7Check){
    
        currY =  currY + kMBAppTopToolBarHeight + kMBAppStatusBar;
    }

    CGFloat labelHeight = 40.f;
    UIView *orderHeaderView = [[UIView alloc]initWithFrame:CGRectMake(kLeftPendingX,currY, kDeviceScreenWidth-2*kLeftPendingX,kOrderHeaderHeightY)];
    orderHeaderView.backgroundColor = [UIColor greenColor];
    
    
    _arriveTimeLabel = [UIComUtil createLabelWithFont:kGoodsOrderMenuTextFont withTextColor:[UIColor blackColor] withText:@"" withFrame:CGRectMake(0,kOrderHeaderHeightY/3.f,orderHeaderView.frame.size.width,labelHeight)];
    _arriveTimeLabel.backgroundColor = [UIColor redColor];
    _arriveTimeLabel.textAlignment = NSTextAlignmentLeft;
    _arriveTimeLabel.text  = [NSString stringWithFormat:kArriveTimeFormat,self.orderItem.arriveTime];
    
    [orderHeaderView addSubview:_arriveTimeLabel];
    /*
    UIButton *personChooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [personChooseBtn addTarget:self action:@selector(personChooseAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [personChooseBtn setFrame:_arriveTimeLabel.frame];
    
    [orderHeaderView addSubview:personChooseBtn];
    
    
    [self.view addSubview:orderHeaderView];
    */
    

    SafeRelease(orderHeaderView);
    
    currY = currY +orderHeaderView.frame.size.height+20.f;
    
    
    UIView *payContentView = [[UIView alloc]initWithFrame:CGRectMake(kLeftPendingX,currY, kDeviceScreenWidth-2*kLeftPendingX,kOrderHeaderHeightY)];
    payContentView.backgroundColor = [UIColor blueColor];

    UIImage *image =nil;
    UIImageWithFileName(image, @"pay_zfb.png");
    UIButton *payIcon = [UIComUtil createButtonWithNormalBGImage:image withHightBGImage:image withTitle:@"" withTag:0 withTarget:self  withTouchEvent:nil];
    payIcon.frame = CGRectMake(kLeftPendingX, kLeftPendingX*2,image.size.width, image.size.height);
    //showOrderBtn.backgroundColor = [UIColor redColor];
    [payContentView addSubview:payIcon];
    
    UIImageWithFileName(image, @"pay_dis_confirm_pay.png");
    UIButton *payBtn = [UIComUtil createButtonWithNormalBGImage:image withHightBGImage:image withTitle:@"" withTag:0 withTarget:self  withTouchEvent:@selector(didButtonPress:)];
    //showOrderBtn.backgroundColor = [UIColor redColor];
    [payContentView addSubview:payBtn];
    
    payBtn.frame = CGRectMake(40.f,payContentView.frame.size.height/3*2,image.size.width,image.size.height);
    //[self.view addSubview:feedBackBtn];
    
    payBtn.center = CGPointMake(payContentView.frame.size.width/2.f, payBtn.center.y);
    
    [self.view addSubview:payContentView];
    
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
        [_pickview setToolbarTitle:[NSString stringWithFormat:kArriveTimeFormat,self.orderItem.arriveTime]];
        [_pickview show];
    }
    
}

- (void)didButtonPress:(id)sender {

    

    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *partner = @"";
    NSString *seller = @"alipayrisk10@alipay.com";
    NSString *privateKey = @"";
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
    order.tradeNO = self.orderItem.orderId; //订单ID（由商家自行制定）
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
