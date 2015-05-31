//
//  BidViewController.m
//  BSTell
//
//  Created by cszhan on 14-1-30.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#define kLeftPendingX  10
#define kTopPendingY  8
#define kHeaderItemPendingY 8

#import "BidItemCell.h"
#import "BidViewController.h"

#import "BidDetailViewController.h"

#import "BidMainViewController.h"

@interface BidViewController(){
    UIView *tbHeaderView;
}
@property(nonatomic,strong)NSDictionary *locationDict;
@end

@implementation BidViewController

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
- (void)switchToBidMain{
    BidMainViewController *bidMainVc = [[BidMainViewController alloc]init];
    [self.navigationController pushViewController:bidMainVc animated:YES];
    SafeRelease(bidMainVc);
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
    /*
    tweetieTableView.bounces = YES;
    [tweetieTableView setDragEffect:YES];
    tweetieTableView.hasDownDragEffect = YES;
     */
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
    tweetieTableView.frame = CGRectMake(kLeftPendingX,kMBAppTopToolBarHeight+kTopPendingY,kDeviceScreenWidth-2*kLeftPendingX,kMBAppRealViewHeight-kTopPendingY);
    //mainView.topBarView.backgroundColor = HexRGB(1, 159, 233);
    /*
    UIImageWithFileName(bgImage, @"car_plant_bg.png");
    UIImageView *tableViewBg = [[UIImageView alloc]initWithImage:bgImage];
    [self.view  addSubview:tableViewBg];
    SafeRelease(tableViewBg);
    tableViewBg.frame = tweetieTableView.frame;
    [tweetieTableView removeFromSuperview];
    [tableViewBg addSubview:tweetieTableView];
    tweetieTableView.frame = CGRectMake(0.f,0.f,tableViewBg.frame.size.width,tableViewBg.frame.size.height);
    
    tableViewBg.clipsToBounds = YES;
    tableViewBg.userInteractionEnabled = YES;
     */
    tweetieTableView.delegate = self;
    tweetieTableView.backgroundColor = [UIColor clearColor];
    tweetieTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tweetieTableView.clipsToBounds = YES;
    
    /*
    tbHeaderView = [self addHeaderView:tableViewBg   withArrayData:nil];
    tweetieTableView.normalEdgeInset = UIEdgeInsetsMake(tbHeaderView.frame.size.height,0.f,0.f,0.f);
    */
#if 0
    NSError *error = nil;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"plantData" ofType:@"geojson"];
    NSString *dataStr = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    //[NSJSONSerialization]
    
    NSDictionary *restData = [NSJSONSerialization   JSONObjectWithData:[dataStr dataUsingEncoding:NSUTF8StringEncoding ]options:NSJSONReadingMutableContainers  error:&error];
    
    self.dataArray = [[restData objectForKey:@"info"] objectForKey:@"data"];
    
    [tweetieTableView reloadData];
    
    
#else
    //[self  ]
    
#endif
    
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	//return  5;
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";
   
    
    BidItemCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
#if 0
        NSArray *nibArr = [[NSBundle mainBundle] loadNibNamed:@"BidItemCell"
                                                        owner:self options:nil];
        for (id oneObject in nibArr)
            if ([oneObject isKindOfClass:[BidItemCell class]])
                cell = (BidItemCell*)oneObject;
#else
        cell = [[BidItemCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
#endif
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.clipsToBounds = YES;
        
    }
    /*
     返回JSON数据参数	参数名称	参数类型
     wtid	场次Id
     ggmc	公告title
     ggid	公告id
     joinStatus	参加状态	1 参加
     0 未参加
     hzjc	卖家简称
     dfyj	买家保证金
     kssj	竞价开始时间
     jssj	竞价结束时间
     isCanJoin	可参加状态	1 可参加
     0 不可参加
     ssdl	所属大类	

     */
    NSDictionary *item = [self.dataArray objectAtIndex:indexPath.row];
    int index = 0;
    NSString *value = @"";
    
    
    value = [item objectForKey:@"wtmc"];
    [cell setCellItemValue:value withIndex:index++];
    //id
    value = [item objectForKey:@"wtid"];
    [cell setCellItemValue:value withIndex:index++];
    

    //起拍价
    value = [item objectForKey:@"dfyj"];
    value = [NSString stringWithFormat:@"%0.2lf元",[value floatValue]];
    [cell setCellItemValue:value withIndex:index++];
    
    //
    //sell company
    value = [item objectForKey:@"hzjc"];
    
    [cell setCellItemValue:value withIndex:index++];
    
  
    
    //是否参加
    value = [item objectForKey:@"joinStatus"];
    if([value intValue]){
        [cell setCellItemValue:@"已参加" withIndex:index++];
    }
    else{
        [cell setCellItemValue:@"未参加" withIndex:index++];
    }
    //[cell setCellItemValue:value withIndex:index++];
    //time
    NSString *startString = [item  objectForKey:@"kssj"];
    NSString *endString = [item objectForKey:@"jssj"];
    startString  = [NSDate  dateFormart:startString fromFormart:@"yyMMddHHmm" toFormart:@"yyyy-MM-dd    HH:mm"];
    endString  = [NSDate  dateFormart:endString fromFormart:@"yyMMddHHmm" toFormart:@"HH:mm"];
    value  = [NSString  stringWithFormat:@"%@ - %@",startString,endString];
    [cell setCellItemValue:value withIndex:index++];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 140.f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    BidDetailViewController *vc = [[BidDetailViewController alloc]initWithNibName:nil bundle:nil];
    
    [vc  setNavgationBarTitle:@"场次详情"];
    

    if([self.dataArray count]){
        NSDictionary *item = [self.dataArray objectAtIndex:indexPath.row];
        //NSDictionary *data = [item objectForKey:@"DayDetailInfo"];
        vc.data = item;
        vc.wtid = [item objectForKey:@"wtid"];
   
    if(![[item objectForKey:@"isCanJoin"]intValue]){
        
        [vc  setJoinButtonHiddenStatus:YES];
        
    }
    /*
    vc.delegate = self;
    NSDictionary *item = [self.dataArray objectAtIndex:indexPath.row];
    //NSDictionary *data = [item objectForKey:@"DayDetailInfo"];
    vc.mData = item;
     */
#if 1
    [self.navigationController pushViewController:vc animated:YES];
#else
    
    [ZCSNotficationMgr postMSG:kPushNewViewController obj:vc];
#endif
    //[self.navigationController pushViewController:vc animated:YES];
   
    SafeRelease(vc);
         }
    
}
-(void)didSelectorTopNavigationBarItem:(id)sender{
   
    
    if([sender tag] == 1){
    
        BidMainViewController *bidMainVc = [[BidMainViewController alloc]init];
        [self.navigationController pushViewController:bidMainVc animated:YES];
        SafeRelease(bidMainVc);
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
    self.request = [carServiceNetDataMgr  queryAuctionWts4Move:param];
}
- (NSString*)formartDateTime:(NSDate*)date withFormat:(NSString*)formart{

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
	[formatter setLocale:locale];
	[locale release];
	[formatter setDateFormat:formart];
	NSString *string = [formatter stringFromDate:date];
	[formatter release];
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
