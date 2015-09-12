//
//  DinnerWaitingViewController.m
//  MobileOrder
//
//  Created by cszhan on 15-6-28.
//  Copyright (c) 2015年 com.ximalaya. All rights reserved.
//

#import "DinnerWaitingViewController.h"

#import "OrderWaitingItemCell.h"

#import "GoodsCatagoryItem.h"

#import "UserFeedBackViewController.h"

#import "OrderStatusView.h"

#import "ZHPickView.h"

#import "UserDinnerWatingMgr.h"

#import "FoodOrderListViewController.h"

#define kLeftPendingX           10.f

#define kItemPendingY           20.f

#define kCellHeight             44.f

@interface DinnerWaitingViewController () {

    OrderStatusView         *orderStatusView;
    UILabel                 *_orderIDLabel;
    UILabel                 *_orderTimeLabel;
    UITableView             *_tableView;
    UIButton                *_feedBackBtn;
    NSInteger               _timerCount;
    BOOL                    _isStatusHidden;
}
@property (nonatomic, strong)NSTimer *timer;
@end

@implementation DinnerWaitingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]){
        
        [self setNavgationBarTitle:kMenuTitleArray[0]];
        
        //[ZCSNotficationMgr addObserver:self call:@selector(<#selector#>) msgName:k];
    }
    return self;
}

- (void)viewDidLoad {
    if(self.entryType == viewWaiting){
        [self setRightNavigationBarItemWithImage:nil withTitle:@"历史订单"];
    } else {
        //[self.navigationController.navigationBar setTitle:kOrderDetail];
        [self setNavgationBarTitle:kOrderDetail];
    }
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
}

- (void)viewWillAppear:(BOOL)animated {

    //[self startTimerByWaitingTime];
    if(self.orderItem.status == Order_Done){
        
        [self setOrderStatusViewHidden:YES];
        
        return;
    }
    [self startUserWaitingTimer];
}
- (void)viewWillDisappear:(BOOL)animated {

    [self stopUserWaitingTimer];
    
}

- (void)didSelectorTopNavRightItem:(id)item {
    
    [self showOrderList:nil];
}

- (void)showOrderList:(id)sender {

    
    FoodOrderListViewController *foodOrderListVCtrl = [[FoodOrderListViewController alloc]init];
    foodOrderListVCtrl.entryType = viewWaiting;
    [self.navigationController pushViewController:foodOrderListVCtrl animated:YES];
    SafeRelease(foodOrderListVCtrl);
}



#pragma mark -
#pragma mark - waitingTime check

- (void)startNetWork {
    
    //[self startDinnerWaitingCheck];
}

- (void)startTimerByWaitingTime {
    if(self.orderItem.status  == Order_Init || self.orderItem.status == Order_Done){
        NE_LOG(@"no need to checker Order status !!");
        [self stopTimer];
        return;
    }
    [self stopTimer];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(updateWatingTimer:) userInfo:nil repeats:YES];
    [self.timer fire];
}

- (void)stopTimer{
    
    [self.timer invalidate];
    self.timer = nil;
}

- (void)stopUserWaitingTimer {

    [[UserDinnerWatingMgr sharedInstance] stopTimer];
}

- (void)updateWatingTimer:(id)userInfo {

    _timerCount = _timerCount-1;
    if(_timerCount <=0 ){
        _timerCount = 0.f;
        [self stopTimer];
    } else {
    
        
    }
     [orderStatusView.timerLabel setText:[NSString stringWithFormat:@"%02ld:%02ld",_timerCount/60,_timerCount%60]];
}

- (void)startUserWaitingTimer{
    [self stopUserWaitingTimer];
    if(self.orderItem.status == Order_Arrived || self.orderItem.status == Order_NoArrived){
        
        __block typeof(self)  weakSelf = self;
        [[UserDinnerWatingMgr  sharedInstance] startDinnerWaitingCheck:self.orderItem];
        [[UserDinnerWatingMgr  sharedInstance] setNetDoneBlock:^(id data){
        
            [weakSelf updateUIData:[data objectForKey:@"data"]];
        }];
    }
}


#pragma mark -
#pragma mark - UI

- (void)updateUIData:(id)netData{
     kNetEnd(self.view);
    //NSMutableArray *resultData = [NSMutableArray array];
    //for(id orderItem in netData)
    id data = nil;
    if([netData isKindOfClass:[NSArray class]])
    {
        if([netData count]){
           // data = netData[0];
            data = [netData lastObject];
        }
        //[resultData addObject:item];
    } else {
        data = netData;
    }
    OrderItem *item = [[OrderItem alloc]initWithDictionary:data];
    self.orderItem = item;
    SafeRelease(item);
    [self updateUIView];
   
}

- (void)setOrderStatusViewHidden:(BOOL) hidden {

    if(hidden){
    
        if(_isStatusHidden == YES)
            
            return;
        
        [UIView animateWithDuration:0.3 animations:^(){
        
            orderStatusView.hidden = YES;
            /*
            CGRect rect = _tableView.frame;
            
            _tableView.frame = CGRectMake(rect.origin.x, offsetY+kItemPendingY,rect.size.width, rect.size.height);
            */
            CGSize size = contentView.contentSize;
            _tableView.frame = CGRectOffset(_tableView.frame, 0, -orderStatusView.frame.size.height+kItemPendingY);
            _feedBackBtn.frame = CGRectOffset(_feedBackBtn.frame, 0, -orderStatusView.frame.size.height+kItemPendingY);
            contentView.contentSize = CGSizeMake(size.width, size.height-orderStatusView.frame.size.height+kItemPendingY);
            _isStatusHidden = YES;
            
        }];
        
    } else {
    
        if(_isStatusHidden == NO)
            
            return;
        
        [UIView animateWithDuration:0.3 animations:^(){
            
            orderStatusView.hidden = NO;
            CGSize size = contentView.contentSize;
            _tableView.frame = CGRectOffset(_tableView.frame, 0, orderStatusView.frame.size.height+kItemPendingY);
            _feedBackBtn.frame = CGRectOffset(_feedBackBtn.frame, 0, orderStatusView.frame.size.height+kItemPendingY);
            contentView.contentSize = CGSizeMake(size.width, size.height+orderStatusView.frame.size.height+kItemPendingY);
            _isStatusHidden = NO;
            
        }];
        
    }
}

- (void)initUIView {

    CGFloat currY = offsetY+kItemPendingY;
    
    
    CGFloat orderStarusHeight  = 100.f;
    
    orderStatusView =  [[OrderStatusView alloc]initWithFrame:CGRectMake(kLeftPendingX,currY,kDeviceScreenWidth-2*kLeftPendingX,orderStarusHeight)];
    orderStatusView.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:orderStatusView];
    orderStatusView.delegate = self;
    orderStatusView.layer.cornerRadius = 5.f;
    SafeRelease(orderStatusView);

    CGFloat orderHeaderHeight = 80.f;
    
    UIView *orderHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0.f, 0,kDeviceScreenWidth-2*kLeftPendingX,orderHeaderHeight)];
    
    currY = orderHeaderView.frame.size.height;
    
    //orderHeaderView.layer.cornerRadius = 5.f;
    CGFloat currX = 60.f;
    UILabel *_orderdHintLable =  [UIComUtil createLabelWithFont:kOrderDetailTextFont withTextColor:[UIColor redColor] withText:@"单号:" withFrame:CGRectMake(0.f,0,currX, 30.f)];
    [orderHeaderView addSubview:_orderdHintLable];
    
    _orderIDLabel = [UIComUtil createLabelWithFont:kOrderDetailTextFont withTextColor:[UIColor redColor] withText:@"" withFrame:CGRectMake(currX, 0.f,orderHeaderView.frame.size.width-currX-kLeftPendingX, 30.f)];
    _orderIDLabel.textAlignment = NSTextAlignmentRight;
    [orderHeaderView addSubview:_orderIDLabel];
    
    UILabel *_orderTimeHintLable =  [UIComUtil createLabelWithFont:kOrderDetailTextFont withTextColor:[UIColor redColor] withText:@"日期:" withFrame:CGRectMake(0.f,40.f,currX, 30.f)];
    
    [orderHeaderView addSubview:_orderTimeHintLable];
    _orderTimeLabel = [UIComUtil createLabelWithFont:kOrderDetailTextFont withTextColor:[UIColor redColor] withText:@"" withFrame:CGRectMake(currX,40.f,orderHeaderView.frame.size.width-currX-kLeftPendingX, 30.f)];
    //_orderTimeLabel.text = @"adl;gkasdg;lkasjgdsag;kas;dkglask;";
    _orderTimeLabel.numberOfLines = 1;
    _orderTimeLabel.textAlignment = NSTextAlignmentRight;
    //_orderTimeLabel.backgroundColor = [UIColor greenColor];
    [orderHeaderView addSubview:_orderTimeLabel];
    
    
    CGSize orderSize = CGSizeMake(kDeviceScreenWidth-2*kLeftPendingX,kDeviceScreenHeight-offsetY-orderHeaderHeight-orderStatusView.frame.size.height);
    
    
    currY = currY+ orderStatusView.frame.size.height+kItemPendingY;
    
    _tableView  = [[UITableView alloc]initWithFrame:CGRectMake(kLeftPendingX,currY,orderSize.width,orderSize.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _tableView.separatorColor = nil;
    //[_tableView registerClass:[OrderListItemCell class] forCellReuseIdentifier:cellId];
    [contentView addSubview:_tableView];
    _tableView.layer.cornerRadius = 5.f;
    
    [_tableView setTableHeaderView:orderHeaderView];
    SafeRelease(orderHeaderView);
    
    currY = currY+ _tableView.frame.size.height+kItemPendingY;
    //for order
    UIImage *image = nil;
    
    UIImageAutoScaleWithFileName(image, @"user_btn_h");
    
    _feedBackBtn = [UIComUtil createButtonWithNormalBGImage:image withHightBGImage:image withTitle:@"意见反馈" withTag:0 withTarget:self  withTouchEvent:@selector(didButtonPress:)];
    //showOrderBtn.backgroundColor = [UIColor redColor];
    [contentView addSubview:_feedBackBtn];
    
    _feedBackBtn.frame = CGRectMake(40.f,currY,kDeviceScreenWidth-40*2,40);
    [contentView addSubview:_feedBackBtn];
    
    currY = currY+_feedBackBtn.frame.size.height+kItemPendingY;
    
    contentView.contentSize = CGSizeMake(kDeviceScreenWidth,currY);
    
    [self updateUIView];

}

- (void)updateUIView {
    
    self.dataArray = self.orderItem.menuData;
    _orderTimeLabel.text = self.orderItem.orderTime;
    _orderIDLabel.text = self.orderItem.orderIdName;
    _timerCount = self.orderItem.arriveTime/1000;
    
    if(self.orderItem.status == Order_Done){
    
        [orderStatusView.arriveBtn setEnabled:NO];
    }
    /*
    if(self.orderItem.status == Order_Arrived){
        
        [orderStatusView set]
    
    }else {
    
        
    }
    */
    
    [self startTimerByWaitingTime];
    [_tableView reloadData];

}

- (void)didButtonPress:(id)sender {

    UserFeedBackViewController *feedBackCtrl = [[UserFeedBackViewController alloc]init];
    feedBackCtrl.orderItem = self.orderItem;
    [self.navigationController pushViewController:feedBackCtrl animated:YES];
    SafeRelease(feedBackCtrl);
    
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return  5;
    //NSInteger rows = [self.goodsListArray[section] count];
    return [self.dataArray count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    NSArray *nibArr = [[NSBundle mainBundle] loadNibNamed:@"OrderWaitingItemCell"
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
    
    return sectionView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //static NSString *CellIdentifier = @"Cell";
    static NSString *cellId = @"OrderWaitingItemCell";
    
    OrderWaitingItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil || [cell isKindOfClass:[NSNull class]]) {
        
#if 1
        NSArray *nibArr = [[NSBundle mainBundle] loadNibNamed:@"OrderWaitingItemCell"
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
        [self stopTimer];
        [[UserDinnerWatingMgr sharedInstance] stopTimer];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    if([sender tag] == 1){
        
        //        BidMainViewController *bidMainVc = [[BidMainViewController alloc]init];
        //        [self.navigationController pushViewController:bidMainVc animated:YES];
        //        SafeRelease(bidMainVc);
    }
}

- (void)didPressActionButton:(id)sender withType:(ActionType)type {

    if(type == ActionTimer){

        [self startChooseArriveTime];
        
    } else {
    
        [self startChooseDeskNumStatus];
        
    }

}

#pragma mark -
#pragma mark - UI ChooseArrive

- (void)startChooseArriveTime {

    NSMutableArray *totalCountArray = [NSMutableArray array];
    for (int i = 0;i<120;i++){
        
        [totalCountArray addObject:[NSString stringWithFormat:@"%d 分",i]];
    }
    //if(_pickview == nil)
    {
        ZHPickView *_pickview=[[ZHPickView alloc] initPickviewWithArray:totalCountArray isHaveNavControler:NO];
        _pickview.tag = 0;
        [_pickview  setDelegate:self];
        [_pickview setSelectorRow:0];
        [_pickview setToolbarTitle:@"到店时间" withColor:[UIColor blackColor]];
        [_pickview show];
    }
}

- (void)startChooseDeskNumStatus {

    NSMutableArray *totalCountArray = [NSMutableArray array];
    for (int i = 0;i<120;i++){
        
        [totalCountArray addObject:[NSString stringWithFormat:@"%d 号",i]];
    }
    //if(_pickview == nil)
    {
        ZHPickView *_pickview=[[ZHPickView alloc] initPickviewWithArray:totalCountArray isHaveNavControler:NO];
        _pickview.tag = 1;
        [_pickview  setDelegate:self];
        [_pickview setSelectorRow:0];
        [_pickview setToolbarTitle:@"请选择桌号" withColor:[UIColor blackColor]];
        [_pickview show];
    }

}


-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString {
    
    if(pickView.tag == 0){
        resultString = [resultString stringByReplacingOccurrencesOfString:@"分" withString:@""];
        self.orderItem.arriveTime = [resultString integerValue];
        
        _timerCount = self.orderItem.arriveTime*60.f;
        /*
         _arriveTimeLabel.text = [NSString stringWithFormat:kArriveTimeFormat,self.orderItem.arriveTime];
         */
        //    if(self.orderItem.arriveTime == 0) {
        //        _totalPersonNumLabel.text = @"已经到店";
        //    }
        [self startTimerByWaitingTime];
        NSString *timerStr = [NSString  stringWithFormat:@"%ld", _timerCount*1000];
        NSString *orderIdStr = [NSString stringWithFormat:@"%lld",self.orderItem.orderId];
        [[MobileOrderNetDataMgr getSingleTone] updateOrderArriveTime:@{@"arriveTimes":timerStr,@"orderId":orderIdStr}];
    }
    if(pickView.tag == 1) {
        /*
        resultString = [resultString stringByReplacingOccurrencesOfString:@"分" withString:@""];
        self.orderItem.arriveTime = [resultString integerValue];
        
        _timerCount = self.orderItem.arriveTime*60.f;
        */
        /*
         _arriveTimeLabel.text = [NSString stringWithFormat:kArriveTimeFormat,self.orderItem.arriveTime];
         */
        //    if(self.orderItem.arriveTime == 0) {
        //        _totalPersonNumLabel.text = @"已经到店";
        //    }
        /*
        [self startTimerByWaitingTime];
        NSString *timerStr = [NSString  stringWithFormat:@"%ld", _timerCount*1000];
         */
        NSString *orderIdStr = [NSString stringWithFormat:@"%lld",self.orderItem.orderId];
       
        [[MobileOrderNetDataMgr getSingleTone] updateOrderDeskNumberTime:@{@"desktopNum":resultString,@"orderId":orderIdStr}];
        
    }
}

- (void)didNetWorkOK:(NSNotification *) ntf {

    //return;
    [super didNetDataOK:ntf];
    
    id obj = [ntf object];
    id respRequest = [obj objectForKey:@"request"];
    id objData = [obj objectForKey:@"data"];
    NSString *resKey = [respRequest resourceKey];
    //NSString *resKey = [respRequest resourceKey];
    
    if([resKey isEqualToString:@"updateorderDesk"]) {
        //kNetEnd(self.view);
        NSLog(@"update data:%@",[objData objectForKey:@"data"]);
        
        kUIAlertViewNoDelegate(@"信息", @"提交成功!!");
        
    }

    
}


@end
