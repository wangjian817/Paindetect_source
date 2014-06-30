 //
//  QusAnsSecondPage.m
//  Paindetect
//
//  Created by Jegan notebook3 Selvaraja on 07/05/12.
//  Copyright (c) 2012 blisslogix. All rights reserved.
//

#import "QusAnsSecondPage.h"
#import "Reachability.h"

@implementation QusAnsSecondPage

@synthesize answerResultArraySecond;
@synthesize bg_image;
@synthesize lbl_totalScore;
@synthesize lbl_question,qusScrollView,appDelegate;

@synthesize lbl_age,lbl_qusAns2,lbl_qusAns3,lbl_qusAns4,lbl_qusAns5,lbl_qusAns7,lbl_qusAns8,lbl_qusAns9,lbl_qusAns10,lbl_qusAns11,lbl_qusAns12,lbl_qusAns13,lbl_meditation,lbl_occupation,lbl_dateOfVisit,lbl_nationality,lbl_patientName,lbl_qusAns6Image1,lbl_qusAns6Image2,lbl_qusAns6Image3,lbl_qusAns6Image4,lbl_clicnicalRecord,lbl_vd1,lbl_s1,lbl_vd2,lbl_s2,lbl_vd3,lbl_s3,lbl_vd4,lbl_s4,lbl_vd5,lbl_s5;

@synthesize selectedImgArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        answerResultArraySecond = [[NSMutableArray alloc] init];
        selectedImgArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    NSLog(@"answerResultArraySecond %@",answerResultArraySecond);
    NSInteger val = 0;
    for (int i = 0; i < [answerResultArraySecond count]; i++) {
        if ((i == 1) || (i == 2) || (i == 3)) {
            NSLog(@"YES %d", i); 
        } else {
            val = val + [[answerResultArraySecond objectAtIndex:i] intValue];
        }
    }
    lbl_totalScore.text = [NSString stringWithFormat:@"%d",val];
    
    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d",val] forKey:@"score"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [bg_image setBackgroundColor:[UIColor colorWithRed:(224.0/255.0) green:(224.0/255.0) blue:(224.0/255.0) alpha:1.0]];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:(106.0/255.0) green:(106.0/255.0) blue:(106.0/255.0) alpha:1.0];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回输入数据" style:UIBarButtonItemStyleBordered target:self action:@selector(moveHomeButton)];
    //self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"上一步" style:UIBarButtonItemStyleBordered target:self action:@selector(backButtonMove)];
    [self.view addSubview:qusScrollView];
    [qusScrollView setFrame:CGRectMake(40, 410, 690, 490)];
    [qusScrollView setContentSize:CGSizeMake(690, 1150)];
    [self ScrollViewData];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void) ScrollViewData {
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSMutableArray *locArray = [[NSMutableArray alloc] init];
    locArray = appDelegate.questions;
    CGFloat yPos = 20;
    lbl_question = [[UILabel alloc] initWithFrame:CGRectMake(10, yPos, 700, 50)];
  
    NSString *tolStr = [[NSString alloc] init];
    for (int i = 0; i < [locArray count]; i++) {
        [lbl_question setText:[NSString stringWithFormat:@"%@",[[locArray objectAtIndex:i] valueForKey:@"QuestionName"]]];
        [lbl_question setFrame:CGRectMake(10, yPos, 700, 50)];
        yPos += 50;
        tolStr = [tolStr stringByAppendingString:[[locArray objectAtIndex:i] valueForKey:@"QuestionName"]] ;
    }
//    [qusScrollView addSubview:lbl_question];
    
    
    NSMutableDictionary *locDict = [[NSMutableDictionary alloc] init];
    locDict = [[NSUserDefaults standardUserDefaults] valueForKey:k_PatientHistoryValue];
    
    NSLog(@"Loc Dict  %@",[[NSUserDefaults standardUserDefaults] valueForKey:k_PatientHistoryValue]);
    [lbl_patientName setText:[NSString stringWithFormat:@" ( %@ ) ",[locDict valueForKey:k_PatientName]]];
    [lbl_age setText:[NSString stringWithFormat:@" ( %@ ) ",[locDict valueForKey:k_age]]];
    [lbl_dateOfVisit setText:[NSString stringWithFormat:@" ( %@ ) ",[locDict valueForKey:k_DateOfVisit]]];
    [lbl_occupation setText:[NSString stringWithFormat:@" ( %@ ) ",[locDict valueForKey:k_Occupation]]];
    [lbl_nationality setText:[NSString stringWithFormat:@" ( %@ ) ",[locDict valueForKey:k_Nationality]]];
    [lbl_meditation setText:[NSString stringWithFormat:@" ( %@ ) ",[locDict valueForKey:k_MedicationTakenNow]]];
    [lbl_clicnicalRecord setText:[NSString stringWithFormat:@" ( %@ ) ",[locDict valueForKey:k_ClinicalRecord]]];
    
    //[lbl_qusAns2 setText:[NSString stringWithFormat:@" %@ ",[[[NSUserDefaults standardUserDefaults] valueForKey:k_painSelectedBodyValue] objectForKey:k_bodydetails]]];
    [lbl_qusAns2 setText:[NSString stringWithFormat:@" %@ ",[[NSUserDefaults standardUserDefaults] valueForKey:k_bodydetails]]];
    //[lbl_qusAns3 setText:[NSString stringWithFormat:@" ( %@ ) ",[answerResultArraySecond objectAtIndex:1]]];
    [lbl_qusAns3 setText:[NSString stringWithFormat:@" ( %@ ) ",[[NSUserDefaults standardUserDefaults] valueForKey:@"q3"]]];
    [lbl_qusAns4 setText:[NSString stringWithFormat:@" ( %@ ) ",[answerResultArraySecond objectAtIndex:2]]];
    [lbl_qusAns5 setText:[NSString stringWithFormat:@" ( %@ ) ",[answerResultArraySecond objectAtIndex:3]]];
    
    if ([[selectedImgArray objectAtIndex:0] isEqualToString:@"1"]) {
        [lbl_qusAns6Image1 setText:[NSString stringWithFormat:@" ( 选择 ) "]];
        [lbl_qusAns6Image2 setText:[NSString stringWithFormat:@" ( ) "]];
        [lbl_qusAns6Image3 setText:[NSString stringWithFormat:@" ( ) "]];
        [lbl_qusAns6Image4 setText:[NSString stringWithFormat:@" ( ) "]];
    } else if ([[selectedImgArray objectAtIndex:1] isEqualToString:@"2"]) {
        [lbl_qusAns6Image1 setText:[NSString stringWithFormat:@" ( ) "]];
        [lbl_qusAns6Image2 setText:[NSString stringWithFormat:@" ( 选择 ) "]];
        [lbl_qusAns6Image3 setText:[NSString stringWithFormat:@" ( ) "]];
        [lbl_qusAns6Image4 setText:[NSString stringWithFormat:@" ( ) "]];
    } else if ([[selectedImgArray objectAtIndex:2] isEqualToString:@"3"]) {
        [lbl_qusAns6Image1 setText:[NSString stringWithFormat:@" ( ) "]];
        [lbl_qusAns6Image2 setText:[NSString stringWithFormat:@" ( ) "]];
        [lbl_qusAns6Image3 setText:[NSString stringWithFormat:@" ( 选择 ) "]];
        [lbl_qusAns6Image4 setText:[NSString stringWithFormat:@" ( ) "]];
    } else if ([[selectedImgArray objectAtIndex:3] isEqualToString:@"4"]) {
        [lbl_qusAns6Image1 setText:[NSString stringWithFormat:@" ( ) "]];
        [lbl_qusAns6Image2 setText:[NSString stringWithFormat:@" ( ) "]];
        [lbl_qusAns6Image3 setText:[NSString stringWithFormat:@" ( ) "]];
        [lbl_qusAns6Image4 setText:[NSString stringWithFormat:@" ( 选择 ) "]];
    }
        
    [lbl_qusAns7 setText:[NSString stringWithFormat:@" ( %@ ) ",[self forCorponVal:[NSString stringWithFormat:@"%@",[answerResultArraySecond objectAtIndex:5]]]]];
    [lbl_qusAns8 setText:[NSString stringWithFormat:@" ( %@ ) ",[self forCorponVal:[NSString stringWithFormat:@"%@",[answerResultArraySecond objectAtIndex:6]]]]];
    [lbl_qusAns9 setText:[NSString stringWithFormat:@" ( %@ ) ",[self forCorponVal:[NSString stringWithFormat:@"%@",[answerResultArraySecond objectAtIndex:7]]]]];
    [lbl_qusAns10 setText:[NSString stringWithFormat:@" ( %@ ) ",[self forCorponVal:[NSString stringWithFormat:@"%@",[answerResultArraySecond objectAtIndex:8]]]]];
    [lbl_qusAns11 setText:[NSString stringWithFormat:@" ( %@ ) ",[self forCorponVal:[NSString stringWithFormat:@"%@",[answerResultArraySecond objectAtIndex:9]]]]];
    [lbl_qusAns12 setText:[NSString stringWithFormat:@" ( %@ ) ",[self forCorponVal:[NSString stringWithFormat:@"%@",[answerResultArraySecond objectAtIndex:10]]]]];
    [lbl_qusAns13 setText:[NSString stringWithFormat:@" ( %@ ) ",[self forCorponVal:[NSString stringWithFormat:@"%@",[answerResultArraySecond objectAtIndex:11]]]]];
    
    Database *dataBase = [[Database alloc] init];
    [dataBase initWithSqliteOpen];
     NSMutableArray *receiveArray = [[NSMutableArray alloc] init]; 
    //receiveArray = [dataBase getPreScore:@"2"];
    receiveArray = [dataBase getPreScore:[locDict valueForKey:k_Subject_Id]];
    [dataBase initWithSqliteClose];    
    
    for (int i = 0; i < [receiveArray count]; i++) {
        NSMutableDictionary *revDict = [receiveArray objectAtIndex:i];
        //NSLog(@"%s,%s",[[NSString stringWithFormat:@"%@",[revDict valueForKey:k_DateOfVisit]] UTF8String],[[NSString stringWithFormat:@"%@",[revDict valueForKey:@"score"]] UTF8String]);
        if(i==0){
            [lbl_vd1 setText:[revDict valueForKey:k_DateOfVisit]];
            [lbl_s1 setText:[revDict valueForKey:@"score"]];
        }
        if(i==1){
            [lbl_vd2 setText:[revDict valueForKey:k_DateOfVisit]];
            [lbl_s2 setText:[revDict valueForKey:@"score"]];
        }
        if(i==2){
            [lbl_vd3 setText:[revDict valueForKey:k_DateOfVisit]];
            [lbl_s3 setText:[revDict valueForKey:@"score"]];
        }
        if(i==3){
            [lbl_vd4 setText:[revDict valueForKey:k_DateOfVisit]];
            [lbl_s4 setText:[revDict valueForKey:@"score"]];
        }
        if(i==4){
            [lbl_vd5 setText:[revDict valueForKey:k_DateOfVisit]];
            [lbl_s5 setText:[revDict valueForKey:@"score"]];
        }
    }    
}

-(NSString *) forCorponVal:(NSString *)valll {
    NSString *valStr = [[NSString alloc] init];
    if ([valll isEqualToString:@"0"]) {
        valStr = @"从未";
    } else if ([valll isEqualToString:@"1"]) {
        valStr = @"几乎没";
    } else if ([valll isEqualToString:@"2"]) {
        valStr = @"轻微";
    } else if ([valll isEqualToString:@"3"]) {
        valStr = @"中等";
    } else if ([valll isEqualToString:@"4"]) {
        valStr = @"重度";
    } else if ([valll isEqualToString:@"5"]) {
        valStr = @"严重";
    }
    return valStr;
}

-(void)backButtonMove {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)moveHomeButton {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:k_Center];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:k_Subject_Id];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:k_DateOfVisit];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:k_PatientName];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:k_Nationality];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:k_Occupation];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:k_age];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:k_ClinicalRecord];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:k_MedicationTakenNow];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:k_OtherCondition];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:k_bodydetails];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"q2"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"q3"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"q4"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"q5"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"q6"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"q7"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"q8"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"q9"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"q10"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"q11"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"q12"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"q13"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"score"];

    PatientHistoryView *varPatientHistoryView = [[PatientHistoryView alloc] initWithNibName:@"PatientHistoryView" bundle:nil];
    [self.navigationController pushViewController:varPatientHistoryView animated:YES];
}

-(IBAction)submitAction {
    NSString *strPID = [[NSString alloc] init];
    NSMutableDictionary *dataDict = [[NSMutableDictionary alloc] init];
    
    [dataDict setValue:[[NSUserDefaults standardUserDefaults] valueForKey:k_Center] forKey:k_Center];
    [dataDict setValue:[[NSUserDefaults standardUserDefaults] valueForKey:k_Subject_Id] forKey:k_Subject_Id];
    [dataDict setValue:[[NSUserDefaults standardUserDefaults] valueForKey:k_DateOfVisit] forKey:k_DateOfVisit];
    [dataDict setValue:[[NSUserDefaults standardUserDefaults] valueForKey:k_PatientName] forKey:k_PatientName];
    [dataDict setValue:[[NSUserDefaults standardUserDefaults] valueForKey:k_Nationality] forKey:k_Nationality];
    [dataDict setValue:[[NSUserDefaults standardUserDefaults] valueForKey:k_Occupation] forKey:k_Occupation];
    [dataDict setValue:[[NSUserDefaults standardUserDefaults] valueForKey:k_age] forKey:k_age];
    [dataDict setValue:[[NSUserDefaults standardUserDefaults] valueForKey:k_ClinicalRecord] forKey:k_ClinicalRecord];
    [dataDict setValue:[[NSUserDefaults standardUserDefaults] valueForKey:k_MedicationTakenNow] forKey:k_MedicationTakenNow];
    [dataDict setValue:[[NSUserDefaults standardUserDefaults] valueForKey:k_OtherCondition] forKey:k_OtherCondition];
    [dataDict setValue:[[NSUserDefaults standardUserDefaults] valueForKey:k_bodydetails] forKey:k_bodydetails];
    [dataDict setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"q2"] forKey:@"q2"];
    [dataDict setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"q3"] forKey:@"q3"];
    [dataDict setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"q4"] forKey:@"q4"];
    [dataDict setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"q5"] forKey:@"q5"];
    [dataDict setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"q6"] forKey:@"q6"];
    [dataDict setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"q7"] forKey:@"q7"];
    [dataDict setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"q8"] forKey:@"q8"];
    [dataDict setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"q9"] forKey:@"q9"];
    [dataDict setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"q10"] forKey:@"q10"];
    [dataDict setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"q11"] forKey:@"q11"];
    [dataDict setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"q12"] forKey:@"q12"];
    [dataDict setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"q13"] forKey:@"q13"];
    [dataDict setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"score"] forKey:@"score"];
    
    Database *dataBase = [[Database alloc] init];
    [dataBase initWithSqliteOpen];
    strPID = [dataBase insertPDData:dataDict];
    [dataBase initWithSqliteClose];
    
    if(([[Reachability reachabilityForInternetConnection] currentReachabilityStatus]==ReachableViaWiFi)||([[Reachability reachabilityForInternetConnection] currentReachabilityStatus]==ReachableViaWWAN)) {
        //上传数据
        [dataDict setValue:strPID forKey:@"pid"];
        [dataDict setValue:[[NSUserDefaults standardUserDefaults] valueForKey:k_saveActivationcode] forKey:k_saveActivationcode];
        
        DataManagerr *dataMana = [[DataManagerr alloc] initWithDelegate:self];  //DataManagerDelegate:self];
        [dataMana executeRequestWithType:UploadData andDictionary:dataDict];
    }else {
                [self moveHomeButton];
        
    }
    
    //以下代码不要，先写本地库，如网络存在再上传，上传成功后修改本地库标识域。
    /*NSMutableDictionary *ansDict = [[NSMutableDictionary alloc] init];
    [ansDict setValue:[[NSUserDefaults standardUserDefaults] valueForKey:k_painid] forKey:k_painid];
    [ansDict setValue:[[NSUserDefaults standardUserDefaults] valueForKey:k_patientid] forKey:k_patientid];
    [ansDict setValue:(NSMutableArray *)answerResultArraySecond forKey:k_Answers];
    
    
    if(([[Reachability reachabilityForInternetConnection] currentReachabilityStatus]==ReachableViaWiFi)||([[Reachability reachabilityForInternetConnection] currentReachabilityStatus]==ReachableViaWWAN)) {

        NSMutableDictionary *userDict = [[NSMutableDictionary alloc] init];
        [userDict setValue:answerResultArraySecond forKey:k_QusAnsDetailResultDictInput];
        DataManagerr *dataMana = [[DataManagerr alloc] initWithDelegate:self];  //DataManagerDelegate:self];
        [dataMana executeRequestWithType:AddpatientQusAnsDetailsInDB andDictionary:userDict];
    }
    else {
        Database *dataBase = [[Database alloc] init];
        [dataBase initWithSqliteOpen];
        [dataBase insertanswerdetails:ansDict];
        [dataBase initWithSqliteClose];
        
        [[[UIAlertView alloc] initWithTitle:nil message:@"数据存储成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil] show];
    }*/
}

-(void)dataManagerDidFinishLoading:(DataManagerr *)dMange {
    NSString *strpid = [[NSString alloc] init];
    strpid = [[[dMange.resultedDictionary valueForKey:@"UploadDataResult"] objectAtIndex:0] valueForKey:@"pid"];
    if(strpid==nil){
        //[[[UIAlertView alloc] initWithTitle:nil message:@"数据上传失败" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil] show];
    }else{
        Database *dataBase = [[Database alloc] init];
        [dataBase initWithSqliteOpen];
        [dataBase updateUploadFlag:(NSString *)strpid];
        [dataBase initWithSqliteClose];
    }
    [self moveHomeButton];    
    //以下代码不要，如收到成功信息，修改本地库上传成功标识域
    /*if (dMange) {
        [[NSUserDefaults standardUserDefaults] setValue:[dMange.resultedDictionary objectForKey:@"AddpatientQusAnsDetailsInDBResult"] forKey:k_QusAnsDetailResultOutput];
        NSLog(@"%@  得分", [NSString stringWithFormat:@"%d",[dMange.resultedDictionary objectForKey:@"AddpatientQusAnsDetailsInDBResult"]]);
        [[[UIAlertView alloc] initWithTitle:nil message:@"数据传送成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil] show];
    }*/
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

@end
