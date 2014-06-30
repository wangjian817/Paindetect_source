//
//  QusAnsSecondPage.h
//  Paindetect
//
//  Created by Jegan notebook3 Selvaraja on 07/05/12.
//  Copyright (c) 2012 blisslogix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManagerr.h"
#import "Database.h"
#import "PatientHistoryView.h"
#import "AppDelegate.h"

@interface QusAnsSecondPage : UIViewController<DataManagerDelegate>
@property (nonatomic, retain) IBOutlet UILabel *lbl_totalScore;
@property (nonatomic, retain) NSMutableArray *answerResultArraySecond;
@property (nonatomic, retain) IBOutlet UIImageView *bg_image;
-(IBAction)submitAction;
-(void)moveHomeButton;
-(void)backButtonMove;


@property (nonatomic, retain) IBOutlet UILabel *lbl_question;
@property (nonatomic, retain) IBOutlet UIScrollView *qusScrollView;
@property (nonatomic, retain) AppDelegate *appDelegate;

-(void) ScrollViewData;

@property (nonatomic, retain) IBOutlet UILabel *lbl_patientName;
@property (nonatomic, retain) IBOutlet UILabel *lbl_age;
@property (nonatomic, retain) IBOutlet UILabel *lbl_dateOfVisit;
@property (nonatomic, retain) IBOutlet UILabel *lbl_occupation;
@property (nonatomic, retain) IBOutlet UILabel *lbl_nationality;
@property (nonatomic, retain) IBOutlet UILabel *lbl_meditation;
@property (nonatomic, retain) IBOutlet UILabel *lbl_clicnicalRecord;
@property (nonatomic, retain) IBOutlet UILabel *lbl_qusAns2;
@property (nonatomic, retain) IBOutlet UILabel *lbl_qusAns3;
@property (nonatomic, retain) IBOutlet UILabel *lbl_qusAns4;
@property (nonatomic, retain) IBOutlet UILabel *lbl_qusAns5;
@property (nonatomic, retain) IBOutlet UILabel *lbl_qusAns6Image1;
@property (nonatomic, retain) IBOutlet UILabel *lbl_qusAns7;
@property (nonatomic, retain) IBOutlet UILabel *lbl_qusAns8;
@property (nonatomic, retain) IBOutlet UILabel *lbl_qusAns9;
@property (nonatomic, retain) IBOutlet UILabel *lbl_qusAns10;
@property (nonatomic, retain) IBOutlet UILabel *lbl_qusAns11;
@property (nonatomic, retain) IBOutlet UILabel *lbl_qusAns12;
@property (nonatomic, retain) IBOutlet UILabel *lbl_qusAns13;
@property (nonatomic, retain) IBOutlet UILabel *lbl_qusAns6Image2;
@property (nonatomic, retain) IBOutlet UILabel *lbl_qusAns6Image3;
@property (nonatomic, retain) IBOutlet UILabel *lbl_qusAns6Image4;
@property (nonatomic, retain) IBOutlet UILabel *lbl_vd1;
@property (nonatomic, retain) IBOutlet UILabel *lbl_s1;
@property (nonatomic, retain) IBOutlet UILabel *lbl_vd2;
@property (nonatomic, retain) IBOutlet UILabel *lbl_s2;
@property (nonatomic, retain) IBOutlet UILabel *lbl_vd3;
@property (nonatomic, retain) IBOutlet UILabel *lbl_s3;
@property (nonatomic, retain) IBOutlet UILabel *lbl_vd4;
@property (nonatomic, retain) IBOutlet UILabel *lbl_s4;
@property (nonatomic, retain) IBOutlet UILabel *lbl_vd5;
@property (nonatomic, retain) IBOutlet UILabel *lbl_s5;

@property (nonatomic, retain) NSMutableArray *selectedImgArray;
-(NSString *) forCorponVal:(NSString *)valll;
@end
