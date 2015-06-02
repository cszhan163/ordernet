//
//  MemoPhotoDownloader.h
//  DressMemo
//
//  Created by  on 12-7-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DressMemoUserIconDownloader.h"

@interface MemoPhotoDownloader:DressMemoUserIconDownloader
{
    
}

//for tableview skip view
- (id) initWithTinyImageUrl:(NSString*)iconUrl indexPath:(NSIndexPath *) _indexPath;
//for memo detail view
- (id) initWithSmallImageUrl:(NSString*)iconUrl indexPath:(NSIndexPath *) _indexPath;
//for memo tag view
- (id) initWithOriginImageUrl:(NSString*)iconUrl indexPath:(NSIndexPath *) _indexPath;

@property(nonatomic,assign) NSInteger cellIndex;
@end
