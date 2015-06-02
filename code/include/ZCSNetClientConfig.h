//
//  ZCSNetClientConfig.h
//  ZCSUIFrameWork
//
//  Created by cszhan on 12-8-29.
//
//

#ifndef ZCSUIFrameWork_ZCSNetClientConfig_h
#define ZCSUIFrameWork_ZCSNetClientConfig_h

/**
 * ZCS net work
 */
#define kZCSNetWorkStart  @"ZCSNetWorkStart"
/**
 * NSNotification object NSDictionary object
 */
#define kZCSNetWorkOK               @"ZCSNetWorkOk"
#define kZCSNetWorkReloadRequest    @"ZCSNetWorkReloadRequest"
#define kZCSNetWorkNeedReLogin      @"ZCSNetWorkNeedReLogin"
#define kZCSNetWorkServerFailed     @"ZCSNetWorkServerFailed"
#define kZCSNetWorkConnectionFailed @"ZCSNetWorkConnetionFailed"
#define kZCSNetWorkRespondFailed    @"ZCSNetWorkRespondFailed"
#define kZCSNetWorkRequestFailed    @"ZCSNetWorkRequestFailed"


#define kNetLoginRes        @"login"
#define kNetResignRes        @"register"




//#define USER_MODEL
#define ASI_ENGINE

// return data framework
#define kNEFYJsonKeyResult  @"ret"
#define kNEFYJsonResultOK   @"0"
#define kNEFYJsonData       @"info"

// request root
//#define kRequestApiRoot     @"http://www.51kamao.com/cardmore/index.php?controller=jsonapi&action="
#define  kRequestApiRoot                @"http://211.144.193.13:8082/WebServiceDriveRecord.asmx/"
#endif
