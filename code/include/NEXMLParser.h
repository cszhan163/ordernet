//
//  XMLParser.h
//  NEFlyTicket
//
//  Created by cszhan on 1/13/11.
//  Copyright 2011 Netease(hangzhou) Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
//@class NEXMLParser;
@protocol NEXMLParserDelegate<NSObject>
-(void)didEndParse:(id)result  withStatus:(BOOL)status withError:(NSError*)error;
@end
@interface NEXMLParser : NSObject<NSXMLParserDelegate>{
	NSXMLParser *xmlparserEngin;
	NSString	  *curParserTag;
	NSMutableDictionary *parserResult;
    NSMutableArray  *finaleResult;
	id<NEXMLParserDelegate> delegate;
    BOOL                isParserError;

}
@property(nonatomic,assign) id<NEXMLParserDelegate> delegate;
-(id)initWithParserData:(NSData *)data;
-(void)startParser;
@end
