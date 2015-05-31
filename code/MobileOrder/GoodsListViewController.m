//
//  BidViewController.m
//  BSTell
//
//  Created by cszhan on 14-1-30.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#define kLeftPendingX           10
#define kTopPendingY            8
#define kHeaderItemPendingY     8

#define kSectionHeight          35.f

#define kCellHeight             100.f



#import "FoodItemCell.h"
#import "GoodsListViewController.h"
#import "NSDate+Ex.h"

#import "GoodsCatagoryView.h"
#import "GoodsCatagoryItem.h"
#import "GoodsCatagoryTableViewCell.h"


//#import "BidDetailViewController.h"

//#import "BidMainViewController.h"

@interface GoodsListViewController()<GooodsCatagoryDeleagte>{
    UIView *tbHeaderView;
    NSInteger currSection;
    
}
@property(nonatomic, strong)  NSDictionary *locationDict;

@property (nonatomic, strong) NSArray      *goodsListArray;
@property(nonatomic, strong)   GoodsCatagoryView *catogoryView;
@end

@implementation GoodsListViewController

- (void)dealloc {
    self.catogoryView = nil;
    SuperDealloc;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [ZCSNotficationMgr addObserver:self call:@selector(switchToBidMain) msgName:kTabMainSwitchMSG];
    }
    return self;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [self setNavgationBarRightButton];
    self.pageNum = 1;
    [self.dataArray removeAllObjects];
}
- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    /*
    if([self.dataArray count]==0){
        
        //[self performSelectorInBackground:@selector(shouldLoadNewerData:) withObject:tweetieTableView];
        //self.locationDict = [DBManage getLocationPointsData];
        [self shouldLoadNewerData:tweetieTableView];
    }
    */
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    //[super viewDidDisappear:animated];
    //[[DBManage getSingletone]setDelegate:nil];
    

    
}

- (void)setNavgationBarRightButton{

    UIImageWithFileName(UIImage *bgImage, @"bid_btn.png");
    CGRect newRect = CGRectMake(kDeviceScreenWidth-30.f-bgImage.size.width/2.f, 10.f, bgImage.size.width/kScale, bgImage.size.height/kScale);
    self.rightBtn.frame = newRect;
    [self.rightBtn setBackgroundImage:bgImage forState:UIControlStateNormal];
    [self.rightBtn setBackgroundImage:bgImage forState:UIControlStateSelected];
    [self.rightBtn setTitle:@"竞价大厅" forState:UIControlStateNormal];
    [self.rightBtn setTitle:@"竞价大厅" forState:UIControlStateHighlighted];
    self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:13];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    //[tweetieTableView setDragEffect:YES];
    //tweetieTableView.hasDownDragEffect = YES;
    //[[DBManage getSingletone]setDelegate:self];
    //    CGPoint insertPoint = CGPointMake(167,50);
    //    int width = 300;
    //    int height = 250;
    //
    //
    //    OCCalendarView  *calView = [[OCCalendarView alloc] initAtPoint:insertPoint withFrame:CGRectMake(insertPoint.x-157, insertPoint.y, width, height) arrowPosition:OCArrowPositionNone];
    //    [calView setSelectionMode:OCSelectionDateRange];
    //    //[calView setArrowPosition:];
    //    [self.view addSubview:[calView autorelease]];
    //    return;
    
#if 1
    UIImage *bgImage = nil;
    UIImageWithFileName(bgImage, @"car_bg.png");
    mainView.bgImage = bgImage;
#else
    mainView.mainFramView.backgroundColor = kAppUserBGWhiteColor;
#endif
    //mainView.alpha = 0.;
    if(navBarTitle == nil)
        [self setNavgationBarTitle:NSLocalizedString(@"参加竞买", @""
                                                     )];
    [self setHiddenRightBtn:NO];
    [self setHiddenLeftBtn:YES];
    [self setNavgationBarRightButton];
    //[self setRightTextContent:NSLocalizedString(@"Done", @"")];
	// Do any additional setup after loading the view.
    CGRect originRect = tweetieTableView.frame;
    originRect.origin.x = originRect.origin.x+(kDeviceScreenWidth)/4;
    tweetieTableView.frame = originRect;
    
    tweetieTableView.delegate = self;
    tweetieTableView.backgroundColor = [UIColor clearColor];
    tweetieTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tweetieTableView.clipsToBounds = YES;
    
    self.goodsListArray = @[@"面",@"凉菜",@"肉夹馍",@"肉夹馍肉夹馍肉夹馍肉夹馍肉夹馍肉夹馍肉夹馍肉夹馍",@"肉夹馍肉夹馍",@"肉夹馍肉夹馍肉夹馍肉夹馍肉夹馍肉夹馍",@"肉夹馍",@"面",@"凉菜"];
    
    _catogoryView = [[GoodsCatagoryView alloc]initWithFrame:CGRectMake(0.f,originRect.origin.y, kDeviceScreenWidth/4,originRect.size.height)];
    
    [_catogoryView setDelegate:self];
    _catogoryView.dataArray = [self convertToModelData:self.goodsListArray];
    [self.view addSubview:_catogoryView];
    [self.catogoryView scrollViewToIndex:0];
    
    
    
}

- (NSArray*)convertToModelData:(NSArray*)data{

    NSMutableArray *result = [NSMutableArray array];
    for(id item in data){
    
        if([item isKindOfClass:[NSDictionary class]]){
        
            
        } else if([item isKindOfClass:[NSString class]]){
            
            GoodsCatagoryItem *modelItem = [[GoodsCatagoryItem alloc]init];
            modelItem.name = item;
            modelItem.cellHeight = [GoodsCatagoryView getCatagoryCellHeight:item];
            [result addObject:modelItem];
            SafeRelease(modelItem);
        }
    }
    return result;
}

- (UIView*)addHeaderView:(UIView*)parentView withArrayData:(NSArray*)dataArr{
    UIImage *bgImage = nil;
    UIImageWithFileName(bgImage, @"car_plant_header.png");
    UIView *headerView = [[UIImageView alloc]initWithImage:bgImage];
    headerView.frame = CGRectMake(0.,-1., bgImage.size.width/kScale, bgImage.size.height/kScale);
    [parentView addSubview:headerView];
    CGFloat startX = 5.f;
    CGFloat itemWidth = 60.f;
    for(int i =0;i<4;i++){
        NSString *fileName = [NSString stringWithFormat:@"plant_header_tag%d.png",i];
        UIImageWithFileName(bgImage,fileName);
        assert(bgImage);
        UIImageView *item = [[UIImageView alloc]initWithImage:bgImage];
        CGFloat offsetY = 0.f;
        if(i == 2){
            offsetY = -2.f;
        }
        item.frame = CGRectMake(startX,kHeaderItemPendingY+offsetY,bgImage.size.width/kScale, bgImage.size.height/kScale);
        startX += item.frame.size.width +5.f;
        UILabel *valueLabel = [[UILabel alloc]initWithFrame:CGRectMake(startX,kHeaderItemPendingY,itemWidth,14.f)];
        valueLabel.font = [UIFont systemFontOfSize:12];
        valueLabel.text = @"";
        valueLabel.tag = i;
        valueLabel.adjustsFontSizeToFitWidth = YES;
        valueLabel.textColor = [UIColor whiteColor];
        valueLabel.backgroundColor = [UIColor clearColor];
        [headerView addSubview:valueLabel];
        SafeRelease(valueLabel);
        [headerView addSubview:item];
        SafeRelease(item);
        startX += 40+20.f;
    }
    return SafeAutoRelease(headerView);
}
#pragma mark -
#pragma mark tableview

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return [self.goodsListArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kSectionHeight;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
   
    NSString *title = [self.goodsListArray objectAtIndex:section];
    UILabel *titleLabel = [UIComUtil createLabelWithFont:[UIFont systemFontOfSize:15.f] withTextColor:kGoodCatagorySelectedTextColor withText:title withFrame:CGRectMake(0.f, 0.f,kDeviceScreenWidth, kSectionHeight)];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.backgroundColor = [UIColor whiteColor];
    return titleLabel;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return  5;
    //return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";
   
    
    FoodItemCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
#if 1
        NSArray *nibArr = [[NSBundle mainBundle] loadNibNamed:@"FoodItemCell"
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        cell.clipsToBounds = YES;
        
    }
    
    currSection = indexPath.section;
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

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0) {
    if(section==0 ){
         [self.catogoryView scrollViewToIndex:0];
        return;
    }
    CGRect oldRect = [tableView rectForSection:section];
    UITableViewHeaderFooterView *headerview = [tableView headerViewForSection:section+1];
    //CGRect boxRect = CGRectMake(0.f,0.f,view.frame.size.width,view.frame.size.height);
    //if(rect.origin.y == view.frame.size.height)
    //if(currSection != section)
    {
    
        [self.catogoryView scrollViewToIndex:section];
        
    }

    
}
- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0){
    if(section+1>=[self.goodsListArray count])
        return;
    CGRect rect = [[UIApplication sharedApplication].keyWindow convertRect:view.frame fromView:view];
    CGRect nextRect = [tableView rectForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section+1]];
    CGRect  size = [tableView rectForSection:section];
    
    //CGRect boxRect = CGRectMake(0.f,0.f,view.frame.size.width,view.frame.size.height);
    if(rect.origin.y == view.frame.size.height)
        //if(currSection != section)
    {
        
        [self.catogoryView scrollViewToIndex:section];
        
    }
}

#pragma mark -

- (void)didSelectorItemIndex:(NSInteger)index {

    [tweetieTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UITableViewScrollPositionTop animated:YES];
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
#pragma mark -network
- (void) shouldLoadNewerData:(NTESMBTweetieTableView *) tweetieTableView{
    self.pageNum = 1;
    [self shouldLoadOlderData:tweetieTableView];
}
- (void) shouldLoadOlderData:(NTESMBTweetieTableView *) tweetieTableView{

    //NSString *catStr = [NSString stringWithFormat:@"%d",self.goodGroupNum];
    NSString *pageNumStr = [NSString stringWithFormat:@"%d",self.pageNum];
    /*
     @"001",@"hydm",
     @"10",@"limit",
     @"1",@"offset",
     zc	专场代码
     wtzt
     rqStart	竞价日期1
     rqEnd	竞价日期2
     */
    return;
    NSDate *date = [NSDate date];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           //catStr,@"cat",
                           pageNumStr, @"offset",
                           @"",@"zc",
                           @"3",@"wtzt",
                           self.userId,@"hydm",
                           @"10",@"limit",
                           [NSDate formartDateTime:date withFormat:@"yyyyMMdd"],@"rqStart",
                           @"20991231",@"rqEnd",
                           nil];
    CarServiceNetDataMgr *carServiceNetDataMgr = [CarServiceNetDataMgr getSingleTone];
    //self.request = [carServiceNetDataMgr  queryAuctionWts4Move:param];
}
- (NSString*)formartDateTime:(NSDate*)date withFormat:(NSString*)formart{

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
	[formatter setLocale:locale];
    SafeRelease(locale);
	[formatter setDateFormat:formart];
	NSString *string = [formatter stringFromDate:date];
	SafeRelease(locale);
    return string;
}
-(void)didNetDataOK:(NSNotification*)ntf
{
    
    [super didNetDataOK:ntf];
    
    
    id obj = [ntf object];
    id respRequest = [obj objectForKey:@"request"];
    id data = [obj objectForKey:@"data"];
    NSString *resKey = [obj objectForKey:@"key"];//[respRequest resourceKey];
    //NSString *resKey = [respRequest resourceKey];
    if([resKey isEqualToString:kResBidListData])
    {
        //        if ([self.externDelegate respondsToSelector:@selector(commentDidSendOK:)]) {
        //            [self.externDelegate commentDidSendOK:self];
        //        }
        //        kNetEndSuccStr(@"评论成功",self.view);
        //        [self dismissModalViewControllerAnimated:YES];
#if 1
        [self reloadNetData:data];
#else
//        if([[data objectForKey:@"data"] count]<10.f){
//            isRefreshing = YES;
//        }
        self.dataArray = [data objectForKey:@"data"];
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
- (void)didUserLogout:(NSNotification*)ntf{
    //isLogin = NO;
    [self.navigationController popToRootViewControllerAnimated:YES];
    [self.dataArray removeAllObjects];
    self.pageNum = 1;
    [AppSetting setLogoutUser];
    
}
- (void)didUserLogin:(NSNotification*)ntf{

  [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)didUserLoginCancel:(NSNotification*)ntf{

    
}
@end
