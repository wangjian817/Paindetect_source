//
//  AppDelegate.m
//  Paindetect
//
//  Created by jegan selvaraj on 4/9/12.
//  Copyright (c) 2012 blisslogix. All rights reserved.
//

#import "AppDelegate.h"
#import "ActivationView.h"
#import "DataManager.h"

#import "PatientHistoryView.h"

#import "LoadViewController_iPad.h"

#import "Database.h"
#import "Reachability.h"

#import "AllListView.h"

@implementation AppDelegate

@synthesize window;
@synthesize navigationcontroller;
@synthesize questions;

@synthesize dataBase;

- (void)dealloc
{
    [window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    
    Database *dataa = [[Database alloc] init];
    [dataa createDatabase];
    
    if(([[Reachability reachabilityForInternetConnection] currentReachabilityStatus]==ReachableViaWiFi)||([[Reachability reachabilityForInternetConnection] currentReachabilityStatus]==ReachableViaWWAN)) {
        //[self performSelectorOnMainThread:@selector(apiValueCalling) withObject:nil waitUntilDone:YES];
        [self performSelectorOnMainThread:@selector(oflineDataBaseCalling) withObject:nil waitUntilDone:YES];
    }
    else {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"ActivitationCode" ofType:@"txt"];
        NSMutableArray *locArr  = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
//        [self insertDataBaseValue:locArr];
        NSLog(@"LOCAL ACTIVATION CODE  %@",locArr);
    }
    
    /*Database *dataBase1 = [[Database alloc] init];
    [dataBase1 initWithSqliteOpen];
    //[dataBase getPreScore:[locDict valueForKey:k_Subject_Id]];
    [dataBase1 getPreScore:@"2"];
    [dataBase1 initWithSqliteClose];*/
    
    DataManager *datamanager = [[DataManager alloc] init]; 
    [datamanager executeRequest];
    
//    self.navigationcontroller.navigationBar.tintColor = [UIColor colorWithRed:(152.0/255.0) green:(194.0/255.0) blue:(104.0/255.0) alpha:1.0];
      self.navigationcontroller.navigationBar.tintColor = [UIColor colorWithRed:(106.0/255.0) green:(106.0/255.0) blue:(106.0/255.0) alpha:1.0];
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:k_ISActivationBOOL] boolValue] == YES) {
         /*PatientHistoryView *patientHistory = [[PatientHistoryView alloc] initWithNibName:@"PatientHistoryView" bundle:nil];
        self.navigationcontroller = [[UINavigationController alloc] initWithRootViewController:patientHistory];     wj*/
        
        LoadViewController_iPad *MyWebView = [[LoadViewController_iPad alloc] initWithNibName:@"LoadView_iPad" bundle:nil];
        
        self.navigationcontroller = [[UINavigationController alloc] initWithRootViewController:MyWebView];
        
        //AllListView *listview = [[AllListView alloc] initWithNibName:@"AllListView" bundle:nil];
        
        //self.navigationcontroller = [[UINavigationController alloc] initWithRootViewController:listview];
    }
    else {
        ActivationView *activationview = [[ActivationView alloc]initWithNibName:@"ActivationView" bundle:nil];
        self.navigationcontroller = [[UINavigationController alloc] initWithRootViewController:activationview];
    }
    
    [self.window addSubview:navigationcontroller.view];
    [self.window makeKeyAndVisible];
    return YES;
}
-(void)apiValueCalling {
    DataManagerr *dataMmana = [[DataManagerr alloc] initWithDelegate:self];
    [dataMmana executeRequestWithType:getActivationcode andDictionary:[NSMutableDictionary dictionary]];
}

-(void)oflineDataBaseCalling {
    dataBase = [[Database alloc] init];
    [dataBase initWithSqliteOpen];
    [self callApiForOflinePatientHistory:[dataBase getRerutrDataBaseValueInPatientHistory]];
    //[self callApiForOflineBodyValue:[dataBase getRerutrDataBaseValueInBodyDetails]];
    //[self callApiForOflineAnswerValue:[dataBase getRerutrDataBaseValueInAnswerDetails]];

    //[dataBase deleteBodyDetails];
    //[dataBase deletePatientHistory];
    //[dataBase deleteAnswerDetails];
    [dataBase initWithSqliteClose];
}
-(void)callApiForOflinePatientHistory:(NSMutableArray *)receiveArray {
    for (int i = 0; i < [receiveArray count]; i++) {
        NSMutableDictionary *revDict = [receiveArray objectAtIndex:i];
        DataManagerr *dataMana = [[DataManagerr alloc] initWithDelegate:self];
        //[dataMana executeRequestWithType:AddPatientdetailsInDB andDictionary:revDict];
        [dataMana executeRequestWithType:UploadData andDictionary:revDict];
    }
}
-(void)callApiForOflineBodyValue:(NSMutableArray *)receiveArray {
    for (int i = 0; i < [receiveArray count]; i++) {
        NSMutableDictionary *revDict = [receiveArray objectAtIndex:i];
        DataManagerr *dataMana = [[DataManagerr alloc] initWithDelegate:self];
        [dataMana executeRequestWithType:AddPatientPainDetailsInDB andDictionary:revDict];
    }
}
-(void)callApiForOflineAnswerValue:(NSMutableArray *)receiveArray {
    for (int i = 0; i < [receiveArray count]; i++) {
        NSMutableDictionary *revDict = [receiveArray objectAtIndex:i];
        DataManagerr *dataMana = [[DataManagerr alloc] initWithDelegate:self];
        [dataMana executeRequestWithType:AddpatientQusAnsDetailsInDB andDictionary:revDict];
    }
}

-(void)insertDataBaseValue:(NSMutableArray *)getArrayValue {
    dataBase = [[Database alloc] init];
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:k_ISActivationBOOL] boolValue] == YES) {
        [dataBase initWithSqliteOpen];
        [dataBase deleteActivationcode];
        [dataBase insertActivationcode:getArrayValue];
        [dataBase initWithSqliteClose];
    }
    else {
        [dataBase initWithSqliteOpen];
        [dataBase insertActivationcode:getArrayValue];
        [dataBase initWithSqliteClose];
    }
}

-(void)dataManagerDidFinishLoading:(DataManagerr *)dMange {
    if (dMange) {
        //NSString *locSt = [[NSString alloc] init];
        
        [self insertDataBaseValue:[dMange.resultedDictionary objectForKey:@"getActivationcodeResult"]];
        
        [[NSUserDefaults standardUserDefaults] setValue:[dMange.resultedDictionary objectForKey:@"AddpatientQusAnsDetailsInDBResult"] forKey:k_QusAnsDetailResultOutput];
        
         [[NSUserDefaults standardUserDefaults] setValue:[dMange.resultedDictionary valueForKey:@"AddPatientPainDetailsInDBResult"] forKey:k_PainDetID];
        
        NSString *strpid = [[NSString alloc] init];
        strpid = [[[dMange.resultedDictionary valueForKey:@"UploadDataResult"] objectAtIndex:0] valueForKey:@"pid"];
        if(strpid==nil){
            //[[[UIAlertView alloc] initWithTitle:nil message:@"数据上传失败" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil] show];
        }else{
            Database *db = [[Database alloc] init];
            [db initWithSqliteOpen];
            [db updateUploadFlag:(NSString *)strpid];
            [db initWithSqliteClose];
        }

        /*NSString *dataBaseResult = [NSString stringWithFormat:@"%@",[dMange.resultedDictionary objectForKey:@"UploadDataResult"]];
        if ([dataBaseResult isEqualToString:@"(null)"]) {
            NSLog(@"Result No");
            locSt = @"Patient History is not added Successfully";
//            [self alertViewMethod:locSt];
        }
        else {
            [[NSUserDefaults standardUserDefaults] setValue:dataBaseResult forKey:@"pid"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }*/
    }
}

-(void)alertViewMethod:(NSString *)alertStr {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:alertStr delegate:self cancelButtonTitle:nil otherButtonTitles:@"Try Again", nil];
    [alert show];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
    //NSLog(@"applicationDidEnterBackground");
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
    //NSLog(@"applicationWillEnterForeground");
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
    //NSLog(@"applicationDidBecomeActive");
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
 