//
//  IconDownloader.h
//  网易微博iPhone客户端
//
//  Created by Xu Han Jie on 10-5-24.
//  Copyright 2010 NetEase.com, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NTESMBServer.h"
#ifdef STATUS_MODEL
#import "NTESMBUserModel.h"
#import "NTESMBStatusModel.h"
#endif
@interface NTESMBIconDownloader : NTESMBRequest 
{
	NSIndexPath *indexPath;
	NSString *identifier;
#ifdef USE_MODEL
	NTESMBUserModel *user;
#endif
}

@property (nonatomic, retain) NSIndexPath *indexPath;
@property (nonatomic, copy) NSString *identifier;

#ifdef USE_MODEL
@property (nonatomic, retain) NTESMBUserModel *user;
- (id) initWithUserModel:(NTESMBUserModel *) _user indexPath:(NSIndexPath *) _indexPath;

- (id)initWithStatusModel:(NTESMBStatusModel*)status indexPath:(NSIndexPath *) _indexPath;
#endif
@end

@interface NESkipPhotoDownloader: NTESMBIconDownloader
{
	
}
@end

