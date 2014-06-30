//
//  DataManager.h
//  Paindetect
//
//  Created by jegan selvaraj on 4/17/12.
//  Copyright (c) 2012 blisslogix. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    PgetActivationcode = 1,
    PActivationcodeValied,
    PAddPatientdetailsInDB,
    PAddBodyMasterInDB,
    PAddPatientPainDetailsInDB,
    PAddpatientQusAnsDetailsInDB
    
}PREQUESTTYPE;


@interface DataManager : NSObject
{
    NSInteger currentPageIndex;
    NSMutableDictionary *resultDict;
    NSString *dictvalue;
    NSMutableArray *innerDictArray;
}

@property (nonatomic, assign) NSInteger currentPageIndex;
@property (nonatomic, retain) NSMutableDictionary *resultDict;
@property (nonatomic, retain) NSString *dictvalue;
@property (nonatomic, retain) NSMutableArray *innerDictArray;


-(void)executeRequest;
+(DataManager *)sharedmanager;
//-(void)loadNextView:(UIViewController *)controller;
//-(void)viewControllerforview:(UIViewController *)controller; 

//-(NSMutableDictionary *)requestservertopushdata:(NSString *)urlvalue withDictionary:(NSDictionary *)dict;
//-(BOOL)executeRequestWithType:(REQUESTTYPE)type andDictionary:(NSMutableDictionary *)dictionary;
//-(NSURL *)getURLForType:(REQUESTTYPE )type;

//-(void)backButtonPressed:(UIViewController *)controller;

@end
