//
//  AppDelegate.h
//  Paindetect
//
//  Created by jegan selvaraj on 4/9/12.
//  Copyright (c) 2012 blisslogix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManagerr.h"
#import "Database.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,DataManagerDelegate>
{
    UINavigationController *navigationcontroller;
}

@property (strong, nonatomic) UIWindow *window;
//@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) UINavigationController *navigationcontroller;
@property (nonatomic, retain) NSMutableArray *questions;
@property (nonatomic, retain) Database *dataBase;

-(void)apiValueCalling;
-(void)insertDataBaseValue:(NSMutableArray *)getArrayValue;
-(void)oflineDataBaseCalling;
-(void)callApiForOflinePatientHistory:(NSMutableArray *)receiveArray;
-(void)callApiForOflineBodyValue:(NSMutableArray *)receiveArray;
-(void)callApiForOflineAnswerValue:(NSMutableArray *)receiveArray;
-(void)alertViewMethod:(NSString *)alertStr;
@end
