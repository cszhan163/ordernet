//
//  FriendItemCell.h
//  DressMemo
//
//  Created by  on 12-7-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "UINetActiveIndicatorButton.h"
#import "UIBaseTableViewCell.h"
@class UINetActiveIndicatorButton;
@interface GoodsItemCell : UIBaseTableViewCell{
    
}
@property(nonatomic,strong)NSMutableArray *labelArray;
@property(nonatomic,retain)IBOutlet UILabel *nickNameLabel;
@property(nonatomic,retain)IBOutlet UILabel *locationLabel;
@property(nonatomic,strong)IBOutlet UILabel *indictTextLabel;
@property(nonatomic,retain)IBOutlet UINetActiveIndicatorButton *relationBtn;
@property(nonatomic,retain)IBOutlet UIImageView *goodsIconImageView;
+(id)getFromNibFile;
- (BOOL)setCellItemValue:(NSString*)value withIndex:(NSInteger)index;
@end
