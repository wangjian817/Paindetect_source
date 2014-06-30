//
//  QusAnsFirstPage.h
//  Paindetect
//
//  Created by Jegan notebook3 Selvaraja on 07/05/12.
//  Copyright (c) 2012 blisslogix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "QusAnsSecondPage.h"
#import "PopoverView.h"

@interface QusAnsFirstPage : UIViewController<UIPopoverControllerDelegate>

@property (nonatomic, retain) AppDelegate *appDelegate;
@property (nonatomic, retain) IBOutlet UILabel *lbl_question1;
@property (nonatomic, retain) IBOutlet UILabel *lbl_question2;
@property (nonatomic, retain) IBOutlet UILabel *lbl_question3;
@property (nonatomic, retain) IBOutlet UILabel *lbl_question4;
@property (nonatomic, retain) IBOutlet UILabel *lbl_question5;
@property (nonatomic, retain) IBOutlet UILabel *lbl_yes;
@property (nonatomic, retain) IBOutlet UILabel *lbl_no;

@property (nonatomic, retain) IBOutlet UIButton *btn_yes;
@property (nonatomic, retain) IBOutlet UIButton *btn_no;
@property (nonatomic, retain) IBOutlet UIButton *btn_imageSelect1;
@property (nonatomic, retain) IBOutlet UIButton *btn_imageSelect2;
@property (nonatomic, retain) IBOutlet UIButton *btn_imageSelect3;
@property (nonatomic, retain) IBOutlet UIButton *btn_imageSelect4;

@property (nonatomic, retain) IBOutlet UIImageView *btn_image1;
@property (nonatomic, retain) IBOutlet UIImageView *btn_image2;
@property (nonatomic, retain) IBOutlet UIImageView *btn_image3;
@property (nonatomic, retain) IBOutlet UIImageView *btn_image4;

@property (nonatomic, retain) NSString *selectImgValStr;
@property (nonatomic, retain) NSString *selectYesNoValStr;

@property (nonatomic, retain) IBOutlet UISlider *qusAnsSlider3;
@property (nonatomic, retain) IBOutlet UISlider *qusAnsSlider4;
@property (nonatomic, retain) IBOutlet UISlider *qusAnsSlider5;

@property (nonatomic, retain) DataManagerr *dataManageerr;
@property (nonatomic, retain) NSMutableArray *answerResultArrayFirst;


-(IBAction)selectionImg:(id)sender;
-(IBAction)yesorno:(id)sender;
-(void)nextPage;

@property (nonatomic, retain) IBOutlet UIImageView *bg_image;

@property (nonatomic, retain) IBOutlet UILabel *lbl_question7;
@property (nonatomic, retain) IBOutlet UILabel *lbl_question8;
@property (nonatomic, retain) IBOutlet UILabel *lbl_question9;
@property (nonatomic, retain) IBOutlet UILabel *lbl_question10;
@property (nonatomic, retain) IBOutlet UILabel *lbl_question11;
@property (nonatomic, retain) IBOutlet UILabel *lbl_question12;
@property (nonatomic, retain) IBOutlet UILabel *lbl_question13;

@property (nonatomic, retain) IBOutlet UISlider *qusAnsSlider7;
@property (nonatomic, retain) IBOutlet UISlider *qusAnsSlider8;
@property (nonatomic, retain) IBOutlet UISlider *qusAnsSlider9;
@property (nonatomic, retain) IBOutlet UISlider *qusAnsSlider10;
@property (nonatomic, retain) IBOutlet UISlider *qusAnsSlider11;
@property (nonatomic, retain) IBOutlet UISlider *qusAnsSlider12;
@property (nonatomic, retain) IBOutlet UISlider *qusAnsSlider13;

@property (nonatomic, retain) IBOutlet UILabel *lbl_seprateQuestion7;
@property (nonatomic, retain) IBOutlet UILabel *lbl_seprateQuestion8;
@property (nonatomic, retain) IBOutlet UILabel *lbl_seprateQuestion9;
@property (nonatomic, retain) IBOutlet UILabel *lbl_seprateQuestion10;
@property (nonatomic, retain) IBOutlet UILabel *lbl_seprateQuestion11;
@property (nonatomic, retain) IBOutlet UILabel *lbl_seprateQuestion12;
@property (nonatomic, retain) IBOutlet UILabel *lbl_seprateQuestion13;

@property (nonatomic, retain) IBOutlet UIButton *btn_seprateQuestion7;
@property (nonatomic, retain) IBOutlet UIButton *btn_seprateQuestion8;
@property (nonatomic, retain) IBOutlet UIButton *btn_seprateQuestion9;
@property (nonatomic, retain) IBOutlet UIButton *btn_seprateQuestion10;
@property (nonatomic, retain) IBOutlet UIButton *btn_seprateQuestion11;
@property (nonatomic, retain) IBOutlet UIButton *btn_seprateQuestion12;
@property (nonatomic, retain) IBOutlet UIButton *btn_seprateQuestion13;

@property (nonatomic, retain) IBOutlet UIView *bg_viewQus7;
@property (nonatomic, retain) IBOutlet UIView *bg_viewQus8;
@property (nonatomic, retain) IBOutlet UIView *bg_viewQus9;
@property (nonatomic, retain) IBOutlet UIView *bg_viewQus10;
@property (nonatomic, retain) IBOutlet UIView *bg_viewQus11;
@property (nonatomic, retain) IBOutlet UIView *bg_viewQus12;
@property (nonatomic, retain) IBOutlet UIView *bg_viewQus13;

@property (nonatomic, retain) NSMutableArray *sliderValueArray;
@property (nonatomic, retain) UIPopoverController *popOverController;
@property (nonatomic, retain) IBOutlet PopoverView *popViewController;

-(IBAction)setSeprateLabelLine;
-(IBAction)calculateXpos:(UILabel *)lbl_seprate ForView:(UIView *)bgView;

-(IBAction)SliderValueChangedFunction:(id)sender;
-(void)backButtonMove;

@property (nonatomic, retain) NSMutableArray *locSelectImgArray;
@end
