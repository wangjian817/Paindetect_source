//
//  DataManager.m
//  Paindetect
//
//  Created by jegan selvaraj on 4/17/12.
//  Copyright (c) 2012 blisslogix. All rights reserved.
//

#import "DataManager.h"
#import "SBJSON.h"
#import "AppDelegate.h"
#import "Reachability.h"

@implementation DataManager

@synthesize currentPageIndex;
@synthesize resultDict;
@synthesize dictvalue;
@synthesize innerDictArray;

static DataManager *manager = nil;

+(DataManager *)sharedmanager
{
    @synchronized ([DataManager class])
    {
        if (!manager) {
            [[self alloc] init];
        }
        return manager;
    }
    return nil;
}

-(id)init
{
    manager = [super init]; 
    currentPageIndex = 0;
    return manager;
    
}

-(void)executeRequest
{
    NSString *filepath = [[NSBundle mainBundle] pathForResource:@"PainQuestion" ofType:@"json"];
    NSLog(@"file path is %@",filepath);
    NSString *fileContent = [[NSString alloc] initWithContentsOfFile:filepath encoding:NSUTF8StringEncoding error:NULL];
    NSLog(@"\n Content of file: %@", fileContent);
    NSInteger lenth=[fileContent length];
	NSLog(@"length: %d",lenth); 
    if (!fileContent) {
        NSLog( @"File Could not be read");
    }
    else {
	SBJSON *parser=[[SBJSON alloc] init];
    
    NSError *error; 
	
	NSDictionary *dict=(NSDictionary *)[parser objectWithString:fileContent error:&error];
	NSLog(@"dictionary value: %@", dict);
   // NSLog(@"error is %@",error);
    
    AppDelegate  *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.questions = [[NSMutableArray alloc] initWithArray:[dict valueForKey:@"Questions"]];
        
        NSLog(@"%@Appdelegate",appDelegate.questions);
    }
}

//-(void)loadNextView:(UIViewController *)controller
//{
//    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
//    NSMutableDictionary *localquestiondict = [appdelegate.questions objectAtIndex:currentPageIndex];
//    NSString *questiontype = [localquestiondict valueForKey:@"QuestionType"];
//    if ([questiontype isEqualToString:@"YesorNo"]) {
//        YesornoView *yesornoview = [[YesornoView alloc] initWithNibName:@"YesornoView" bundle:nil];
//        yesornoview.questiondict = localquestiondict;
//        [controller.navigationController pushViewController:yesornoview animated:YES];
//    }
//    else if ([questiontype isEqualToString:@"slider"])
//    {
//        sliderView *sliderview = [[sliderView alloc] initWithNibName:@"sliderView" bundle:nil];
//        sliderview.questiondict = localquestiondict;
//        [controller.navigationController pushViewController:sliderview animated:YES];
//    }
//    else if ([questiontype isEqualToString:@"optionwithpic"])
//    {
//        OptionwithpicView *optionwithpicview = [[OptionwithpicView alloc] initWithNibName:@"optionwithpicView" bundle:nil];
//        optionwithpicview.questiondict = localquestiondict;
//        [controller.navigationController pushViewController:optionwithpicview animated:YES];
//    }
//    else if ([questiontype isEqualToString:@"optionwithoutpic"])
//    {
//        OptionwithoutpicView *optionwithoutpicview = [[OptionwithoutpicView alloc]initWithNibName:@"OptionwithoutpicView" bundle:nil];
//        optionwithoutpicview.questiondict = localquestiondict;
//        [controller.navigationController pushViewController:optionwithoutpicview animated:YES];
//    }
//    self.currentPageIndex ++;
//}
//
//-(void)viewControllerforview:(UIViewController *)controller
//{
//   // [controller.navigationController popViewControllerAnimated:YES];
//    self.currentPageIndex --;
//}

//-(NSMutableDictionary *)requestservertopushdata:(NSString *)urlvalue withDictionary:(NSDictionary *)dict
//{
//    NSString *jsonre = [dict JSONRepresentation];
//}

-(void)requestWithUrl:(NSURL *)url WithJsonData:(NSData *)jsonData
{
    if(([[Reachability reachabilityForInternetConnection] currentReachabilityStatus]==ReachableViaWiFi)||([[Reachability reachabilityForInternetConnection] currentReachabilityStatus]==ReachableViaWWAN))
	{	
        NSURLResponse *response;
        NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:url];
        [urlRequest setHTTPMethod:@"POST"];
        [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [urlRequest setHTTPBody:jsonData];
        
        NSData *resultdata = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:nil];
        NSString *resultstring = [[[NSString alloc] initWithData:resultdata encoding:NSUTF8StringEncoding] autorelease];
        NSLog(@"resulted String: %@",resultstring);
        
        SBJSON *parse = [[SBJSON alloc] init];
        self.resultDict = [[NSMutableDictionary alloc] initWithDictionary:[parse objectWithString:resultstring]];
        NSLog(@"ResultedDictionary is %@",self.resultDict);
        
        [urlRequest release];
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"网络连接错误" message:@"请检查你的网络连接" delegate:self cancelButtonTitle:@"重试" otherButtonTitles:nil,nil];
		[alert show];
		[alert release];
    }

}
 /*
-(BOOL)executeRequestWithType:(REQUESTTYPE)type andDictionary:(NSMutableDictionary *)dictionary
{
    NSURL *url = [self getURLForType:type];
}

-(NSURL *)getURLForType:(REQUESTTYPE )type
{
    NSString *rooturl = @"http://74.124.24.65/pdm/PainDetectAppservice.svc/";
    NSString *urlString = [NSString stringWithString:rooturl];
    if (type == getActivationcode) {
        urlString = [urlString stringByAppendingString:@"getActivationcode"];
    }
    else if (type == ActivationcodeValied) {
        urlString = [urlString stringByAppendingString:@"ActivationcodeValied"];
    }
    else if (type == AddPatientdetailsInDB) {
        urlString = [urlString stringByAppendingString:@"AddPatientdetailsInDB"];
    }
    else if (type == AddBodyMasterInDB){
        urlString = [urlString stringByAppendingString:@"AddBodyMasterInDB"];
    }
    else if (type == AddPatientPainDetailsInDB) {
        urlString = [urlString stringByAppendingString:@"AddPatientPainDetailsInDB"];
    }
    else if (type == AddpatientQusAnsDetailsInDB) {
        urlString = [urlString stringByAppendingString:@"AddpatientQusAnsDetailsInDB"];
    }
    
}
*/

+(NSMutableDictionary *)getDictionaryDataForActivationCode:(NSString *)activationcode
{
    NSMutableDictionary *paramDictionary = [NSMutableDictionary dictionary];
    [paramDictionary setObject:activationcode forKey:@"getActivationcode"];
    return paramDictionary;
}

//+(NSMutableDictionary *)getDictionaryDataForPatientDetails:()


@end
