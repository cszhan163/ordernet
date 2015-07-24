//
//  DinnerWaitingViewController.m
//  MobileOrder
//
//  Created by cszhan on 15-6-28.
//  Copyright (c) 2015年 com.ximalaya. All rights reserved.
//

#import "DinnerWaitingViewController.h"

#import "OrderListItemCell.h"

#import "GoodsCatagoryItem.h"

#import "UserFeedBackViewController.h"

#define kLeftPendingX           10.f

#define kCellHeight             40.f

@interface DinnerWaitingViewController () {

    UIView      *orderStatusView;
    UILabel     *_orderIDLabel;
    UILabel     *_orderTimeLabel;
    UITableView *_tableView;
}

@end

@implementation DinnerWaitingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]){
        
        [self setNavgationBarTitle:kMenuTitleArray[0]];
    }
    return self;
}

- (void)viewDidLoad {
    //[super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = kViewBGColor;
    
    CGFloat currY = 0.f;
    UIView *orderHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0.f, 0,kDeviceScreenWidth,80.f)];
    
    currY = orderHeaderView.frame.size.height;
    
    orderHeaderView.layer.cornerRadius = 5.f;
    
    CGFloat currX = 60.f;
    UILabel *_orderdHintLable =  [UIComUtil createLabelWithFont:kOrderDetailTextFont withTextColor:[UIColor redColor] withText:@"单号:" withFrame:CGRectMake(0.f,0,currX, 30.f)];
    [orderHeaderView addSubview:_orderdHintLable];
    
    _orderIDLabel = [UIComUtil createLabelWithFont:kOrderDetailTextFont withTextColor:[UIColor redColor] withText:@"" withFrame:CGRectMake(currX, 0.f,orderHeaderView.frame.size.width-currX, 30.f)];
    _orderIDLabel.textAlignment = NSTextAlignmentRight;
    [orderHeaderView addSubview:_orderIDLabel];
    
    UILabel *_orderTimeHintLable =  [UIComUtil createLabelWithFont:kOrderDetailTextFont withTextColor:[UIColor redColor] withText:@"日期:" withFrame:CGRectMake(0.f,40.f,currX, 30.f)];
    [orderHeaderView addSubview:_orderTimeHintLable];
    _orderTimeLabel = [UIComUtil createLabelWithFont:kOrderDetailTextFont withTextColor:[UIColor redColor] withText:@"" withFrame:CGRectMake(currX,40.f,orderHeaderView.frame.size.width, 30.f)];
    _orderTimeLabel.textAlignment = NSTextAlignmentRight;
    [orderHeaderView addSubview:_orderTimeLabel];
    
    
    CGSize orderSize = CGSizeMake(kDeviceScreenWidth-2*kLeftPendingX,350);
    
    
    currY = currY+ orderHeaderView.frame.size.height;
     _tableView  = [[UITableView alloc]initWithFrame:CGRectMake(kLeftPendingX,currY,orderSize.width,orderSize.height) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _tableView.separatorColor = nil;
    //[_tableView registerClass:[OrderListItemCell class] forCellReuseIdentifier:cellId];
    [self.view addSubview:_tableView];
    
    [_tableView setTableHeaderView:orderHeaderView];
    SafeRelease(orderHeaderView);
    
    currY = self.view.frame.size.height-100.f;
    //for order
    UIImage *image = nil;
    
    UIImageAutoScaleWithFileName(image, @"user_btn_h");
    
    UIButton *feedBackBtn = [UIComUtil createButtonWithNormalBGImage:image withHightBGImage:image withTitle:@"意见反馈" withTag:0 withTarget:self  withTouchEvent:@selector(didButtonPress:)];
    //showOrderBtn.backgroundColor = [UIColor redColor];
    [self.view addSubview:feedBackBtn];
    
    feedBackBtn.frame = CGRectMake(40.f,currY,kDeviceScreenWidth-40*2,50);
    [self.view addSubview:feedBackBtn];
    
    [self updateUIView];
}

- (void)updateUIView {
    
    self.dataArray = self.orderItem.menuData;
    _orderTimeLabel.text = self.orderItem.orderTime;
    _orderIDLabel.text = self.orderItem.orderId;
    [_tableView reloadData];
}

- (void)didButtonPress:(id)sender {

    UserFeedBackViewController *feedBackCtrl = [[UserFeedBackViewController alloc]init];
    
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



@end
