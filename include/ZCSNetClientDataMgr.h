//
//  ZCSNetClientMgr.h
//  DressMemo
//
//  Created by  on 12-6-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCSNetClientNetInterfaceMgr.h"
@interface ZCSNetClientDataMgr : NSObject
+(id)getSingleTone;
-(void)startUserLogin:(NSDictionary*)param;
/*user*/
-(id)getUserInfor:(NSDictionary*)param;
-(id)canPostData:(NSDictionary*)param;
/*follow*/
-(id)getFollowingUserList:(NSDictionary*)param;
-(id)getFollowedUserList:(NSDictionary*)param;
/*memos*/
-(id)getRecommendMemos:(NSDictionary*)param;
-(id)getLatestMemos:(NSDictionary*)param;
-(id)getFollowUsersMemos:(NSDictionary*)param;

-(id)getPostMemos:(NSDictionary*)param;
-(id)getFavMemos:(NSDictionary*)param;
-(id)getFavorMemoUsers:(NSDictionary*)param;
-(id)getMemoDetail:(NSDictionary*)param;
-(id)doFavorMemo:(NSDictionary*)param;
-(id)unDoFavorMemo:(NSDictionary*)param;
/*comment*/
-(id)getMemoComments:(NSDictionary*)param;
-(id)addMemoComment:(NSDictionary*)param;
-(id)addCommentReply:(NSDictionary*)param;
/*msg*/
-(id)getNewMSGNotify:(NSDictionary*)param;
-(id)getMessageList:(NSDictionary*)param;
-(id)clearMSGNotify:(NSDictionary*)param;
-(id)checkNewVersion:(NSDictionary*)param;
@end
