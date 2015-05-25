//
//  BSTellTimerReflushDataProcotol.h
//  BSTell
//
//  Created by cszhan on 14-3-1.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BSTellTimerReflushDataProcotol<NSObject>
- (void)startReflushjTimer;
- (void)stopReflushTimer;
- (void)reflushData;
@end
