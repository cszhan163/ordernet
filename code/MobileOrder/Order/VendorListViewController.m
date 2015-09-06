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

- (void) dealloc {

    SuperDealloc;
}

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
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self  performSelector:@selector(startloadVisibleCellImageData:) withObject:indexPath afterDelay:0.f];
    
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
    
    goodLisVCtrl.shopItem = self.dataArray[indexPath.row];
    
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

#pragma mark -
#pragma mark - image

-(void)startloadVisibleCellImageData:(NSIndexPath*)indexPath
{
    //NE_LOG(@"warning load visibleCellImagedata not implementation");
    UIImage *image = UIImageWithFileName(image ,@"food_default_s.png");
    ShopItem *shopItem = self.dataArray[indexPath.row];
    if(shopItem.imageURL == nil){
    
        shopItem.imageURL = @"http://picvideo.uhuocn.com:65102//Data/MenuImg/541704/l20150706/20150706041603408.jpg";
    }
    UIImage *photo = [[NTESMBLocalImageStorage getInstance] getSmallImageWithUrl:shopItem.imageURL];
    if (photo != nil) {
        image = photo;
    }else{
        NTESMBIconDownloader *_downloader = [[NTESMBIconDownloader alloc]initWithUrlString:shopItem.imageURL];
        _downloader.delegate = self;
        _downloader.indexPath = indexPath;
        [[NTESMBServer getInstance] addRequest:_downloader];
        [allIconDownloaders setValue:_downloader forKey:shopItem.imageURL];
        SafeRelease(_downloader);
    }
    [self setImageData:image withIndexPath:indexPath];
}

- (void)setImageData:(UIImage*)imageData withIndexPath:(NSIndexPath*)indexPath {

    ShopItem *item = [self.dataArray objectAtIndex:indexPath.row];
    VendorTableViewCell *vendorCell = [tweetieTableView cellForRowAtIndexPath:indexPath];
    [vendorCell.vendorImageView setImage:imageData];
}

-(void)updatesegmentTitle:(NSInteger)icount
{
    
}
- (void) cancelAllIconDownloads
{
    //NE_LOG(@"warning not emplementation icon downloads cancell");
    for(NTESMBIconDownloader *_downloader in allIconDownloaders){
    
        [_downloader setDelegate:nil];
    }
    [allIconDownloaders removeAllObjects];
}


- (void) requestCompleted:(NTESMBIconDownloader *) request{
    //if (request == _downloader)
    {
        if(request.receiveData){
            [[NTESMBLocalImageStorage getInstance] saveImageDataToSmallDir:request.receiveData
                                                                    urlString:request.urlString];
        }
        
        NSIndexPath *indexPath= request.indexPath;
        
        UIImage *image = [[NTESMBLocalImageStorage getInstance] getSmallImageWithUrl:request.urlString];
        //if([self.scrollViewPreview.getPageControl currentPage] == request.cellIndex)
        {
           [self setImageData:image withIndexPath:indexPath];
        }
    }
    [allIconDownloaders removeObjectForKey:request.urlString];
    request.delegate = nil;
    request = nil;
}

- (void) requestFailed:(NTESMBIconDownloader *) request{
    
}
@end
