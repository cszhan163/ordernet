//
//  FoodOrderListViewController.m
//  MobileOrder
//
//  Created by cszhan on 15-6-24.
//  Copyright (c) 2015年 com.ximalaya. All rights reserved.
//

#import "FoodOrderListViewController.h"

#import "FoodsOrderListCell.h"

#import "OrderItem.h"

#define kOrderCellHeight            70.f

#define GoodsListTitleArray     @[@"时间",@"金额",@"状态"]

@interface FoodOrderListViewController ()

@end

@implementation FoodOrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
#if 1
    NSMutableArray *data = [NSMutableArray array];
    for(int i = 0;i< 20;i++){
        
        OrderItem *item = [[OrderItem alloc]init];
        item.orderTime = @"2015-06-19-09:50";
        item.payPrice = i+ 180.f;
        if(i ==0)
            item.status = Order_Pay;
        else
            item.status = Order_Done;
        [data addObject:item];
    }
    self.dataArray = data;
#endif
    
    // Do any additional setup after loading the view.
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return  5;
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    
    FoodsOrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
#if 0
        NSArray *nibArr = [[NSBundle mainBundle] loadNibNamed:@"BidItemCell"
                                                        owner:self options:nil];
        for (id oneObject in nibArr)
            if ([oneObject isKindOfClass:[BidItemCell class]])
                cell = (BidItemCell*)oneObject;
#else
        NSArray *widthArray = @[@140,@80,@80];
        
        
        if(kDeviceCheckIphone6){
            //+18*3
            widthArray = @[@158,@98,@99];
        }else if(kDeviceCheckIphone6Plus){
            //
            widthArray = @[@280,@160,@160];
        }
        
        cell = [[FoodsOrderListCell alloc]initWithFrame:CGRectMake(0.f, 0.f,kDeviceScreenWidth, kOrderCellHeight) withRowCount:1 withColumCount:1 withCellHeight:kOrderCellHeight];
#endif
        /**
         * 320,375,621
         */
        
       

        [cell setClounmWidthArrays:widthArray];
        //for(int i=0 ;i<widthArray;i++)
        {
            //[cell setTitle:GoodsListTitleArray withIndex:i];
            
        }
        [cell addColumWithKeyTitleArray:GoodsListTitleArray withColumWidthArray:widthArray];
        
        cell.selectionStyle = UITableViewCellAccessoryDisclosureIndicator;
        cell.backgroundColor = [UIColor clearColor];
        cell.clipsToBounds = YES;
        
    }
    
    OrderItem *item = self.dataArray[indexPath.row];
    if(item.status == Order_Pay){
        cell.contentView.backgroundColor = [UIColor redColor];
    } else if(item.status == Order_Done){
        cell.contentView.backgroundColor = [UIColor greenColor];
    }
    //for time
    [cell setCellItemValue:item.orderTime withRow:0 withCol:0];
    [cell setCellItemValue:[NSString stringWithFormat:@"¥%0.2lf",item.payPrice] withRow:0 withCol:1];
    
    NSString *status = @"已完成";
    if(item.status == Order_Pay){
        status =  @"已支付/未上菜";
    }
    
    [cell setCellItemValue:status withRow:0 withCol:2];
    //cell.nickNameLabel = @"测试";
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return kOrderCellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    /*
     vc.delegate = self;
     NSDictionary *item = [self.dataArray objectAtIndex:indexPath.row];
     //NSDictionary *data = [item objectForKey:@"DayDetailInfo"];
     vc.mData = item;
     */
    /*
    GoodsListViewController *goodLisVCtrl = [[GoodsListViewController alloc]init];
    
    [self.navigationController pushViewController:goodLisVCtrl animated:YES];
    SafeRelease(goodLisVCtrl);
    */
    
}
-(void)didSelectorTopNavigationBarItem:(id)sender{
    
    if([sender tag] == 0){
        [self.navigationController popViewControllerAnimated:YES];
    }
    if([sender tag] == 1){
        
        //        BidMainViewController *bidMainVc = [[BidMainViewController alloc]init];
        //        [self.navigationController pushViewController:bidMainVc animated:YES];
        //        SafeRelease(bidMainVc);
    }
}


@end
