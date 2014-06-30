//
//  PatientHistoryView.m
//  Paindetect
//
//  Created by jegan selvaraj on 4/10/12.
//  Copyright (c) 2012 blisslogix. All rights reserved.
//

#import "PatientHistoryView.h"
#import "BodyView.h"
#import "Reachability.h"
#import "LoadViewController_iPad.h"

@implementation PatientHistoryView

@synthesize centerfld;
@synthesize subjectidfld;
@synthesize dateofvisitfld;
@synthesize patientnamefld;
@synthesize nationalityfld;
@synthesize occupationfld;
@synthesize agefld;
@synthesize medicationfld;
@synthesize clinicalrecordsfld;
@synthesize otherconditionfld;
@synthesize localdict;

@synthesize dataBase;

@synthesize bg_image;

@synthesize scroll_patientHistory,datePickerView,datePicker;
@synthesize txt_currentfld,txt_currentView,dateFormatter;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        dataBase = [[Database alloc] init];
        dateFormatter = [[NSDateFormatter alloc]init];

    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(IBAction)backmenu
{
    //[self.navigationController popToRootViewControllerAnimated:YES];
    //[self.navigationController popViewControllerAnimated:YES];
    LoadViewController_iPad *loadViewController_iPad = [[LoadViewController_iPad alloc] initWithNibName:@"LoadView_iPad" bundle:nil];
    [self.navigationController pushViewController:loadViewController_iPad animated:YES];
}
#pragma mark SubmitButton Action

-(IBAction)submitaction
{
    [scroll_patientHistory setFrame:CGRectMake(0, 0, 768, 1024)];
    [otherconditionfld resignFirstResponder];
    NSMutableDictionary *userDict = [[NSMutableDictionary alloc] init];

    NSString *message = [[NSString alloc] init];
    if ([centerfld.text length] == 0) {
        message = @"请填写接诊者";
    } 
    else if ([subjectidfld.text length] == 0) {
        message = @"请填写患者身份证号";
    }
    else if ([dateofvisitfld.text length] == 0) {
        message = @"请填写受访日期";
    }
    else if ([patientnamefld.text length] == 0) {
        message = @"请填写患者姓名";
    }
//    else if ([agefld.text length] == 0) {
//        message = @"Age Field Empty";
//    }
//    else if ([medicationfld.text length] == 0) {
//        message = @"Medication Taken Now Field Empty";
//    }
    if ([message length] > 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"错误" message:message delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }
    else {
        [userDict setValue:centerfld.text forKey:k_Center];
        [userDict setValue:subjectidfld.text forKey:k_Subject_Id];
        [userDict setValue:dateofvisitfld.text forKey:k_DateOfVisit];
        [userDict setValue:patientnamefld.text forKey:k_PatientName];
        [userDict setValue:nationalityfld.text forKey:k_Nationality];
        [userDict setValue:occupationfld.text forKey:k_Occupation];
        [userDict setValue:agefld.text forKey:k_age];
        [userDict setValue:clinicalrecordsfld.text forKey:k_ClinicalRecord];
        [userDict setValue:medicationfld.text forKey:k_MedicationTakenNow];
        [userDict setValue:otherconditionfld.text forKey:k_OtherCondition];
        
        [[NSUserDefaults standardUserDefaults] setObject:userDict forKey:k_PatientHistoryValue];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [[NSUserDefaults standardUserDefaults] setObject:centerfld.text forKey:k_Center];
        [[NSUserDefaults standardUserDefaults] setObject:subjectidfld.text forKey:k_Subject_Id];
        [[NSUserDefaults standardUserDefaults] setObject:dateofvisitfld.text forKey:k_DateOfVisit];
        [[NSUserDefaults standardUserDefaults] setObject:patientnamefld.text forKey:k_PatientName];
        [[NSUserDefaults standardUserDefaults] setObject:nationalityfld.text forKey:k_Nationality];
        [[NSUserDefaults standardUserDefaults] setObject:occupationfld.text forKey:k_Occupation];
        [[NSUserDefaults standardUserDefaults] setObject:agefld.text forKey:k_age];
        [[NSUserDefaults standardUserDefaults] setObject:clinicalrecordsfld.text forKey:k_ClinicalRecord];
        [[NSUserDefaults standardUserDefaults] setObject:medicationfld.text forKey:k_MedicationTakenNow];
        [[NSUserDefaults standardUserDefaults] setObject:otherconditionfld.text forKey:k_OtherCondition];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
         
        /*if(([[Reachability reachabilityForInternetConnection] currentReachabilityStatus]==ReachableViaWiFi)||([[Reachability reachabilityForInternetConnection] currentReachabilityStatus]==ReachableViaWWAN)) {
            DataManagerr *dataMana = [[DataManagerr alloc] initWithDelegate:self];
            [dataMana executeRequestWithType:AddPatientdetailsInDB andDictionary:userDict];
        }
        else {
            [dataBase initWithSqliteOpen];
            [dataBase insertPatientHistory:userDict];
            NSString *patientID = [dataBase getPatientStr];
            NSLog(@"patientID %@",patientID);
            [dataBase initWithSqliteClose];
            
            [[NSUserDefaults standardUserDefaults] setValue:patientID forKey:k_patientid];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self changeUserDefaultValue];
            BodyView *bodyview = [[BodyView alloc] initWithNibName:@"BodyView" bundle:nil];
            [self.navigationController pushViewController:bodyview animated:YES];
        }*/
        BodyView *bodyview = [[BodyView alloc] initWithNibName:@"BodyView" bundle:nil];
        [self.navigationController pushViewController:bodyview animated:YES];
    }
    
//    BodyView *bodyview = [[BodyView alloc] initWithNibName:@"BodyView" bundle:nil];
//    [self.navigationController pushViewController:bodyview animated:YES];
}
#pragma mark - DataManager Delegate

-(void)dataManagerDidFinishLoading:(DataManagerr *)dMange {
    if (dMange) {
        NSString *dataBaseResult = [NSString stringWithFormat:@"%@",[dMange.resultedDictionary objectForKey:@"AddPatientdetailsInDBResult"]];
        if ([dataBaseResult isEqualToString:@"(null)"]) {
            NSLog(@"Result No");
            [self alertViewMethod];
        }
        else {
            [[NSUserDefaults standardUserDefaults] setValue:dataBaseResult forKey:k_PatientID];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self changeUserDefaultValue];
            BodyView *bodyview = [[BodyView alloc] initWithNibName:@"BodyView" bundle:nil];
            [self.navigationController pushViewController:bodyview animated:YES];
        }
    }
    else {
        [self alertViewMethod];
    }
}
-(void)alertViewMethod {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"错误" message:@"添加记录失败" delegate:self cancelButtonTitle:nil otherButtonTitles:@"重试", nil];
    [alert show];
}

-(void)changeUserDefaultValue {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:k_QusAnsYesorNoResult];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:k_3QusAnsResult];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:k_4QusAnsResult];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:k_5QusAnsResult];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:k_6QusAnsResult];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:k_7QusAnsResult];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:k_8QusAnsResult];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:k_9QusAnsResult];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:k_10QusAnsResult];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:k_11QusAnsResult];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:k_12QusAnsResult];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:k_13QusAnsResult];
    
    [[NSUserDefaults standardUserDefaults] removeSuiteNamed:k_painid];
    [[NSUserDefaults standardUserDefaults] removeSuiteNamed:k_patientid];
    [[NSUserDefaults standardUserDefaults] removeSuiteNamed:k_bodydetails];
    [[NSUserDefaults standardUserDefaults] removeSuiteNamed:k_Answers];
}

#pragma mark - TextFeild Delegate

-(void)kbWillHide:(id)sender{
    [scroll_patientHistory setFrame:CGRectMake(0, 0, 768, 1024)];
}



-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    /*if (textField == centerfld) {
        [scroll_patientHistory setFrame:CGRectMake(0, 0, 768, 1024)];
    }
    if(textField==medicationfld){
        [scroll_patientHistory setFrame:CGRectMake(0, -160, 768, 1024)];
    }*/
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    txt_currentfld = textField;
    if (txt_currentfld == dateofvisitfld) {
        textField.inputView = self.datePickerView;
        datePicker.datePickerMode = UIDatePickerModeDate;
        datePicker.hidden = NO;
        datePicker.date = [NSDate date];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        dateofvisitfld.text = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:datePicker.date]];
        [datePicker addTarget:self action:@selector(TextFieldChange:) forControlEvents:UIControlEventValueChanged];
    } 
    else if (txt_currentfld == subjectidfld) {
//        subjectidfld.keyboardType = UIKeyboardTypeNumberPad;
    }
    else if (txt_currentfld == agefld) {
        agefld.keyboardType = UIKeyboardTypeNumberPad;
    }
    if ((txt_currentfld == centerfld)||(txt_currentfld==medicationfld)) {
        [scroll_patientHistory setFrame:CGRectMake(0, -130, 768, 1024)];
    }else{
        [scroll_patientHistory setFrame:CGRectMake(0, 0, 768, 1024)];
    }
    return YES;
}
-(void)TextFieldChange:(id)Sender{
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    dateofvisitfld.text = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:datePicker.date]];
    //[scroll_patientHistory setFrame:CGRectMake(0, 0, 768, 1024)];
}

#pragma mark - TextView Delegate

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView {
//    if (textView == clinicalrecordsfld) {
//        [medicationfld becomeFirstResponder]; 
//    }
        txt_currentView  = textView;
    if (txt_currentView == clinicalrecordsfld) {
        [scroll_patientHistory setFrame:CGRectMake(0, -130, 768, 1024)];
    }
    /*if (txt_currentView == otherconditionfld) {
        [scroll_patientHistory setFrame:CGRectMake(0, -190, 768, 1024)];//1024-700 =    324
    }*/
    return YES;
}
-(BOOL) textViewShouldEndEditing:(UITextView *)textView {
    /*if (textView == clinicalrecordsfld) {
        [clinicalrecordsfld becomeFirstResponder]; 
    }
    else if (textView == otherconditionfld) {
        [scroll_patientHistory setFrame:CGRectMake(0, 0, 768, 1024)];
        [otherconditionfld resignFirstResponder];
    }*/
    //[scroll_patientHistory setFrame:CGRectMake(0, 0, 768, 1024)];
    return YES;
}

/*-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"]) {
        if(textView.tag == 1) { [medicationfld becomeFirstResponder]; }
        else if(textView.tag == 2) { [otherconditionfld resignFirstResponder]; }
        return NO;
    }
    return YES;
}*/

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kbWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:(106.0/255.0) green:(106.0/255.0) blue:(106.0/255.0) alpha:1.0];
    self.navigationItem.title = @"输入数据";
    [scroll_patientHistory setContentSize:CGSizeMake(768, 1324)];
    [scroll_patientHistory setScrollEnabled:NO];
    [dateofvisitfld setDelegate:self];
    [otherconditionfld setDelegate:self];
    [super viewDidLoad];
    [bg_image setBackgroundColor:[UIColor colorWithRed:(224.0/255.0) green:(224.0/255.0) blue:(224.0/255.0) alpha:1.0]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"下一步" style:UIBarButtonItemStyleBordered target:self action:@selector(submitaction)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(backmenu)];
    [self moveNextFeild];
    // Do any additional setup after loading the view from its nib.
}

-(void) viewWillAppear:(BOOL)animated {
//    centerfld.text = @"";
//    subjectidfld.text = @"";
//    dateofvisitfld.text = @"";
//    patientnamefld.text = @"";
//    nationalityfld.text = @"";
//    occupationfld.text = @"";
//    agefld.text = @"";
//    medicationfld.text = @"";
//    clinicalrecordsfld.text = @"";
//    otherconditionfld.text = @"";
}

#pragma mark - Move Next Feild

-(IBAction)moveNextFeild {
    /*[centerfld addTarget:self action:@selector(nextPress:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [subjectidfld addTarget:self action:@selector(nextPress:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [dateofvisitfld addTarget:self action:@selector(nextPress:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [patientnamefld addTarget:self action:@selector(nextPress:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [nationalityfld addTarget:self action:@selector(nextPress:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [occupationfld addTarget:self action:@selector(nextPress:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [agefld addTarget:self action:@selector(nextPress:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [medicationfld addTarget:self action:@selector(nextPress:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    [clinicalrecordsfld setTag:1];*/
    //[otherconditionfld setTag:2];
}
-(IBAction) nextPress:(id)sender {
/*    if ([centerfld isEditing]) { 
        [subjectidfld becomeFirstResponder]; 
    } else if ([subjectidfld isEditing]) { 
        [dateofvisitfld becomeFirstResponder]; 
    } else if ([dateofvisitfld isEditing]) { 
        [patientnamefld becomeFirstResponder]; 
    } else if ([patientnamefld isEditing]) { 
        [nationalityfld becomeFirstResponder]; 
    } else if ([nationalityfld isEditing]) { 
        [occupationfld becomeFirstResponder]; 
    } else if ([occupationfld isEditing]) { 
        [agefld becomeFirstResponder]; 
    } else if ([agefld isEditing]) { 
        [clinicalrecordsfld becomeFirstResponder]; 
//        [agefld resignFirstResponder];
    } else if ([medicationfld isEditing]) { 
        [otherconditionfld becomeFirstResponder]; 
    }*/
}

-(IBAction)tickButtonAction {
    [dateofvisitfld resignFirstResponder];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return NO;
}

@end
