//
//  MeViewController.m
//  MobileOrder
//
//  Created by cszhan on 15-6-24.
//  Copyright (c) 2015年 com.ximalaya. All rights reserved.
//

#import "MeViewController.h"

#import "FoodOrderListViewController.h"
#import "UserInfoViewController.h"
#import "SettingViewController.h"
#import "ZCSNetClient.h"

#define kPendingY    20.f

#define kMeCellHeight    44.f

#define kUserHeaderViewHeight   120.f

#define kTableIconArray      @[@"",@"",@"",@"",@"user_setting.png"]

@interface MeViewController () {

    UITableView     *_tableView;
}



@end

@implementation MeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]){
        
        [self setNavgationBarTitle:kMeCenterTitle];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGFloat currY = kMBAppTopToolBarHeight;
    if(kIsIOS7Check)
    {
        currY += kMBAppStatusBar;
    }
    
    _tableView  = [[UITableView alloc]initWithFrame:CGRectMake(0.f,currY,kDeviceScreenWidth,kDeviceScreenHeight-kMBAppStatusBar-kMBAppTopToolBarHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _tableView.separatorColor = nil;
    //[_tableView registerClass:[GoodsCatagoryTableViewCell class] forCellReuseIdentifier:cellId];
    [self.view addSubview:_tableView];
    SafeRelease(_tableView);
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0.f, 0.f,kDeviceScreenWidth, kUserHeaderViewHeight)];
    UIImage *image = nil;
    UIImageAutoScaleWithFileName(image,@"user_img_default");
    assert(image);
    //
    UIButton *leftBtn = [UIComUtil createButtonWithNormalBGImage:image withHightBGImage:image withTitle:@"" withTag:1];
    leftBtn.frame = CGRectMake((kDeviceScreenWidth-image.size.width)/2.f,kPendingY,image.size.width,image.size.height);
    [headerView addSubview:leftBtn];
    [leftBtn addTarget:self action:@selector(didPressUserIconAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageAutoScaleWithFileName(image,@"user_head_bg");
    assert(image);
    headerView.layer.contents = (id)image.CGImage;
    [_tableView setTableHeaderView:headerView];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"MeMenu" ofType:@"plist"];
    NSDictionary *meData = [NSDictionary dictionaryWithContentsOfFile:path];
    
    self.dataArray =  [meData objectForKey:@"data"];
    
    
    
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

- (void)didPressUserIconAction:(id)sender {

    [[MobileOrderNetDataMgr getSingleTone] userLogin:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return  [self.dataArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    /*
     GoodsCatagoryItem *item = [self.dataArray objectAtIndex:indexPath.row];
     return item.cellHeight;
     */
    return kMeCellHeight;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"resumeMenuCellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(cell == nil){
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        SafeAutoRelease(cell);
        
    }
#if 0
    //cell.titleLable.text =  [NSString stringWithFormat:@"%@+%@",item.goodsName,item.name];

#else
    NSDictionary *item = self.dataArray[indexPath.row];
    NSString *iconName = [item objectForKey:@"iconName"];
    UIImage *image = nil;
    UIImageAutoScaleWithFileName(image,iconName);
    //assert(image);
    cell.imageView.image = image;
    cell.textLabel.text = [item objectForKey:@"text"];
#endif
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    /*
     vc.delegate = self;
     NSDictionary *item = [self.dataArray objectAtIndex:indexPath.row];
     //NSDictionary *data = [item objectForKey:@"DayDetailInfo"];
     vc.mData = item;
     */
     NSDictionary *item = self.dataArray[indexPath.row];
    
    NSString *key = [item objectForKey:@"key"];
    if([key isEqualToString:@"order"]){
        
        FoodOrderListViewController *foodOrderListVCtrl = [[FoodOrderListViewController alloc]init];
        [self.navigationController pushViewController:foodOrderListVCtrl animated:YES];
        SafeRelease(foodOrderListVCtrl);
    }
    if([key isEqualToString:@"userInfo"]) {
    
        UserInfoViewController *userVctl = [[UserInfoViewController alloc]init];
        
        [self.navigationController pushViewController:userVctl animated:YES];
        SafeRelease(userVctl);
        
        
    }
    if([key isEqualToString:@""]) {
    
        SettingViewController *setVctl = [[UserInfoViewController alloc]init];
        
        [self.navigationController pushViewController:setVctl animated:YES];
        SafeRelease(setVctl);
        
    }
}


-(void)didNetDataOK:(NSNotification*)ntf
{
    //kNetEnd(self.view);
    //NE_LOG(@"warning not implemetation net respond");
    //self.view.userInteractionEnabled = YES;
    id obj = [ntf object];
    ZCSNetClient *respRequest = [obj objectForKey:@"request"];
    id _data = [obj objectForKey:@"data"];
    NSString *resKey = [respRequest resourceKey];
    if(resKey == @"userInfo")
    {
        
    }
}

@end
