//
//  OrderMenuView.m
//  MobileOrder
//
//  Created by cszhan on 15-6-6.
//  Copyright (c) 2015年 com.ximalaya. All rights reserved.
//

#import "GoodsOrderMenuView.h"

@implementation GoodsOrderMenuView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    /*
    GoodsCatagoryItem *item = [self.dataArray objectAtIndex:indexPath.row];
    return item.cellHeight;
    */
    return 44.f;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GoodsCatagoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    if(cell == nil){
        
        cell = [[GoodsCatagoryTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        
    }
#if 1
    GoodsCatagoryItem *item = [self.dataArray objectAtIndex:indexPath.row];
    cell.titleLable.text =  item.name;
    
#else
    cell.titleLable.text =  [self.dataArray objectAtIndex:indexPath.row];
#endif
    return cell;
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


@end
