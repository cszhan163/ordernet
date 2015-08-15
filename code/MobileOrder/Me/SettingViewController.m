//
//  SettingViewController.m
//  MobileOrder
//
//  Created by cszhan on 15-7-25.
//  Copyright (c) 2015年 com.ximalaya. All rights reserved.
//

#import "SettingViewController.h"


@interface SetTableCell : UITableViewCell

@property (nonatomic, strong)   UISwitch    *swBtn;

@end

@implementation SetTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    
        UISwitch *sw = [[UISwitch alloc]init];
        self.accessoryView = sw;
        SafeRelease(sw);
        self.swBtn = sw;
    }
    return self;
}

@end

#define kMeSettingCellHeight    44

@interface SettingViewController () {

    UITableView *_tableView;
}

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation SettingViewController

- (void)dealloc {
    self.dataArray = nil;
    SuperDealloc;
}

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
    SetTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(cell == nil){
        
        cell = [[SetTableCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        
        [cell.swBtn addTarget:self action:@selector(valueDidChange:) forControlEvents:UIControlEventValueChanged];
    
        SafeAutoRelease(cell);
        
    }
     NSDictionary *item = self.dataArray[indexPath.row];
#if 0
    //cell.titleLable.text =  [NSString stringWithFormat:@"%@+%@",item.goodsName,item.name];
    
#else
    cell.accessoryView.tag = indexPath.row;
    cell.textLabel.text = [item objectForKey:@"text"];
    if(indexPath.row == 2){
        cell.accessoryView = nil;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else {
    
        switch (indexPath.row) {
            case 0 :
                if([AppSetting pushEnable]){
                    [cell.swBtn setOn:YES];
                    
                }else {
                    
                    [cell.swBtn setOn:NO];
                
                }
                break;
            case 1 :
                if([AppSetting userAutoLogin]){
                    [cell.swBtn setOn:YES];
                    
                }else {
                    
                    [cell.swBtn setOn:NO];
                    
                }
                break;
            default:
                break;
        }
    }
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
