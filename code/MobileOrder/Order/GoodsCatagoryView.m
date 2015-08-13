//
//  GoodCatogoryTableViewController.m
//  MobileOrder
//
//  Created by cszhan on 15-5-30.
//  Copyright (c) 2015年 com.ximalaya. All rights reserved.
//

#import "GoodsCatagoryView.h"
#import "GoodsCatagoryTableViewCell.h"
#import "GoodsCatagoryItem.h"




@interface GoodsCatagoryView () <UITableViewDataSource,UITableViewDelegate>{

  
}

@property (nonatomic, strong)NSDictionary *bandgeDictData;

@end

@implementation GoodsCatagoryView

- (void)dealloc {

    self.tableView = nil;
    SuperDealloc;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    CGPoint origin = _tableView.frame.origin;
    _tableView.frame = CGRectMake(origin.x, origin.y,frame.size.width, frame.size.height);
}

- (id)initWithFrame:(CGRect)frame {
    
    if(self = [super initWithFrame:frame]){
    _tableView  = [[UITableView alloc]initWithFrame:CGRectMake(0.f, 0.f, frame.size.width, frame.size.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.separatorColor = nil;
    //[_tableView registerClass:[GoodsCatagoryTableViewCell class] forCellReuseIdentifier:cellId];
    [self addSubview:_tableView];
    }
    return self;
}

- (void)scrollViewToIndex:(NSInteger)index {
    if(index>=[self.dataArray count])
        return;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0] ;
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:YES];
    GoodsCatagoryTableViewCell *indexCell = (GoodsCatagoryTableViewCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    [indexCell setCellSelectedStatus:YES];
    for(int i =0;i<[self.dataArray count];i++){
        if(i == index)
            continue;
        indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        indexCell = (GoodsCatagoryTableViewCell*)[self.tableView cellForRowAtIndexPath:indexPath];
        [indexCell setCellSelectedStatus:NO];
    }
    
}

- (void)setNeedsLayout {
    [super setNeedsLayout];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.dataArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    GoodsCatagoryItem *item = [self.dataArray objectAtIndex:indexPath.row];
    return item.cellHeight;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    static NSString *cellId = @"resumeCellId";
    GoodsCatagoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(cell == nil){
        
        cell = [[GoodsCatagoryTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        
    }
#if 1
    GoodsCatagoryItem *item = [self.dataArray objectAtIndex:indexPath.row];
    cell.titleLable.text =  item.cataName;
    id badgeValue = [self.bandgeDictData objectForKey:item.cataName];
    if(badgeValue){
        
        [cell setCellBandgeWithNumber:[badgeValue intValue]];
    } else {
    
        [cell setCellBandgeWithNumber:0];
    }
   
#else
    cell.titleLable.text =  [self.dataArray objectAtIndex:indexPath.row];
#endif
    return cell;
}

- (void)updateCellBandgeWithData:(NSDictionary*)data {
    
    self.bandgeDictData = data;
    /*
    for(id key in data){
        NSInteger value = [[data objectForKey:key]integerValue];
        NSInteger index = [self getCataIndexByName:key];
        if(index != -1){
            GoodsCatagoryTableViewCell *cellItem = (GoodsCatagoryTableViewCell*)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
            [cellItem setCellBandgeWithNumber:value];
        }
    }
    */
    [_tableView reloadData];
}

- (NSInteger)getCataIndexByName:(NSString*)name {

    for(int i = 0;i<[self.dataArray count];i++){
        GoodsCatagoryItem *item = self.dataArray[i];
        if([item.cataName isEqualToString:name]){
        
            return i;
        }
    }
    return -1;
}

+ (CGFloat) getCatagoryCellHeight:(NSString*)txt {

    return [GoodsCatagoryTableViewCell getCellHeightWithText:txt];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(didSelectorItemIndex:)]) {
        
        [self.delegate didSelectorItemIndex:indexPath.row];
    }
    /*
     vc.delegate = self;
     NSDictionary *item = [self.dataArray objectAtIndex:indexPath.row];
     //NSDictionary *data = [item objectForKey:@"DayDetailInfo"];
     vc.mData = item;
    */
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
