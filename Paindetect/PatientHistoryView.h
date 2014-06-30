//
//  PatientHistoryView.h
//  Paindetect
//
//  Created by jegan selvaraj on 4/10/12.
//  Copyright (c) 2012 blisslogix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Database.h"

#import "DataManagerr.h"

@interface PatientHistoryView : UIViewController <DataManagerDelegate,UITextFieldDelegate,UITextViewDelegate>
{
    IBOutlet UITextField *centerfld;
    IBOutlet UITextField *subjectidfld;
    IBOutlet UITextField *dateofvisitfld;
    IBOutlet UITextField *patientnamefld;
    IBOutlet UITextField *nationalityfld;
    IBOutlet UITextField *occupationfld;
    IBOutlet UITextField *agefld;
    IBOutlet UITextField *medicationfld;
    
    IBOutlet UITextView *clinicalrecordsfld;
    IBOutlet UITextField *otherconditionfld;
    NSMutableDictionary *localdict;
}


@property (nonatomic, retain) UITextField *centerfld;
@property (nonatomic, retain) UITextField *subjectidfld;
@property (nonatomic, retain) UITextField *dateofvisitfld;
@property (nonatomic, retain) UITextField *patientnamefld;
@property (nonatomic, retain) UITextField *nationalityfld;
@property (nonatomic, retain) UITextField *occupationfld;
@property (nonatomic, retain) UITextField *agefld;
@property (nonatomic, retain) UITextField *medicationfld;
@property (nonatomic, retain) UITextView *clinicalrecordsfld;
@property (nonatomic, retain) UITextField *otherconditionfld;
@property (nonatomic, retain) NSMutableDictionary *localdict;

@property (nonatomic, retain) IBOutlet UIScrollView *scroll_patientHistory;

@property (nonatomic, retain) Database *dataBase;

-(IBAction)submitaction;
-(IBAction)backmenu;

@property (nonatomic, retain) IBOutlet UIImageView *bg_image;
@property (nonatomic, retain) IBOutlet UIView *datePickerView;
@property (nonatomic, retain) IBOutlet UIDatePicker *datePicker;

@property (nonatomic,retain) UITextField *txt_currentfld;
@property (nonatomic,retain) UITextView *txt_currentView;

@property (nonatomic, retain) NSDateFormatter *dateFormatter;
-(void)TextFieldChange:(id)Sender;
-(IBAction) nextPress:(id)sender;
-(IBAction)moveNextFeild; 
-(void)alertViewMethod;

-(void)changeUserDefaultValue;
-(IBAction)tickButtonAction;

@end
