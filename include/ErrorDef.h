//
//  ErrorDef.h
//  NEFlyTicket
//
//  Created by cszhan on 1/12/11.
//  Copyright 2011 Netease(hangzhou) Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
error condition，查询条件有误
NO_FLIGHT，没有直飞航班
retry，重试
no data，查不到数据（可能是系统异常，或所有票已卖完等）
lost gocondition，session中保存的去程航班查询条件丢失
error gocondition，错误的去程航班查询条件
lost firstAirLine，去程航班信息查询失败
error backcondition，错误的回程查询条件
*/
/*
 * erro code for domain
 */
#define SERVER_DOMAIN_RESPOND	 @""

#define SERVER_ERROR_SCCD		-1001
#define SERVER_ERROR_NOFIGHT	-1002
#define SERVER_ERROR_RETRY		-1003
#define SERVER_ERROR_NODATA		-1004
#define SERVER_ERROR_SCGCD		-1005

/*
* error code for epay domain
 * 25.网易宝客户端登陆
 返回结果：
 100|2010122215MC01402508	 正常（100|sid）
 69	userName为空
 70	密码为空
 */
#define EPAY_ERR_DOMAIN	@"epayDomain"
#define EPAY_ERR_LOGIN_NAME	 -2001
#define EPAY_ERR_LOGIN_PASS	 -2002
