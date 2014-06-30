//
//  ActivationView.h
//  Paindetect
//
//  Created by jegan selvaraj on 4/10/12.
//  Copyright (c) 2012 blisslogix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManagerr.h"
#import "Database.h"

@interface ActivationView : UIViewController <DataManagerDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate>
{
    IBOutlet UITextField *activationtextfield;
    IBOutlet UIButton *submit;
    NSMutableDictionary *localdict;
}

@property (nonatomic, retain) UITextField *activationtextfield;
@property (nonatomic, retain) UIButton *submit;
@property (nonatomic, retain) NSMutableDictionary *localdict;
-(IBAction)submitbutton;
-(void)alertViewMethod:(NSString *)msg;
@property (nonatomic, retain) NSMutableArray *activitationCodeArray;

@property (nonatomic, retain) IBOutlet UIView *pickerView;
@property (nonatomic, retain) IBOutlet UIPickerView *dataPicker;
@property (nonatomic, retain) IBOutlet UIImageView *bg_image;
-(void)goPatientView;
@end
