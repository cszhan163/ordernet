//
//  UserInfoViewController.m
//  MobileOrder
//
//  Created by cszhan on 15-7-6.
//  Copyright (c) 2015年 com.ximalaya. All rights reserved.
//

#import "UserInfoViewController.h"

#define kMeCellHeight  44.f


#define  kKeyArray @[@"userName",@"mobile",@"integral",@"email"]

#define  kKeyMapArray @[@"用户名:",@"手机号:", @"积分:",@"邮件:"]

@interface UserInfoViewController (){

    UITableView *_tableView;
}

@property (nonatomic, strong) NSDictionary *userDict;


@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat currY = offsetY;
    _tableView  = [[UITableView alloc]initWithFrame:CGRectMake(0.f,currY,kDeviceScreenWidth,kDeviceScreenHeight-kMBAppStatusBar-kMBAppTopToolBarHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _tableView.separatorColor = nil;
    //[_tableView registerClass:[GoodsCatagoryTableViewCell class] forCellReuseIdentifier:cellId];
    [self.view addSubview:_tableView];
    SafeRelease(_tableView);
    // Do any additional setup after loading the view.
    [[MobileOrderNetDataMgr getSingleTone] userUser:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)didNetDataOK:(NSNotification*)ntf
{
    [super didNetDataOK:ntf];
    id object = [ntf object];
    NSString *key = [[object objectForKey:@"request"] resourceKey];
    if([key isEqualToString:@"getuserInfo"]){
        id objData = [object objectForKey:@"data"];
        id data = [objData objectForKey:@"data"];
        /*
        NSMutableArray *shopArray = [NSMutableArray array];
        
        NE_LOG(@"data:%@",[data description]);
        */
        self.userDict = data;
        [_tableView reloadData];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return  [kKeyArray count];
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
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        SafeAutoRelease(cell);
        
    }
#if 0
    //cell.titleLable.text =  [NSString stringWithFormat:@"%@+%@",item.goodsName,item.name];
    
#else
    NSString *keyValue =  kKeyArray[indexPath.row];
    id dataValue = [self.userDict objectForKey:keyValue];
    cell.textLabel.text = kKeyMapArray[indexPath.row];
    if(dataValue && ![dataValue isKindOfClass:[NSNull class]]){
        
        if ([dataValue isKindOfClass:[NSNumber class]]){
            
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%lld",[dataValue longLongValue]];
        }
        if([dataValue isKindOfClass:[NSString class]])
            cell.detailTextLabel.text = dataValue;
    }
#endif
    return cell;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
