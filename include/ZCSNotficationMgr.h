//
//  ZCSNotficationMgr.h
//  MP3Player
//
//  Created by cszhan on 12-2-12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ZCSNotficationMgr : NSObject {

}
+(void)addObserver:(id)observer call:(SEL)selector msgName:(NSString*)msg;
+(void)addObserver:(id)observer call:(SEL)selector msgName:(NSString*)msg object:(id)obj;
+(void)postMSG:(NSString*)msg obj:(id)obj;
+(void)removeObserver:(id)target msgName:(NSString*)msg;
+(void)removeObserver:(id)target;
@end
