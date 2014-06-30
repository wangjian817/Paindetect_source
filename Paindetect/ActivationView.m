//
//  ActivationView.m
//  Paindetect
//
//  Created by jegan selvaraj on 4/10/12.
//  Copyright (c) 2012 blisslogix. All rights reserved.
//

#import "ActivationView.h"
#import "PatientHistoryView.h"
#import "Reachability.h"
#import "LoadViewController_iPad.h"

@implementation ActivationView

@synthesize submit;
@synthesize activationtextfield;
@synthesize localdict;

@synthesize activitationCodeArray;
@synthesize dataPicker,pickerView;

@synthesize bg_image;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        activitationCodeArray = [[NSMutableArray alloc] init];
        dataPicker = [[UIPickerView alloc] init];
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

-(IBAction)submitbutton
{
    if ([activationtextfield.text length] > 0) {
        NSMutableDictionary *userDict = [[NSMutableDictionary alloc] init];
        [userDict setValue:activationtextfield.text forKey:k_getActivationcode];
       
        if(([[Reachability reachabilityForInternetConnection] currentReachabilityStatus]==ReachableViaWiFi)||([[Reachability reachabilityForInternetConnection] currentReachabilityStatus]==ReachableViaWWAN)) {
            DataManagerr *dataMana = [[DataManagerr alloc] initWithDelegate:self];
            [dataMana executeRequestWithType:ActivationcodeValied andDictionary:userDict];//getActivationcode  ==  ActivationcodeValied
        }
        else {
            NSString *atr = [[NSString alloc] init];
            atr = [NSString stringWithFormat:@"请在连接网络时激活程序！"];
            [self alertViewMethod:atr];
            
            /*Database *dataBase = [[Database alloc] init];
            [dataBase initWithSqliteOpen];
            BOOL activateBool = [dataBase getActivationCodde:activationtextfield.text];
            [dataBase initWithSqliteClose];
        
            if (activateBool == YES) {
                [self goPatientView];
            }
            else {
                [[NSUserDefaults standardUserDefaults] setBool:activateBool forKey:k_ISActivationBOOL];
                [[NSUserDefaults standardUserDefaults] synchronize];
                NSString *atr = [[NSString alloc] init];
                atr = [NSString stringWithFormat:@"请输入正确的激活码"];
                [self alertViewMethod:atr];
            }*/
        }
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"输入激活码" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }
//      PatientHistoryView *patienthistoryview = [[PatientHistoryView alloc] initWithNibName:@"PatientHistoryView" bundle:nil];
//    [self.navigationController pushViewController:patienthistoryview animated:YES];
    
}
-(void)goPatientView {
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:k_ISActivationBOOL];
    [[NSUserDefaults standardUserDefaults] setValue:activationtextfield.text forKey:k_saveActivationcode];
    [[NSUserDefaults standardUserDefaults] synchronize];
    /*PatientHistoryView *patienthistoryview = [[PatientHistoryView alloc] initWithNibName:@"PatientHistoryView" bundle:nil];
    [self.navigationController pushViewController:patienthistoryview animated:YES];*/
    LoadViewController_iPad *MyWebView = [[LoadViewController_iPad alloc] initWithNibName:@"LoadView_iPad" bundle:nil];
    [self.navigationController pushViewController:MyWebView animated:YES];
    

    
}

-(void)dataManagerDidFinishLoading:(DataManagerr *)dMange {
    NSLog(@"%@",dMange);
    if ([[dMange.resultedDictionary valueForKey:@"ActivationcodeValiedResult"] count] > 0) {
        [[NSUserDefaults standardUserDefaults] setValue:[[[dMange.resultedDictionary valueForKey:@"ActivationcodeValiedResult"] objectAtIndex:0] valueForKey:@"ActivitationCode"] forKey:k_saveActivationcode];
        [self goPatientView];
    }
    else if(dMange) {
        NSMutableArray *codeArray = [[NSMutableArray alloc] init];
        codeArray = [dMange.resultedDictionary objectForKey:@"getActivationcodeResult"];
        if ([codeArray count] > 0) {
            for (int i = 0; i < [codeArray count]; i++) {
                [activitationCodeArray addObject:[NSString stringWithFormat:@"%@",[[codeArray objectAtIndex:i] valueForKey:@"ActivitationCode"]]];
            }
            NSLog(@"%@ActivitationCode",activitationCodeArray);
        }
        else {
            NSString *atr = [[NSString alloc] init];
            atr = [NSString stringWithFormat:@"激活码错误"];
            [self alertViewMethod:atr];
        }
    }
    else {
        NSString *atr = [[NSString alloc] init];
        atr = [NSString stringWithFormat:@"请输入正确的激活码"];
        [self alertViewMethod:atr];
    }
    NSLog(@"%@dMange",dMange.resultedDictionary);
//    NSMutableDictionary *locDict = [dMange.innerDictArray objectAtIndex:10];
//    NSLog(@"LOCAL DICT  %@",locDict);
}

-(void)alertViewMethod:(NSString *)msg {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"错误" message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:@"重试", nil];
    [alert show];
}

- (void)viewDidLoad
{
    /*
    NSMutableDictionary *userDict = [[NSMutableDictionary alloc] init];
    DataManagerr *dataman = [[DataManagerr alloc] init];
    dataman.delegate = self;
    [dataman executeRequestWithType:getActivationcode andDictionary:userDict];
    */  
    [dataPicker setDelegate:self];
    [dataPicker setDataSource:self];
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:(106.0/255.0) green:(106.0/255.0) blue:(106.0/255.0) alpha:1.0];
    [super viewDidLoad];
    [bg_image setBackgroundColor:[UIColor colorWithRed:(224.0/255.0) green:(224.0/255.0) blue:(224.0/255.0) alpha:1.0]];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - PickerView DataSource

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [activitationCodeArray count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [activitationCodeArray objectAtIndex:row];
}

#pragma mark - PickerView Delegate

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    activationtextfield.text = [activitationCodeArray objectAtIndex:row];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
//    textField.inputView = self.pickerView;
    return YES;
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
	return NO;
}

@end
