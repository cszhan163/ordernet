//
//  OrderConfirmViewController.m
//  MobileOrder
//
//  Created by cszhan on 15-6-12.
//  Copyright (c) 2015年 com.ximalaya. All rights reserved.
//

#import "OrderConfirmViewController.h"

#import "OrderListItemCell.h"

#import "GoodsCatagoryItem.h"

#import "OrderPayViewController.h"

#import "CardShopLoginViewController.h"

#define kPendingY    10.f

#define kLeftPendingX  10.f

#define kCellHeight  44.f

#define kCellHeaderHeight 44.f

#define kOrderPanelHeight  50.f

#define kArriveTimeFormat  @"到店时间:%ld 分"


#import "ZHPickView.h"

#define     TEST_UI      0

@interface OrderConfirmViewController () <ZHPickViewDelegate>{

    
    UILabel *_shopLabel;
    UILabel *_pointsTotalLabel;
    UILabel *_consumePointsLabel;
    UILabel *_priceLabel;
    UILabel *_discountPriceLabel;
    
    UILabel *_totalPersonNumLabel;
    UILabel *_arriveTimeLabel;
    
    UITableView *_tableView;
    ZHPickView*  _pickview;
}

@end

@implementation OrderConfirmViewController

- (void)dealloc {
    SafeRelease( _pickview);
    SuperDealloc;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]){
        
        [self setNavgationBarTitle:kOrderConfirmTitle];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavgationBarTitle:kOrderConfirmTitle];
    if(kIsIOS7Check){
    
        offsetY =  kMBAppTopToolBarHeight+kMBAppStatusBar;
    }
    contentView =[[UIScrollView alloc]initWithFrame:CGRectMake(0.f, 0.f, kDeviceScreenWidth, kDeviceScreenHeight)];
    [self.view addSubview:contentView];
    [self initUIView];
    [self startNewOrder];
}

- (void)initUIView {

    CGFloat currY = offsetY;
    CGFloat orderHeaderHeight = 140.f;
    CGFloat labelHeight = 25.f;
    
    UIView *orderHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0.f, currY,kDeviceScreenWidth,orderHeaderHeight)];
#if TEST_UI
    orderHeaderView.backgroundColor = [UIColor blackColor];
#else
    orderHeaderView.backgroundColor = [UIColor clearColor];
#endif
    CGFloat currHeightY = 0.f;
    _shopLabel = [UIComUtil createLabelWithFont:kGoodsOrderShopTitle withTextColor:[UIColor blackColor] withText:@"" withFrame:CGRectMake(kLeftPendingX,currHeightY,orderHeaderView.frame.size.width-2*kLeftPendingX,40.f)];
#if TEST_UI
    _shopLabel.backgroundColor = [UIColor redColor];
#endif
    _shopLabel.textAlignment = NSTextAlignmentCenter;
    
    [orderHeaderView addSubview:_shopLabel];
    
    currHeightY = currHeightY+_shopLabel.frame.size.height;
    
#if 1
    _priceLabel = [UIComUtil createLabelWithFont:kGoodsOrderMenuTextFont withTextColor:[UIColor blackColor] withText:@"" withFrame:CGRectMake(kLeftPendingX,currHeightY,orderHeaderView.frame.size.width-2*kLeftPendingX,labelHeight)];
#if TEST_UI
    _priceLabel.backgroundColor = [UIColor greenColor];
#endif
    _priceLabel.textAlignment = NSTextAlignmentLeft;
    
    [orderHeaderView addSubview:_priceLabel];
    
    currHeightY = currHeightY+labelHeight;
    
    _pointsTotalLabel = [UIComUtil createLabelWithFont:kGoodsOrderMenuTextFont withTextColor:[UIColor blackColor] withText:@"" withFrame:CGRectMake(kLeftPendingX,currHeightY,orderHeaderView.frame.size.width-2*kLeftPendingX,labelHeight)];
#if TEST_UI
    _pointsTotalLabel.backgroundColor = [UIColor greenColor];
#endif
    _pointsTotalLabel.textAlignment = NSTextAlignmentLeft;
    
    [orderHeaderView addSubview:_pointsTotalLabel];
    
    currHeightY = currHeightY+labelHeight;
    
    _consumePointsLabel = [UIComUtil createLabelWithFont:kGoodsOrderMenuTextFont withTextColor:[UIColor blackColor] withText:@"" withFrame:CGRectMake(kLeftPendingX,currHeightY,orderHeaderView.frame.size.width-2*kLeftPendingX,labelHeight)];
#if TEST_UI
    _consumePointsLabel.backgroundColor = [UIColor greenColor];
#endif
    _consumePointsLabel.textAlignment = NSTextAlignmentLeft;
    
    [orderHeaderView addSubview:_consumePointsLabel];
    
    currHeightY = currHeightY+labelHeight;
    
    _discountPriceLabel = [UIComUtil createLabelWithFont:kGoodsOrderMenuTextFont withTextColor:[UIColor blackColor] withText:@"" withFrame:CGRectMake(kLeftPendingX,currHeightY,orderHeaderView.frame.size.width-2*kLeftPendingX,labelHeight)];
#if TEST_UI
    _discountPriceLabel.backgroundColor = [UIColor greenColor];
#endif
    _discountPriceLabel.textAlignment = NSTextAlignmentLeft;
    
    [orderHeaderView addSubview:_discountPriceLabel];
#else
    LeftTitleListCell *orderInfoView = [[LeftTitleListCell alloc]initWithGoodsDetailFrame:CGRectMake(kPendingX,20.f,width,height) withTitleArray:kOrderTitleArray withTitle:@"" withValueAtrArray:@[] withItemPending:25.f];
    [orderInfoView setXStartLeftPendingX:20.f];
    //[orderInfoView   ];
    orderInfoView.backgroundColor = [UIColor clearColor];
    [bgScrollerView addSubview:orderInfoView];
    SafeRelease(orderInfoView);
    
#endif
    
    [contentView addSubview:orderHeaderView];
    
    
    CGSize orderSize = CGSizeMake(kDeviceScreenWidth-2*kLeftPendingX,350);
    
    currY = currY+ orderHeaderView.frame.size.height;
    
    _tableView  = [[UITableView alloc]initWithFrame:CGRectMake(kLeftPendingX,currY,orderSize.width,orderSize.height) style:UITableViewStyleGrouped];
    _tableView.layer.cornerRadius = 5.f;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSelectionStyleGray;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.alwaysBounceVertical = NO;
    _tableView.bounces = NO;
    //_tableView.separatorColor = ;
    //[_tableView registerClass:[OrderListItemCell class] forCellReuseIdentifier:cellId];
    [contentView addSubview:_tableView];
    
    
    
    //[_tableView setTableHeaderView:orderHeaderView];
    
    
    currY = currY+ _tableView.frame.size.height+1*kPendingY;
    
    CGFloat footerY = kLeftPendingX;
    UIView *orderFootView = [[UIView alloc]initWithFrame:CGRectMake(0.f, currY,kDeviceScreenWidth,orderHeaderHeight)];
    
    _totalPersonNumLabel = [UIComUtil createLabelWithFont:kGoodsOrderMenuTextFont withTextColor:[UIColor blackColor] withText:@"" withFrame:CGRectMake(kLeftPendingX,footerY,(orderHeaderView.frame.size.width-2*kLeftPendingX)/2.f,labelHeight)];
#if TEST_UI
    _totalPersonNumLabel.backgroundColor = [UIColor redColor];
#endif
    _totalPersonNumLabel.textAlignment = NSTextAlignmentLeft;
    
    CGRect timeRect = CGRectOffset(_totalPersonNumLabel.frame,orderHeaderView.frame.size.width/2.f-kLeftPendingX, 0.f);
    _arriveTimeLabel = [UIComUtil createLabelWithFont:kGoodsOrderMenuTextFont withTextColor:[UIColor blackColor] withText:@"" withFrame:timeRect];
#if TEST_UI
    _arriveTimeLabel.backgroundColor = [UIColor redColor];
#endif
    _arriveTimeLabel.textAlignment = NSTextAlignmentRight;
    _arriveTimeLabel.text  = [NSString stringWithFormat:kArriveTimeFormat,self.orderItem.arriveTime];
    
    [orderFootView addSubview:_arriveTimeLabel];
    
    UIButton *personChooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [personChooseBtn addTarget:self action:@selector(personChooseAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [personChooseBtn setFrame:CGRectMake(_totalPersonNumLabel.frame.origin.x, _totalPersonNumLabel.frame.origin.y, _totalPersonNumLabel.frame.size.width*2, _totalPersonNumLabel.frame.size.height)];
    
    [orderFootView addSubview:personChooseBtn];
    
    //[orderHeaderView addSubview:_totalPersonNumLabel];
    
    [orderFootView addSubview:_totalPersonNumLabel];
    
    [contentView addSubview:orderFootView];
    //[_tableView setTableFooterView:orderFootView];
    
    SafeRelease(orderFootView);
    
    self.dataArray = self.orderItem.menuData;
    [self upConfirmOrderView];
    
    
    currY = self.view.frame.size.height - kOrderPanelHeight;
    
    
    UIView *orderPanel = [[UIView alloc]initWithFrame:CGRectMake(0.f,currY,kDeviceScreenWidth,kOrderPanelHeight)];
    orderPanel.backgroundColor = [UIColor grayColor];
#if TEST_UI
    orderPanel.backgroundColor = [UIColor greenColor];
#endif
    
    CGSize size = CGSizeMake(60,25);
    
    UIImage *image = nil;
    UIButton *orderBtn = [UIComUtil createButtonWithNormalBGImage:nil withHightBGImage:nil withTitle:@"确认下单" withTag:1 withTarget:self  withTouchEvent:@selector(didButtonPress:)];
    orderBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    orderBtn.frame = CGRectMake(orderPanel.frame.size.width-size.width-kLeftPendingX,kPendingY+5,size.width,size.height);
    orderBtn.backgroundColor = [UIColor redColor];
    [orderPanel addSubview:orderBtn];
    
    //UIImageAutoScaleWithFileName(image, @"book_arrow_up@2x");
    
    //for order
    UIButton *showOrderBtn = [UIComUtil createButtonWithNormalBGImage:image withHightBGImage:image withTitle:@"加菜" withTag:0 withTarget:self  withTouchEvent:@selector(didButtonPress:)];
#if 1 || TEST_UI
    UIColor *bgColor = kCommonButtonBgColor;
    showOrderBtn.backgroundColor = bgColor;//[UIColor redColor];
#endif
    [orderPanel addSubview:showOrderBtn];
    
    showOrderBtn.frame = CGRectMake(kLeftPendingX,kPendingY+5,size.width,size.height);
    [orderPanel addSubview:showOrderBtn];
    
#if 1
    [self.view addSubview:orderPanel];
#else
    [_tableView setTableFooterView:orderPanel];
#endif
    SafeRelease(orderPanel);
    
    _totalPersonNumLabel.text = [NSString stringWithFormat:@"就餐人数:%ld 人",self.orderItem.personNum];
    _arriveTimeLabel.text = [NSString stringWithFormat:kArriveTimeFormat,self.orderItem.arriveTime];
    
    contentView.contentSize = CGSizeMake(kDeviceScreenWidth,offsetY+orderHeaderHeight+orderSize.height+orderFootView.frame.size.height);

}


- (void)didButtonPress:(id)sender {

    switch ([sender tag]) {
        case 0:
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case 1: {
            
#if 1
            
            OrderPayViewController *orderPayVCtrl = [[OrderPayViewController alloc]init];
            orderPayVCtrl.orderItem = self.orderItem;
            [self.navigationController pushViewController:orderPayVCtrl animated:YES];
            SafeRelease(orderPayVCtrl);
            
            return;
#endif
            
        }
        default:
            break;
    }
}


- (void)upConfirmOrderView {

    _shopLabel.text =  self.orderItem.shopItem.name; //[NSString stringWithFormat:@""]
    _totalPersonNumLabel.text = [NSString stringWithFormat:@"%ld",self.orderItem.personNum];
    _pointsTotalLabel.text = [NSString stringWithFormat:@"可用积分:%ld",self.orderItem.userItem.totalPoints];
    _consumePointsLabel.text = [NSString stringWithFormat:@"抵扣积分: %ld",(NSInteger)self.orderItem.consumePoints];
    _priceLabel.text = [NSString stringWithFormat:@"订单金额: ¥ %0.2lf 元",self.orderItem.totalPrice];
    CGFloat payPrice = self.orderItem.totalPrice - self.orderItem.consumePoints;
    self.orderItem.payPrice = payPrice;
    _discountPriceLabel.text = [NSString stringWithFormat:@"应付金额: ¥ %0.2lf 元",payPrice];
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

#pragma mark -
#pragma mark tableview

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return  kCellHeaderHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    NSArray *nibArr = [[NSBundle mainBundle] loadNibNamed:@"OrderListItemCell"
                                                    owner:self options:nil];
    /*
     for (id oneObject in nibArr){
     if ([oneObject isKindOfClass:[FoodItemCell class]])
     cell = (FoodItemCell*)oneObject;
     */
    NSInteger index = 3;
    
    if(kDeviceCheckIphone6){
        index = 4;
    }else if(kDeviceCheckIphone6Plus){
        index = 5;
    }
    UIView *sectionView = nibArr[index];
    //CGRect rect = CGRectMake(0.f, 0.f, kDeviceScreenWidth, 1);
    UIView *splitView = [[UIView alloc]initWithFrame:CGRectMake(0.f,kCellHeaderHeight-1,kDeviceScreenWidth, 1)];
    splitView.backgroundColor = [UIColor grayColor];
    [sectionView addSubview:splitView];
    SafeRelease(splitView);
    return sectionView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
       return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return  5;
    //NSInteger rows = [self.goodsListArray[section] count];
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //static NSString *CellIdentifier = @"Cell";
    static NSString *cellId = @"OrderListItemCell";
    
    OrderListItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil || [cell isKindOfClass:[NSNull class]]) {
        
#if 1
        NSArray *nibArr = [[NSBundle mainBundle] loadNibNamed:@"OrderListItemCell"
                                                        owner:self options:nil];
        /*
         for (id oneObject in nibArr){
         if ([oneObject isKindOfClass:[FoodItemCell class]])
         cell = (FoodItemCell*)oneObject;
         */
        NSInteger index = 0;
        
        if(kDeviceCheckIphone6){
            index = 1;
        }else if(kDeviceCheckIphone6Plus){
            index = 2;
        }
        cell = nibArr[index];
#else
        cell = [[FoodItemCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
#endif
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.backgroundColor = [UIColor whiteColor];
        cell.clipsToBounds = YES;
        
    }
#if 0
    
#else
    GoodsOrderItem *item = [self.dataArray objectAtIndex:indexPath.row];
    //cell.titleLable.text =  [NSString stringWithFormat:@"%@+%@",item.goodsName,item.name];
    [cell setFoodName:item.goodsName];
    [cell setCellItem:item.subCatagoryItem];
    [cell setDelegate:self];
    //currSection = indexPath.section;
#endif
    return cell;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return kCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    /*
     vc.delegate = self;
     NSDictionary *item = [self.dataArray objectAtIndex:indexPath.row];
     //NSDictionary *data = [item objectForKey:@"DayDetailInfo"];
     vc.mData = item;
     */
    
    
}

#pragma mark -

- (void)didSelectorItemIndex:(NSInteger)index {
   
    
}

-(void)didSelectorTopNavigationBarItem:(id)sender{
    
    if([sender tag] == 0) {
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    if([sender tag] == 1){
        
        //        BidMainViewController *bidMainVc = [[BidMainViewController alloc]init];
        //        [self.navigationController pushViewController:bidMainVc animated:YES];
        //        SafeRelease(bidMainVc);
    }
}

#pragma mark -

#pragma mark - Order Menu



- (void)updateOrderMenu {
    /*
    [_goodsOrderMenuView updateDataByOrderListArray:[self filertOrderData]];
    
    [tweetieTableView reloadData];
    
    NSInteger totalNumber = 0;
    CGFloat   totalPrice = 0.f;
    for(GoodsOrderItem *item in [_goodsOrderMenuView dataArray]){
        totalNumber = totalNumber + item.subCatagoryItem.number;
        totalPrice = totalPrice + item.subCatagoryItem.price * item.subCatagoryItem.number;
    }
    */
//    _numberLabel.text = [NSString stringWithFormat:@"点了:  %ld   道菜",totalNumber];
//    _priceLabel.text  = [NSString stringWithFormat:@"总计: ¥%0.2lf 元",totalPrice];
    
}

- (void)personChooseAction:(UIButton*)sender {

    NSMutableArray *finalArray = [NSMutableArray array];
    
    NSMutableArray *totalCountArray = [NSMutableArray array];
    for (int i =1;i<200;i++){
    
        [totalCountArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    [finalArray addObject:totalCountArray];
    
     NSMutableArray *timeCountArray = [NSMutableArray array];
    
    for (int i = 0;i<120;i++){
        
        [timeCountArray addObject:[NSString stringWithFormat:@"%d 分",i]];
    }
    [finalArray addObject:timeCountArray];
    //if(_pickview == nil)
    {
        _pickview=[[ZHPickView alloc] initPickviewWithArray:finalArray isHaveNavControler:NO];
        [_pickview  setDelegate:self];
        [_pickview selectComponets:0 withRow:self.orderItem.personNum];
        [_pickview selectComponets:1 withRow:self.orderItem.arriveTime];
        [_pickview show];
    }
    
    
}

-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString {
    
    NSArray *num = [resultString componentsSeparatedByString:@"#"];
    if([num count] == 2){
        NSString *resultStr = num[0];
        _totalPersonNumLabel.text = [NSString stringWithFormat:@"就餐人数:%@ 人",resultStr];
        self.orderItem.personNum = [resultStr integerValue];
        resultStr = num[1];
        resultStr = [resultStr stringByReplacingOccurrencesOfString:@"分" withString:@""];
        self.orderItem.arriveTime = [resultStr integerValue];
        _arriveTimeLabel.text = [NSString stringWithFormat:kArriveTimeFormat,self.orderItem.arriveTime];
    }
}

#pragma mark -

#pragma mark - network

- (void)startNewOrder{
    /*
    {
        "serialNum": "SN432423424",
        "totalPrice": "20",
        "status": "1",
        "userId": "1",
        "payType": "1",
        "paySerialNum": "2",
        "orderDetail":[{"price":5,"totalPrice":10,"num":2,"status":1,"productId":1}]
    }
    */
    self.orderItem.orderId = [NSString stringWithFormat:@"SD12346789110%02d",rand()%100];
    self.orderItem.orderTime = @"2015年5月1日19时20分";
    self.orderItem.userItem.name = @"王某某";
    
    [[MobileOrderNetDataMgr getSingleTone] newOrder:[self.orderItem getOrderDictionaryData]];
    
}

-(void)didNetDataOK:(NSNotification*)ntf
{
    //return;
    [super didNetDataOK:ntf];
    
    
    id obj = [ntf object];
    id respRequest = [obj objectForKey:@"request"];
    id objData = [obj objectForKey:@"data"];
    NSString *resKey = [respRequest resourceKey];
    //NSString *resKey = [respRequest resourceKey];
    if([resKey isEqualToString:@"getgoodslist"])
    {
        //        if ([self.externDelegate respondsToSelector:@selector(commentDidSendOK:)]) {
        //            [self.externDelegate commentDidSendOK:self];
        //        }
        //        kNetEndSuccStr(@"评论成功",self.view);
        //        [self dismissModalViewControllerAnimated:YES];
#if 0
        [self reloadNetData:data];
#else
        //        if([[data objectForKey:@"data"] count]<10.f){
        //            isRefreshing = YES;
        //        }
        
        NSDictionary *data = objData;
#endif
        //self.dataArray = [data objectForKey:@"data"];
        //        if([[data objectForKey:@"data"]count])
        //            self.pageNum = self.pageNum +1;
        [self performSelectorOnMainThread:@selector(updateUIData:) withObject:data waitUntilDone:NO];
        
    }
}

- (void)updateUIData:(NSDictionary*)netData{
    kNetEnd(self.view);
}
-(void)didNetDataFailed:(NSNotification*)ntf
{
    //kNetEndWithErrorAutoDismiss
}


@end
