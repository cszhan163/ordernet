//
//  NERequest.h
//  NEFlyTicket
//
//  Created by cszhan on 12/21/10.
//  Copyright 2010 Netease(hangzhou) Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum RSDataType{
	JSON,
	XML,
	TXT,
	LRCTEXT,
	RAW,
	HTTPTXT,
	IMAGDATA,
	GBKDATA,
    XML_JSON_MIX,
	
}RSDataType;
@protocol NERequestDelegate;
@class NEXMLParser; 
@interface NERequest : NSObject {
	NSString*				_url;
	NSString*				_httpMethod;
	NSMutableDictionary*		_params;
	NSURLConnection*		_connection;
	NSMutableData*			_responseText;
	RSDataType				_rsTxType;
	BOOL						_isNeedCookie;
	BOOL					_isNeedLogin;
    BOOL                    hasPostData;
	NSString				*_referer;
	NSString*			_cookie;
    NEXMLParser *xmlParser;
	id<NERequestDelegate>     _delegate;
}
@property(nonatomic,assign) id<NERequestDelegate> delegate;
/**
 * The URL which will be contacted to execute the request.
 */
@property(nonatomic,copy) NSString* url;

/**
 * The API method which will be called.
 */
@property(nonatomic,copy) NSString* httpMethod;

/**
 * The dictionary of parameters to pass to the method.
 *
 * These values in the dictionary will be converted to strings using the
 * standard Objective-C object-to-string conversion facilities.
 */
@property(nonatomic,retain) NSMutableDictionary* params;


@property(nonatomic,assign) NSURLConnection*  connection;

@property(nonatomic,assign) NSMutableData* responseText;

@property(nonatomic,assign) RSDataType rsTxType;

@property(nonatomic,assign) BOOL isNeedCookie;
@property(nonatomic,assign) BOOL cacheControl;
@property(nonatomic,assign) BOOL hasPostData;
@property(nonatomic,assign) BOOL isNeedParser;
@property(nonatomic,assign) NSString* cookie;
@property(nonatomic,retain) NSString *referer;
@property(nonatomic,retain) NSMutableURLRequest *_request;

+ (NSString*)serializeURL:(NSString *)baseUrl
                   params:(NSDictionary *)params;

+ (NSString*)serializeURL:(NSString *)baseUrl
                   params:(NSDictionary *)params
               httpMethod:(NSString *)httpMethod;

+ (NERequest*)getRequestWithParams:(NSMutableDictionary *) params
                        httpMethod:(NSString *) httpMethod
                          delegate:(id<NERequestDelegate>)delegate
                        requestURL:(NSString *) url;
+(NSMutableData*)serializeParamsAsPostData:(NSDictionary*)params;
- (BOOL) loading;

-(void)sendAsynRequest:(BOOL)isPostData;
-(void)sendSynRequest:(BOOL)isPostData;

- (void) connect:(BOOL)hasData;
//- (void) setCookie:(NSDictionary*)cookie;
@end
@protocol NERequestDelegate<NSObject>
@optional

/**
 * Called just before the request is sent to the server.
 */
- (void)requestLoading:(NERequest *)request;

/**
 * Called when the server responds and begins to send back data.
 */
- (void)request:(NERequest *)request didReceiveResponse:(NSURLResponse *)response;

/**
 * Called when an error prevents the request from completing successfully.
 */
- (void)request:(NERequest *)request didFailWithError:(NSError *)error;

/**
 * Called when a request returns and its response has been parsed into an object.
 *
 * The resulting object may be a dictionary, an array, a string, or a number, depending
 * on thee format of the API response.
 */
- (void)request:(NERequest *)request didLoad:(id)result;

/**
 * Called when a request returns a response.
 *
 * The result object is the raw response from the server of type NSData
 */
- (void)request:(NERequest *)request didLoadRawResponse:(NSData *)data;

@end