//
//  VendorListViewController.m
//  MobileOrder
//
//  Created by cszhan on 15-5-28.
//  Copyright (c) 2015年 com.ximalaya. All rights reserved.
//

#import "VendorListViewController.h"

#import "VendorTableViewCell.h"

#import "GoodsListViewController.h"

#import "OrderItem.h"



@interface VendorListViewController ()

@end

@implementation VendorListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]){
        
        [self setNavgationBarTitle:kVendorTitle];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     [[MobileOrderNetDataMgr getSingleTone] getDingList:nil];
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
    
    
    VendorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
#if 1
        NSArray *nibArr = [[NSBundle mainBundle] loadNibNamed:@"VendorTableViewCell"
                                                        owner:self options:nil];
        NSInteger index = 0;
        
        if(kDeviceCheckIphone6){
            index = 1;
        }else if(kDeviceCheckIphone6Plus){
            index = 2;
        }
        cell = nibArr[index];
        cell.avPricesLabel.textColor = kNavBarTextColor;
#else
        cell = [[GoodsItemCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
#endif
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.clipsToBounds = YES;
        
    }
#if 0
    if(indexPath.row == 0 ){
        
        cell.contentView.backgroundColor = [UIColor redColor];
    } else if(indexPath.row == 1){
        cell.contentView.backgroundColor = [UIColor greenColor];
    }

    cell.locationNameIdLabel.text  = @"陕西咆哮肉夹馍店";
    cell.vendorNameLabel.text = @"传奇广场店";
    cell.distanceLabel.text = @"";
#else
    ShopItem *item = [self.dataArray objectAtIndex:indexPath.row];
    cell.locationNameIdLabel.text  = item.position;
    cell.vendorNameLabel.text = item.name;
    cell.avPricesLabel.text = [NSString stringWithFormat:@"人均:%0.2lf 元",item.avPrice];
    cell.distanceLabel.text = @"";
#endif
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 68.f;
    if(kDeviceCheckIphone6){
        height = 84.f;
    }else if(kDeviceCheckIphone6Plus){
        height = 86.f;
    }
    return height;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    /*
     vc.delegate = self;
     NSDictionary *item = [self.dataArray objectAtIndex:indexPath.row];
     //NSDictionary *data = [item objectForKey:@"DayDetailInfo"];
     vc.mData = item;
     */
    
    GoodsListViewController *goodLisVCtrl = [[GoodsListViewController alloc]init];
    
    [self.navigationController pushViewController:goodLisVCtrl animated:YES];
    SafeRelease(goodLisVCtrl);
    
    
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

-(void)didNetDataOK:(NSNotification*)ntf
{
    [super didNetDataOK:ntf];
    id object = [ntf object];
    NSString *key = [[object objectForKey:@"request"] resourceKey];
    if([key isEqualToString:@"getdinglist"]){
        id objData = [object objectForKey:@"data"];
        NSMutableArray *shopArray = [NSMutableArray array];
        NSArray *data = [objData objectForKey:@"data"];
        NE_LOG(@"data:%@",[data description]);
        for(NSDictionary *item in data) {
            ShopItem *shopItem =  [[ShopItem alloc]initWithDictonary:item];
            [shopArray addObject:shopItem];
            SafeRelease(shopItem);
        }
        self.dataArray = shopArray;
        
        [tweetieTableView reloadData];
    }
}


@end
