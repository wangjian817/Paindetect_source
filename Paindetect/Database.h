//
//  Database.h
//  Paindetect
//
//  Created by Jegan notebook3 Selvaraja on 24/04/12.
//  Copyright (c) 2012 blisslogix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "DataManagerr.h"

#define k_Center @"Center"
#define k_Subject_Id @"SubjectId"
#define k_DateOfVisit @"DateOfVisit"
#define k_PatientName @"PatientName"
#define k_Nationality @"Nationality"
#define k_Occupation @"Occupation"
#define k_age @"Age"
#define k_ClinicalRecord @"ClinicalRecord"
#define k_MedicationTakenNow @"MedicationTakenNow"
#define k_OtherCondition @"OtherCondition"

#define k_painid @"Painid"
#define k_patientid @"Patientid"
#define k_bodydetails @"bodyDetails"

#define k_question2 @"Question2"
#define k_question3 @"Question3"
#define k_question4 @"Question4"
#define k_question5 @"Question5"
#define k_question6 @"Question6"
#define k_question7 @"Question7"
#define k_question8 @"Question8"
#define k_question9 @"Question9"
#define k_question10 @"Question10"
#define k_question11 @"Question11"
#define k_question12 @"Question12"
#define k_question13 @"Question13"

#define k_ActivationId @"ActivitationID"
#define k_ActivationCode @"ActivitationCode"

#define k_Answers @"Answers"


@interface Database : NSObject

@property (nonatomic,retain) NSString *databasePath;


-(id)initWithSqliteOpen;
-(id)initWithSqliteClose;
-(void)getDatabasePath;
-(void)createDatabase;
-(void)updateUploadFlag:(NSString *)strpid;
-(NSString *)insertPDData:(NSMutableDictionary *)pdDict; 
-(void)insertPatientHistory:(NSMutableDictionary *)patientDetailDict; 
-(void)insertbodydetails:(NSMutableDictionary *)bodydetailsdict;
-(void)insertActivationcode:(NSMutableArray *)activationcodeArray;
-(void)updateActivationcode:(NSMutableArray *)activationcodeArray;
-(void)updatebodydetails:(NSMutableDictionary *)bodydetailsdict;
-(void)insertanswerdetails:(NSMutableDictionary *)answerdetailsdict;
-(void)deleteActivationcode;

-(void)checkActivationCode:(NSString *)valueCode;

-(BOOL)getActivationCodde:(NSString *)getVal;

-(NSString *)getPatientStr;
-(NSString *)getPainIDStr;
-(NSMutableArray *)getRerutrDataBaseValueInPatientHistory;
-(NSMutableArray *)getRerutrDataBaseValueInBodyDetails;
-(NSMutableArray *)getRerutrDataBaseValueInAnswerDetails;
-(NSMutableArray *)getPreScore:(NSString *)strSubID;
-(NSMutableArray *)getAllRecord;

-(void)deletePatientHistory;
-(void)deleteBodyDetails;
-(void)deleteAnswerDetails;


@end
