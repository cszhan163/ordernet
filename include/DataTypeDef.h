//
//  DataTypeDef.h
//  NEFlyTicket
//
//  Created by cszhan on 1/12/11.
//  Copyright 2011 Netease(hangzhou) Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 * request kind
 */
typedef enum NTClientType{
	NTC_UNKNOW = -1,
	NTC_LOGIN = 0,
	NTC_REGIST,
	NTC_TSEARCH,
	NTC_TBOOK,
	NTC_TPAYBILL,
	
	NTC_USERINFOR,
	NTC_PASSINFOR,
	NTC_CITYDATA,
	NTC_RODOMCODE,
	//for train
	NTC_GETSESSION,
	NTC_SUBORDER,
	NTC_SUBORDERII,
	//for pay
	NTC_STARTPAY,
	//for pay later
	NTC_LATERPAY,
	//for bank
	NTC_BANKCHOOSE,
	NTC_BANKEPAY,
	NTC_BANKEPAY_I,
	NTC_BANKEPAY_II,
	NTC_EPAY_II,
	
	//for order
	NTC_ORDER_NO_READ,
	
	//for order
	NTC_PASSLIST,
}NTClientType;
/*
 * for book
 */
typedef enum NETicketBookStat{
	NETicketBook_NOPAY = 0,
	NETicketBook_PAID,
	NETicketBook_OK,
	NETicketBook_FAILD,
	NETicketBook_INVALID,
}NETicketBookStat;
/*
 * for person infor
 */
typedef enum IDCARDTYPE{
	ID_CHINAIDCARD,
	ID_PASSPORT,
	ID_ARMCARD,
	ID_OHTHRE,
}IDCARDTYPE;
typedef enum PASSENGERTYPE{
	AUDLT,
	CHILD,
}PASSENGERTYPE;
/*
 *for data source type
 */
typedef enum DataSouceType{
	DS_TicketsSearch,
	DS_MyBooks,
	DS_Passenge,
	DS_PerSonInfo,
	DS_CityInfo,
	DS_UnKnow,
}DataSouceType;
/*
 *for data source status
 */
typedef enum DataSouceStatus{
	DS_Loading,
	DS_DataOk,
	DS_DataFailed,
}DataSouceStatus;
/*
 *
 */
typedef enum paserDataType{
	PASER_STRING,
	PASER_DATA,
}PaserDataType;


/**
 */
typedef	enum LOGIN_STATUS{
	LOGIN_OK,
	LOGIN_CLIENT_ERROR,
	LOGIN_SERVER_ERROR,
	LOGIN_ERROR_UNKNOW,
}LOGIN_STATUS;

typedef enum {
	LS_Unknow,
	LS_LoginOK,
	LS_LoginError
}LoginStatus;

