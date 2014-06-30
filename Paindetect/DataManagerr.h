//
//  DataManagerr.h
//  Paindetect
//
//  Created by Jegan notebook3 Selvaraja on 23/04/12.
//  Copyright (c) 2012 blisslogix. All rights reserved.
//

#import <Foundation/Foundation.h>

//Activity Code
#define k_getActivationcode @"getActivationcode"
#define k_saveActivationcode @"saveActivationcode"

#define k_ISActivationBOOL @"ISActivationBOOL"

//Patient History  //Input

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
#define k_bodydetails @"bodyDetails"

//Output
#define k_PatientID @"k_PatientID"

//Body View  //Input
#define k_SelectedBodyValue @"SelectedBodyValue"

#define k_oflineBodyAnswer @"oflineBodyAnswer"

#define k_oflineQusAnsAnswer @"oflineQusAnsAnswer"


//Output
#define k_PainDetID @"PainDetID"

//YesorNo View  //Input
#define k_QusAnsDetailResultInput @"QusAnsDetailResultInput"
#define k_QusAnsDetailResultDictInput @"QusAnsDetailResultDictInput"
#define k_QusAnsDetailQuestionNumber @"QusAnsDetailQuestionNumber"

#define k_QusAnsYesorNoResult @"QusAnsYesorNoResult"
#define k_3QusAnsResult @"3QusAnsResult"
#define k_4QusAnsResult @"4QusAnsResult"
#define k_5QusAnsResult @"5QusAnsResult"
#define k_6QusAnsResult @"6QusAnsResult"
#define k_7QusAnsResult @"7QusAnsResult"
#define k_8QusAnsResult @"8QusAnsResult"
#define k_9QusAnsResult @"9QusAnsResult"
#define k_10QusAnsResult @"10QusAnsResult"
#define k_11QusAnsResult @"11QusAnsResult"
#define k_12QusAnsResult @"12QusAnsResult"
#define k_13QusAnsResult @"13QusAnsResult"

#define k_QusAnsDetailPatientQAIdResult @"QusAnsDetailPatientQAIdResult"

//Output
#define k_QusAnsDetailResultOutput @"QusAnsDetailResultOutput"

//OptionWithPicView  // Input

#define k_PatientHistoryValue @"PatientHistory"
#define k_painSelectedBodyValue @"SelectedPainValue"


@class DataManagerr;

@protocol DataManagerDelegate <NSObject>
-(void)dataManagerDidFinishLoading:(DataManagerr *)dMange;
@end

typedef enum {
    getActivationcode = 1,
    ActivationcodeValied,
    AddPatientdetailsInDB,
    AddBodyMasterInDB,
    AddPatientPainDetailsInDB,
    AddpatientQusAnsDetailsInDB,
    GetPatientScoreDetails,
    UploadData
}REQUESTTYPE;
@interface DataManagerr : NSObject <UIAlertViewDelegate>


@property (nonatomic, retain) NSMutableDictionary *resultedDictionary;
@property (nonatomic, retain) NSString *dictValue;
@property (nonatomic, retain) NSMutableArray *innerDictArray;
@property (nonatomic, retain) NSMutableURLRequest *urlRequest;
@property (nonatomic, retain) NSMutableData *mutableData;
@property (nonatomic, assign) id<DataManagerDelegate> delegate;

@property (nonatomic, retain) NSMutableDictionary *valuePassingDict;

-(void)requestWithUrl:(NSURL *)url WithJsonData:(NSData *)jsonData;
-(BOOL)executeRequestWithType:(REQUESTTYPE)type andDictionary:(NSMutableDictionary *)dictionary;
-(NSURL *)getURLForType:(REQUESTTYPE )type;
-(NSData *)getJSONDataForType:(REQUESTTYPE)type withDictionary:(NSMutableDictionary *)dictionary;

-(id)initWithDelegate:(id)sender;


@property (nonatomic, retain) NSDictionary *totalValueDict;
@end
