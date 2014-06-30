                    
//
//  DataManagerr.m
//  Paindetect
//
//  Created by Jegan notebook3 Selvaraja on 23/04/12.
//  Copyright (c) 2012 blisslogix. All rights reserved.
//

#import "DataManagerr.h"
#import "SBJSON.h"
#import "Reachability.h"

@implementation DataManagerr
@synthesize resultedDictionary,delegate,dictValue,innerDictArray;
@synthesize mutableData,urlRequest;

@synthesize valuePassingDict,totalValueDict;


-(id)initWithDelegate:(id)sender
{
    if((self=[super init]))
    {
        self.delegate=sender;
    }
    return self;
}

-(void)requestWithUrl:(NSURL *)url WithJsonData:(NSData *)jsonData {
    if(([[Reachability reachabilityForInternetConnection] currentReachabilityStatus]==ReachableViaWiFi)||([[Reachability reachabilityForInternetConnection] currentReachabilityStatus]==ReachableViaWWAN))
	{
    urlRequest = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [urlRequest setHTTPMethod:@"POST"];
    //[urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [urlRequest setHTTPBody:jsonData];
    [NSURLConnection sendAsynchronousRequest:urlRequest  queue:[NSOperationQueue mainQueue] completionHandler:nil];
    [NSURLConnection connectionWithRequest:urlRequest delegate:self];
    }
    else {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"网络连接错误" message:@"请检查您的网络连接" delegate:self cancelButtonTitle:@"重试" otherButtonTitles:nil,nil];
        [alert show];
        
    }
}
-(BOOL)executeRequestWithType:(REQUESTTYPE)type andDictionary:(NSMutableDictionary *)dictionary {
    NSURL *url = [self getURLForType:type];
	NSData *jsonData = [self getJSONDataForType:type withDictionary:dictionary];
	[self requestWithUrl:url WithJsonData:jsonData];
	if (self.resultedDictionary == nil) {
		return NO;
	}

//    if (self.innerDictArray == nil) {
//		return NO;
//	}
	return YES;
}
-(NSURL *)getURLForType:(REQUESTTYPE )type {
    
    NSString *rootUrl= @"http://74.124.24.65/pdm/PainDetectAppservice.svc/";  //Working  http://74.124.24.65/pdm/PainDetectAppservice.svc/AddpatientQusAnsDetailsInDB
   //rootUrl= @"http://202.142.17.39/pdserver/";
    rootUrl= @"http://i519.org/pd/";
    NSString *urlString=[NSString stringWithString:rootUrl];
    if (type == getActivationcode) {
        //urlString=[urlString stringByAppendingString:@"getActivationcode"];
        urlString=[urlString stringByAppendingString:@"getActivationcode.asp"];
    }
    else if (type == AddPatientdetailsInDB) {
        //urlString=[urlString stringByAppendingString:@"AddPatientdetailsInDB"];
        urlString=[urlString stringByAppendingString:@"AddPatientdetailsInDB.asp"];
    }
    else if (type == ActivationcodeValied) {
        //urlString=[urlString stringByAppendingString:@"ActivationcodeValied"];
        urlString=[urlString stringByAppendingString:@"ActivationcodeValied.asp"];
    }
    else if (type == AddBodyMasterInDB) {
        urlString=[urlString stringByAppendingString:@"AddBodyMasterInDB"];
    }
    else if (type == AddPatientPainDetailsInDB) {
        urlString=[urlString stringByAppendingString:@"AddPatientPainDetailsInDB"];
    }
    else if (type == AddpatientQusAnsDetailsInDB) {
        urlString=[urlString stringByAppendingString:@"AddpatientQusAnsDetailsInDB"];
    }
    else if (type == GetPatientScoreDetails) {
        urlString = [urlString stringByAppendingString:@"GetPatientScores"];
    }
    else if (type == UploadData){
        urlString = [urlString stringByAppendingString:@"UploadData.asp"];
    }
    NSLog(@"URL  %@",urlString);
    return [NSURL URLWithString:urlString];
}
-(NSData *)getJSONDataForType:(REQUESTTYPE)type withDictionary:(NSMutableDictionary *)dictionary {
    NSString *jsonDataString;
	if (type == getActivationcode) {
        jsonDataString=[NSString stringWithFormat:@"pd={\"%@\"}",
                        [dictionary valueForKey:k_getActivationcode]];
        NSLog(@"GetActivationcode = %@",jsonDataString);
	}
    else if (type == UploadData){
        jsonDataString=[NSString stringWithFormat:@"pd=%@;;%@;;%@;;%@;;%@;;%@;;%@;;%@;;%@;;%@;;%@;;%@;;%@;;%@;;%@;;%@;;%@;;%@;;%@;;%@;;%@;;%@;;%@;;%@;;%@;;%@",
                        [dictionary valueForKey:k_saveActivationcode],
                        [dictionary valueForKey:@"pid"],
                        [dictionary valueForKey:k_Center],
                        [dictionary valueForKey:k_Subject_Id],
                        [dictionary valueForKey:k_DateOfVisit],
                        [dictionary valueForKey:k_PatientName],
                        [dictionary valueForKey:k_Nationality],
                        [dictionary valueForKey:k_Occupation],
                        [dictionary valueForKey:k_age],
                        [dictionary valueForKey:k_ClinicalRecord],
                        [dictionary valueForKey:k_MedicationTakenNow],
                        [dictionary valueForKey:k_OtherCondition],
                        [dictionary valueForKey:k_bodydetails],
                        [dictionary valueForKey:@"q2"],
                        [dictionary valueForKey:@"q3"],
                        [dictionary valueForKey:@"q4"],
                        [dictionary valueForKey:@"q5"],
                        [dictionary valueForKey:@"q6"],
                        [dictionary valueForKey:@"q7"],
                        [dictionary valueForKey:@"q8"],
                        [dictionary valueForKey:@"q9"],
                        [dictionary valueForKey:@"q10"],
                        [dictionary valueForKey:@"q11"],
                        [dictionary valueForKey:@"q12"],
                        [dictionary valueForKey:@"q13"],
                        [dictionary valueForKey:@"score"]];
        NSLog(@"UploadData = %@",jsonDataString);

    }
    else if (type == AddPatientdetailsInDB) {
        
        jsonDataString=[NSString stringWithFormat:@"pd={\"ActivationCode\":\"%@\" , \"PatientName\" : \"%@\" , \"Center\" : \"%@\" , \"subjectID\" : \"%@\", \"DateofVisit\" : \"%@\" , \"Nationlity\" : \"%@\" , \"Occupation\" : \"%@\" , \"Age\" : %@ , \"ClinicalRecords\" : \"%@\" , \"MedicationTakenNow\" : \"%@\" , \"OtherCondition\" : \"%@\"}",
                        [[NSUserDefaults standardUserDefaults] valueForKey:k_saveActivationcode],
                        [dictionary valueForKey:k_PatientName],
                        [dictionary valueForKey:k_Center],
                        [dictionary valueForKey:k_Subject_Id],
                        [dictionary valueForKey:k_DateOfVisit],
                        [dictionary valueForKey:k_Nationality],
                        [dictionary valueForKey:k_Occupation],
                        [dictionary valueForKey:k_age],
                        [dictionary valueForKey:k_ClinicalRecord],
                        [dictionary valueForKey:k_MedicationTakenNow],
                        [dictionary valueForKey:k_OtherCondition]];
        NSLog(@"AddPatientdetailsInDB = %@",jsonDataString);
    }
    else if (type == ActivationcodeValied) {
        jsonDataString=[NSString stringWithFormat:@"pd={ \"ActivationCode\" : \"%@\"}",
                        [dictionary valueForKey:k_getActivationcode]];
        NSLog(@"GetActivationcode = %@",jsonDataString);
    }
    else if (type == AddBodyMasterInDB) {
        jsonDataString=[NSString stringWithFormat:@"{ \"BodyName\" : \"%@\"}",
                        [dictionary valueForKey:k_SelectedBodyValue]];
        NSLog(@"AddBodyMasterInDB = %@",jsonDataString);
    }
    else if (type == AddPatientPainDetailsInDB) {
        NSMutableArray *locArr = [dictionary valueForKey:k_SelectedBodyValue];
        if ([locArr count] > 0) {
            NSString *resultStr = [[NSString alloc] init];
            for(int i = 0; i< [locArr count]; i++){
                resultStr = [resultStr stringByAppendingString:[NSString stringWithFormat:@"%@,",[locArr objectAtIndex:i]]];
            }
            resultStr = [resultStr substringToIndex:[resultStr length] - 1];
            NSLog(@"%@  str",resultStr);
            jsonDataString=[NSString stringWithFormat:@"{ \"PatientID\" : %@ , \"BodyID\" : \"%@\"}",
                            [[NSUserDefaults standardUserDefaults] valueForKey:k_PatientID],
                            resultStr];
        }
        else {
            jsonDataString=[NSString stringWithFormat:@"{ \"PatientID\" : %@ , \"BodyID\" : \"%@\"}",
                            [[NSUserDefaults standardUserDefaults] valueForKey:k_PatientID],
                            [dictionary valueForKey:k_oflineBodyAnswer]];
        }
        NSLog(@"AddPatientPainDetailsInDB = %@",jsonDataString);
    }
    else if (type == AddpatientQusAnsDetailsInDB) {
        NSLog(@"%@",[dictionary valueForKey:k_QusAnsDetailResultDictInput]);
        NSMutableArray *locArr1 = [dictionary valueForKey:k_QusAnsDetailResultDictInput];
        if ([locArr1 count] == 0) {
            jsonDataString=[NSString stringWithFormat:@"{ \"PatientQAId\" : 0, \"PainDetID\" : %@, \"PatientID\" : %@ , \"QuestionNo\" : \"2,3,4,5,6,7,8,9,10,11,12,13\" , \"AnswerValue\" : \"%@\" }",
                            [[NSUserDefaults standardUserDefaults] valueForKey:k_PainDetID],
                            [[NSUserDefaults standardUserDefaults] valueForKey:k_PatientID],
                            [dictionary objectForKey:k_oflineQusAnsAnswer]];
        }
        else {
        NSString *resultStr1 = [[NSString alloc] init];
        for(int i = 0; i< [locArr1 count]; i++){
            resultStr1 = [resultStr1 stringByAppendingString:[NSString stringWithFormat:@"%@,",[locArr1 objectAtIndex:i]]];
        }
        resultStr1 = [resultStr1 substringToIndex:[resultStr1 length] - 1];
        NSLog(@"%@  str",resultStr1);
        jsonDataString=[NSString stringWithFormat:@"{ \"PatientQAId\" : 0, \"PainDetID\" : %@, \"PatientID\" : %@ , \"QuestionNo\" : \"2,3,4,5,6,7,8,9,10,11,12,13\" , \"AnswerValue\" : \"%@\" }",
                        [[NSUserDefaults standardUserDefaults] valueForKey:k_PainDetID],
                        [[NSUserDefaults standardUserDefaults] valueForKey:k_PatientID],
                        resultStr1];
        NSLog(@"AddpatientQusAnsDetailsInDB = %@",jsonDataString);
        }
    }
    else if (type == GetPatientScoreDetails) {
        jsonDataString=[NSString stringWithFormat:@"{ \"PatientQANSId\" : \"%@,%@,%@,%@,%@,%@,%@,%@,%@\"}",
                        [[NSUserDefaults standardUserDefaults] valueForKey:k_QusAnsYesorNoResult],
                        [[NSUserDefaults standardUserDefaults] valueForKey:k_6QusAnsResult],
                        [[NSUserDefaults standardUserDefaults] valueForKey:k_7QusAnsResult],
                        [[NSUserDefaults standardUserDefaults] valueForKey:k_8QusAnsResult],
                        [[NSUserDefaults standardUserDefaults] valueForKey:k_9QusAnsResult],
                        [[NSUserDefaults standardUserDefaults] valueForKey:k_10QusAnsResult],
                        [[NSUserDefaults standardUserDefaults] valueForKey:k_11QusAnsResult],
                        [[NSUserDefaults standardUserDefaults] valueForKey:k_12QusAnsResult],
                        [[NSUserDefaults standardUserDefaults] valueForKey:k_13QusAnsResult]];
        NSLog(@"GetPatientScoreDetails  %@",jsonDataString);
    }
    
    NSData *jsonData=[jsonDataString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
	return jsonData;
}

#pragma mark - Connection Delegate
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    mutableData = [[NSMutableData alloc] initWithLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [mutableData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *resultString=[[NSString alloc]initWithData:mutableData encoding:NSUTF8StringEncoding];
    NSLog(@"%@  resultString",resultString);
    SBJSON *parse=[[SBJSON	alloc]init];
//    self.innerDictArray = [[NSMutableArray alloc] initWithArray:[parse objectWithString:resultString]];
    self.resultedDictionary=[[NSMutableDictionary alloc]initWithDictionary:[parse objectWithString:resultString]];
    [delegate dataManagerDidFinishLoading:self];
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Connection failed! Error - %@ %@",[error localizedDescription], [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
    NSLog(@"Connection FAILED !!%@",error.description);
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"服务器错误" message:@"请检查服务器" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"重试", nil];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
   if (buttonIndex == 1) {
       if(([[Reachability reachabilityForInternetConnection] currentReachabilityStatus]==ReachableViaWiFi)||([[Reachability reachabilityForInternetConnection] currentReachabilityStatus]==ReachableViaWWAN))
       {
           [NSURLConnection connectionWithRequest:urlRequest delegate:self];
           NSLog(@"YES");
       }
       else {
           UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"连接错误" message:@"请检查你的网络连接" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"重试",nil];
           [alert show];
           
       }
    }
}


@end
