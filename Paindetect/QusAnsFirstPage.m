//
//  QusAnsFirstPage.m
//  Paindetect
//
//  Created by Jegan notebook3 Selvaraja on 07/05/12.
//  Copyright (c) 2012 blisslogix. All rights reserved.
//

#import "QusAnsFirstPage.h"

@implementation QusAnsFirstPage
@synthesize appDelegate;

@synthesize lbl_no;
@synthesize lbl_yes;
@synthesize lbl_question1;
@synthesize lbl_question2;
@synthesize lbl_question3;
@synthesize lbl_question4;
@synthesize lbl_question5;
@synthesize btn_no;
@synthesize btn_yes;
@synthesize btn_imageSelect1;
@synthesize btn_imageSelect2;
@synthesize btn_imageSelect3;
@synthesize btn_imageSelect4;
@synthesize btn_image1;
@synthesize btn_image2;
@synthesize btn_image3;
@synthesize btn_image4;

@synthesize selectImgValStr,selectYesNoValStr;
@synthesize qusAnsSlider3,qusAnsSlider4,qusAnsSlider5;

@synthesize dataManageerr,answerResultArrayFirst;

@synthesize bg_image;

@synthesize lbl_question7,lbl_question8,lbl_question9,lbl_question10,lbl_question11,lbl_question12,lbl_question13;
@synthesize lbl_seprateQuestion7,lbl_seprateQuestion8,lbl_seprateQuestion9,lbl_seprateQuestion10,lbl_seprateQuestion11,lbl_seprateQuestion12,lbl_seprateQuestion13;
@synthesize qusAnsSlider7,qusAnsSlider8,qusAnsSlider9,qusAnsSlider10,qusAnsSlider11,qusAnsSlider12,qusAnsSlider13;
@synthesize bg_viewQus7,bg_viewQus8,bg_viewQus9,bg_viewQus10,bg_viewQus11,bg_viewQus12,bg_viewQus13;
@synthesize btn_seprateQuestion7,btn_seprateQuestion8,btn_seprateQuestion9,btn_seprateQuestion10,btn_seprateQuestion11,btn_seprateQuestion12,btn_seprateQuestion13;
@synthesize popOverController,popViewController;
@synthesize sliderValueArray;

@synthesize locSelectImgArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        sliderValueArray = [[NSMutableArray alloc] init];
        selectImgValStr = [[NSString alloc] init];
        selectYesNoValStr = [[NSString alloc] init];
        answerResultArrayFirst = [[NSMutableArray alloc] initWithObjects:@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0", nil];
        locSelectImgArray = [[NSMutableArray alloc] initWithObjects:@"0",@"0",@"0",@"0",nil];
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
    qusAnsSlider3.maximumValue = 10;
    qusAnsSlider4.maximumValue = 10;
    qusAnsSlider5.maximumValue = 10;
    qusAnsSlider3.maximumValue = 10;
    qusAnsSlider4.maximumValue = 10;
    qusAnsSlider5.maximumValue = 10;
    qusAnsSlider3.value = 0;
    qusAnsSlider4.value = 0;
    qusAnsSlider5.value = 0;
    
    [super viewDidLoad];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    lbl_question1.text = [[appDelegate.questions objectAtIndex:0] valueForKey:@"QuestionName"];
    lbl_yes.text = [[appDelegate.questions objectAtIndex:0] valueForKey:@"value1"];
    lbl_no.text = [[appDelegate.questions objectAtIndex:0] valueForKey:@"value2"];

    lbl_question2.text = [[appDelegate.questions objectAtIndex:1] valueForKey:@"QuestionName"];
    lbl_question3.text =[[appDelegate.questions objectAtIndex:2] valueForKey:@"QuestionName"];
    lbl_question4.text = [[appDelegate.questions objectAtIndex:3] valueForKey:@"QuestionName"];
    lbl_question5.text = [[appDelegate.questions objectAtIndex:4] valueForKey:@"QuestionName"];
    
    [btn_image1 setImage:[UIImage imageNamed:[[appDelegate.questions objectAtIndex:4] valueForKey:@"value4"]]];
    [btn_image2 setImage:[UIImage imageNamed:[[appDelegate.questions objectAtIndex:4] valueForKey:@"value1"]]];
    [btn_image3 setImage:[UIImage imageNamed:[[appDelegate.questions objectAtIndex:4] valueForKey:@"value3"]]];
    [btn_image4 setImage:[UIImage imageNamed:[[appDelegate.questions objectAtIndex:4] valueForKey:@"value2"]]];
    
    lbl_seprateQuestion7.hidden = YES;
    lbl_seprateQuestion8.hidden = YES;
    lbl_seprateQuestion9.hidden = YES;
    lbl_seprateQuestion10.hidden = YES;
    lbl_seprateQuestion11.hidden = YES;
    lbl_seprateQuestion12.hidden = YES;
    lbl_seprateQuestion13.hidden = YES;
    
    lbl_question7.text = [[appDelegate.questions objectAtIndex:5] valueForKey:@"QuestionName"];
    lbl_question8.text = [[appDelegate.questions objectAtIndex:6] valueForKey:@"QuestionName"];
    lbl_question9.text = [[appDelegate.questions objectAtIndex:7] valueForKey:@"QuestionName"];
    lbl_question10.text = [[appDelegate.questions objectAtIndex:8] valueForKey:@"QuestionName"];
    lbl_question11.text = [[appDelegate.questions objectAtIndex:9] valueForKey:@"QuestionName"];
    lbl_question12.text = [[appDelegate.questions objectAtIndex:10] valueForKey:@"QuestionName"];
    lbl_question13.text = [[appDelegate.questions objectAtIndex:11] valueForKey:@"QuestionName"];
    
    qusAnsSlider7.minimumValue = 0;
    qusAnsSlider7.maximumValue = 5;
    qusAnsSlider7.value = 0;
    
    qusAnsSlider8.minimumValue = 0;
    qusAnsSlider8.maximumValue = 5;
    qusAnsSlider8.value = 0;
    
    qusAnsSlider9.minimumValue = 0;
    qusAnsSlider9.maximumValue = 5;
    qusAnsSlider9.value = 0;
    
    qusAnsSlider10.minimumValue = 0;
    qusAnsSlider10.maximumValue = 5;
    qusAnsSlider10.value = 0;
    
    qusAnsSlider11.minimumValue = 0;
    qusAnsSlider11.maximumValue = 5;
    qusAnsSlider11.value = 0;
    
    qusAnsSlider12.minimumValue = 0;
    qusAnsSlider12.maximumValue = 5;
    qusAnsSlider12.value = 0;
    
    qusAnsSlider13.minimumValue = 0;
    qusAnsSlider13.maximumValue = 5;
    qusAnsSlider13.value = 0;
    
    sliderValueArray = [[NSMutableArray alloc] initWithObjects:@"从未",@"几乎没",@"轻微",@"中等",@"重度",@"严重", nil];
    
//     lbl_finalScore.text = [NSString stringWithFormat:@"0"];
    
    [bg_image setBackgroundColor:[UIColor colorWithRed:(224.0/255.0) green:(224.0/255.0) blue:(224.0/255.0) alpha:1.0]];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:(106.0/255.0) green:(106.0/255.0) blue:(106.0/255.0) alpha:1.0];
    
    [self setSeprateLabelLine];
    
    // Do any additional setup after loading the view from its nib.
    
    [bg_image setBackgroundColor:[UIColor colorWithRed:(224.0/255.0) green:(224.0/255.0) blue:(224.0/255.0) alpha:1.0]];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:(106.0/255.0) green:(106.0/255.0) blue:(106.0/255.0) alpha:1.0];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"下一步" style:UIBarButtonItemStyleBordered target:self action:@selector(nextPage)];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"上一步" style:UIBarButtonItemStyleBordered target:self action:@selector(backButtonMove)];

}

-(void)backButtonMove {
    [self.navigationController popToRootViewControllerAnimated:YES];
}



-(IBAction)selectionImg:(id)sender {
    UIButton *btnImg = (UIButton *)sender;
    if (btnImg.tag == 12) {
        btn_imageSelect1.selected = YES;
        btn_imageSelect2.selected = NO;
        btn_imageSelect3.selected = NO;
        btn_imageSelect4.selected = NO;
        selectImgValStr = @"0";
        [locSelectImgArray replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%d",1]];
    }
    else if (btnImg.tag == 13) {
        btn_imageSelect1.selected = NO;
        btn_imageSelect2.selected = YES;
        btn_imageSelect3.selected = NO;
        btn_imageSelect4.selected = NO;
        selectImgValStr = @"-1";
        [locSelectImgArray replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@"%d",2]];
    }
    else if (btnImg.tag == 14) {
        btn_imageSelect1.selected = NO;
        btn_imageSelect2.selected = NO;
        btn_imageSelect3.selected = YES;
        btn_imageSelect4.selected = NO;
        selectImgValStr = @"+1";
        [locSelectImgArray replaceObjectAtIndex:2 withObject:[NSString stringWithFormat:@"%d",3]];
    }
    else if (btnImg.tag == 15) {
        btn_imageSelect1.selected = NO;
        btn_imageSelect2.selected = NO;
        btn_imageSelect3.selected = NO;
        btn_imageSelect4.selected = YES;
        selectImgValStr = @"+1";
        [locSelectImgArray replaceObjectAtIndex:3 withObject:[NSString stringWithFormat:@"%d",4]];
    }
    [answerResultArrayFirst replaceObjectAtIndex:4 withObject:selectImgValStr];
    NSLog(@"AnswerValue Array  %@",answerResultArrayFirst);
}

-(IBAction)yesorno:(id)sender {
    UIButton *btnyesno = (UIButton *)sender;
    if (btnyesno.tag == 10) {
        btn_yes.selected = YES;
        btn_no.selected = NO;
        selectYesNoValStr = @"2";
    }
    else if (btnyesno.tag == 11) {
        btn_yes.selected = NO;
        btn_no.selected = YES;
        selectYesNoValStr = @"0";
    }
    [answerResultArrayFirst replaceObjectAtIndex:0 withObject:selectYesNoValStr];
}
-(void)nextPage {
    QusAnsSecondPage *varQusAnsSecondPage = [[QusAnsSecondPage alloc] initWithNibName:@"QusAnsSecondPage" bundle:nil];
    [varQusAnsSecondPage setAnswerResultArraySecond:answerResultArrayFirst];
    [varQusAnsSecondPage setSelectedImgArray:locSelectImgArray];
    
    [[NSUserDefaults standardUserDefaults] setValue:[answerResultArrayFirst objectAtIndex:0] forKey:@"q2"];
    [[NSUserDefaults standardUserDefaults] setValue:[answerResultArrayFirst objectAtIndex:1] forKey:@"q3"];
    [[NSUserDefaults standardUserDefaults] setValue:[answerResultArrayFirst objectAtIndex:2] forKey:@"q4"];
    [[NSUserDefaults standardUserDefaults] setValue:[answerResultArrayFirst objectAtIndex:3] forKey:@"q5"];
    [[NSUserDefaults standardUserDefaults] setValue:[answerResultArrayFirst objectAtIndex:4] forKey:@"q6"];
    [[NSUserDefaults standardUserDefaults] setValue:[answerResultArrayFirst objectAtIndex:5] forKey:@"q7"];
    [[NSUserDefaults standardUserDefaults] setValue:[answerResultArrayFirst objectAtIndex:6] forKey:@"q8"];
    [[NSUserDefaults standardUserDefaults] setValue:[answerResultArrayFirst objectAtIndex:7] forKey:@"q9"];
    [[NSUserDefaults standardUserDefaults] setValue:[answerResultArrayFirst objectAtIndex:8] forKey:@"q10"];
    [[NSUserDefaults standardUserDefaults] setValue:[answerResultArrayFirst objectAtIndex:9] forKey:@"q11"];
    [[NSUserDefaults standardUserDefaults] setValue:[answerResultArrayFirst objectAtIndex:10] forKey:@"q12"];
    [[NSUserDefaults standardUserDefaults] setValue:[answerResultArrayFirst objectAtIndex:11] forKey:@"q13"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.navigationController pushViewController:varQusAnsSecondPage animated:YES];
}

-(IBAction)setSeprateLabelLine {
    if (qusAnsSlider7.tag == 7) {
        [self calculateXpos:lbl_seprateQuestion7 ForView:bg_viewQus7];
    }
    if (qusAnsSlider8.tag == 8) {
        [self calculateXpos:lbl_seprateQuestion8 ForView:bg_viewQus8];
    }
    if (qusAnsSlider9.tag == 9) {
        [self calculateXpos:lbl_seprateQuestion9 ForView:bg_viewQus9];
    } 
    if (qusAnsSlider10.tag == 10) {
        [self calculateXpos:lbl_seprateQuestion10 ForView:bg_viewQus10];
    }
    if (qusAnsSlider11.tag == 11) {
        [self calculateXpos:lbl_seprateQuestion11 ForView:bg_viewQus11];
    }
    if (qusAnsSlider12.tag == 12) {
        [self calculateXpos:lbl_seprateQuestion12 ForView:bg_viewQus12];
    }
    if (qusAnsSlider13.tag == 13) {
        [self calculateXpos:lbl_seprateQuestion13 ForView:bg_viewQus13];
    }
    
}
-(IBAction)calculateXpos:(UILabel *)lbl_seprate ForView:(UIView *)bgView{
    NSInteger lbl_sep = 435/5;
    NSInteger xPos = 0;
    for (int i = 0; i < 5 + 1; i++) {
        lbl_seprate = [[UILabel alloc] initWithFrame:CGRectMake(xPos, 0, 1, 40)];
        [lbl_seprate setBackgroundColor:[UIColor darkGrayColor]];
        [bgView addSubview:lbl_seprate];
        xPos += lbl_sep;
    }
}
-(IBAction)SliderValueChangedFunction:(id)sender {
    UISlider *sliderValue = (UISlider *) sender;
    NSLog(@"sliderValue.tag  %d",sliderValue.tag);
    CGFloat value = sliderValue.value;
    double integer;
    double decimalvalue = modf(value, &integer) ;
    int INTEGER = (int)integer;
    
    
    CGFloat calculatedValue;
    if (decimalvalue > 0.5) {
        calculatedValue = INTEGER +1;
    }else
        calculatedValue = INTEGER;
    
    NSInteger val = calculatedValue;
    NSLog(@"%d",val);
    
    if ((sliderValue.tag == 3) || (sliderValue.tag == 4) || (sliderValue.tag == 5)) {
        if (sliderValue.tag == 3) {
            [answerResultArrayFirst replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@"%d",val]];
        }
        else if (sliderValue.tag == 4) {
            [answerResultArrayFirst replaceObjectAtIndex:2 withObject:[NSString stringWithFormat:@"%d",val]];
        }
        else if (sliderValue.tag == 5) {
            [answerResultArrayFirst replaceObjectAtIndex:3 withObject:[NSString stringWithFormat:@"%d",val]];
        }
    }
    else {
    popViewController = [[PopoverView alloc] initWithNibName:@"PopoverView" bundle:nil];
    popOverController = [[UIPopoverController alloc] initWithContentViewController:popViewController];
    popOverController.delegate = self;
    popViewController.displayPopOverValue.text = [sliderValueArray objectAtIndex:val];
    popOverController.popoverContentSize = CGSizeMake(700, 100);
    CGFloat xPos = ((435/5) *val);
    /*
    if (sliderValue.tag == 3) {
        NSLog(@"TAG #3");
        [answerResultArrayFirst replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@"%d",val]];
    }
    else if (sliderValue.tag == 4) {
        NSLog(@"TAG #4");
        [answerResultArrayFirst replaceObjectAtIndex:2 withObject:[NSString stringWithFormat:@"%d",val]];
    }
    else if (sliderValue.tag == 5) {
        NSLog(@"TAG #5");
        [answerResultArrayFirst replaceObjectAtIndex:3 withObject:[NSString stringWithFormat:@"%d",val]];
    }
    else */if (sliderValue.tag == 7) {
        [sliderValue setValue:val];
        [bg_viewQus7 addSubview:btn_seprateQuestion7];
        [btn_seprateQuestion7 setFrame:CGRectMake(xPos, 7, 10, 10)];
        
        [popOverController presentPopoverFromRect:[btn_seprateQuestion7 frame] inView:bg_viewQus7 permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
        [answerResultArrayFirst replaceObjectAtIndex:5 withObject:[NSString stringWithFormat:@"%d",val]];
    }
    else if (sliderValue.tag == 8) {
        [sliderValue setValue:val];
        [bg_viewQus8 addSubview:btn_seprateQuestion8];
        [btn_seprateQuestion8 setFrame:CGRectMake(xPos, 7, 10, 10)];
        
        [popOverController presentPopoverFromRect:[btn_seprateQuestion8 frame] inView:bg_viewQus8 permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
        [answerResultArrayFirst replaceObjectAtIndex:6 withObject:[NSString stringWithFormat:@"%d",val]];
    }
    else if (sliderValue.tag == 9) {
        [sliderValue setValue:val];
        [bg_viewQus9 addSubview:btn_seprateQuestion9];
        [btn_seprateQuestion9 setFrame:CGRectMake(xPos, 7, 10, 10)];
        
        [popOverController presentPopoverFromRect:[btn_seprateQuestion9 frame] inView:bg_viewQus9 permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
        [answerResultArrayFirst replaceObjectAtIndex:7 withObject:[NSString stringWithFormat:@"%d",val]];
    }
    else if (sliderValue.tag == 10) {
        [sliderValue setValue:val];
        [bg_viewQus10 addSubview:btn_seprateQuestion10];
        [btn_seprateQuestion10 setFrame:CGRectMake(xPos, 7, 10, 10)];
        
        [popOverController presentPopoverFromRect:[btn_seprateQuestion10 frame] inView:bg_viewQus10 permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
        [answerResultArrayFirst replaceObjectAtIndex:8 withObject:[NSString stringWithFormat:@"%d",val]];
    }
    else if (sliderValue.tag == 11) {
        [sliderValue setValue:val];
        [bg_viewQus11 addSubview:btn_seprateQuestion11];
        [btn_seprateQuestion11 setFrame:CGRectMake(xPos, 7, 10, 10)];
        
        [popOverController presentPopoverFromRect:[btn_seprateQuestion11 frame] inView:bg_viewQus11 permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
        [answerResultArrayFirst replaceObjectAtIndex:9 withObject:[NSString stringWithFormat:@"%d",val]];
    }
    else if (sliderValue.tag == 12) {
        [sliderValue setValue:val];
        [bg_viewQus12 addSubview:btn_seprateQuestion12];
        [btn_seprateQuestion12 setFrame:CGRectMake(xPos, 7, 10, 10)];
        
        [popOverController presentPopoverFromRect:[btn_seprateQuestion12 frame] inView:bg_viewQus12 permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
        [answerResultArrayFirst replaceObjectAtIndex:10 withObject:[NSString stringWithFormat:@"%d",val]];
    }
    else if (sliderValue.tag == 13) {
        [sliderValue setValue:val];
        [bg_viewQus13 addSubview:btn_seprateQuestion13];
        [btn_seprateQuestion13 setFrame:CGRectMake(xPos, 7, 10, 10)];
        
        [popOverController presentPopoverFromRect:[btn_seprateQuestion13 frame] inView:bg_viewQus13 permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
        [answerResultArrayFirst replaceObjectAtIndex:11 withObject:[NSString stringWithFormat:@"%d",val]];
    }
    }
    NSLog(@"ANSWER RESULT VALUE %@",answerResultArrayFirst);
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
