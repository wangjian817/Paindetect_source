//
//  BodyView.h
//  Paindetect
//
//  Created by jegan selvaraj on 4/10/12.
//  Copyright (c) 2012 blisslogix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManagerr.h"
#import "QusAnsFirstPage.h"
#import "Database.h"

@interface BodyView : UIViewController<DataManagerDelegate>
{
    IBOutlet UIButton *submitbtn;
    NSMutableDictionary *localdict;
}

@property (nonatomic, retain) UIButton *submitbtn;
@property (nonatomic, retain) NSMutableDictionary *localdict;

@property (nonatomic ,retain) NSMutableArray *selectValueArray;

-(IBAction)submitaction;
-(IBAction)selectedImgPart:(id)sender;
@property (nonatomic, retain) IBOutlet UIImageView *bg_image;
-(void)backButtonMove;
@end
