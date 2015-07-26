//
//  SettingViewController.m
//  MobileOrder
//
//  Created by cszhan on 15-7-25.
//  Copyright (c) 2015年 com.ximalaya. All rights reserved.
//

#import "SettingViewController.h"

#define kMeSettingCellHeight    44

@interface SettingViewController () {

    UISwitch *sw;
}

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"MeSetting" ofType:@"plist"];
    NSDictionary *meData = [NSDictionary dictionaryWithContentsOfFile:path];
    
    self.dataArray =  [meData objectForKey:@"data"];
        // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return  [self.dataArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    /*
     GoodsCatagoryItem *item = [self.dataArray objectAtIndex:indexPath.row];
     return item.cellHeight;
     */
    return kMeSettingCellHeight;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"resumeMenuCellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(cell == nil){
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:cellId];
        sw = [[UISwitch alloc]init];
        [sw addTarget:self action:@selector(valueDidChange:) forControlEvents:UIControlEventValueChanged];
        cell.accessoryView = sw;
        SafeAutoRelease(sw);
        SafeAutoRelease(cell);
        
    }
     NSDictionary *item = self.dataArray[indexPath.row];
#if 0
    //cell.titleLable.text =  [NSString stringWithFormat:@"%@+%@",item.goodsName,item.name];
    
#else
    cell.accessoryView.tag = indexPath.row;
    cell.textLabel.text = [item objectForKey:@"text"];
#endif
    return cell;
}

- (void)valueDidChange:(id)sender {
 
    NSInteger index = [sender tag];
    UISwitch *sw = (UISwitch*)sender;
    switch (index) {
        case 0:
            [AppSetting setPushEnable:sw.isOn];
            break;
        case 1:
            [AppSetting setUserAutoLogin:sw.isOn];
            break;
        default:
            break;
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
