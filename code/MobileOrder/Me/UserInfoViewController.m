//
//  UserInfoViewController.m
//  MobileOrder
//
//  Created by cszhan on 15-7-6.
//  Copyright (c) 2015年 com.ximalaya. All rights reserved.
//

#import "UserInfoViewController.h"

@interface UserInfoViewController ()

@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
        NSMutableArray *shopArray = [NSMutableArray array];
        NSArray *data = [objData objectForKey:@"data"];
        NE_LOG(@"data:%@",[data description]);
      
    }
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
