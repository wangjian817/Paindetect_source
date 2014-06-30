//
//  BodyView.m
//  Paindetect
//
//  Created by jegan selvaraj on 4/10/12.
//  Copyright (c) 2012 blisslogix. All rights reserved.
//

#import "BodyView.h"
#import "DataManager.h"
#import "Reachability.h"

@implementation BodyView

@synthesize submitbtn;
@synthesize localdict,selectValueArray;

@synthesize bg_image;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        localdict = [[NSMutableDictionary alloc] init];
        selectValueArray = [[NSMutableArray alloc] init];
        
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(IBAction)selectedImgPart:(id)sender {
    UIButton *btn = (UIButton *)sender;
    NSLog(@"SELECTED PART TAG  %d",btn.tag);

   btn.selected =! btn.isSelected;
    if (btn.selected == YES) {
        [selectValueArray addObject:[NSString stringWithFormat:@"%d",btn.tag]];
    } else if (btn.selected == NO) {

        NSInteger sel = [selectValueArray indexOfObject:[NSString stringWithFormat:@"%d",btn.tag]];
        if (sel!=-1 ) {
            [selectValueArray removeObjectAtIndex:sel];
        }
    }
    [localdict setValue:(NSMutableArray *)selectValueArray forKey:k_SelectedBodyValue];
    NSLog(@"Selected Dict  %@",localdict);
}

#pragma mark - View lifecycle

-(IBAction)submitaction
{
    /*NSMutableDictionary *userDict = [[NSMutableDictionary alloc] init];
    [userDict setValue:[[NSUserDefaults standardUserDefaults] valueForKey:k_painid] forKey:k_painid];
    [userDict setValue:[[NSUserDefaults standardUserDefaults] valueForKey:k_patientid] forKey:k_patientid];
    [userDict setValue:(NSMutableArray *)selectValueArray forKey:k_bodydetails];
    
    [[NSUserDefaults standardUserDefaults] setValue:userDict forKey:k_painSelectedBodyValue];
    [[NSUserDefaults standardUserDefaults] synchronize];*/
    
    [[NSUserDefaults standardUserDefaults] setValue:(NSMutableArray *)selectValueArray forKey:k_bodydetails];
    [[NSUserDefaults standardUserDefaults] synchronize];
     
    /*if(([[Reachability reachabilityForInternetConnection] currentReachabilityStatus]==ReachableViaWiFi)||([[Reachability reachabilityForInternetConnection] currentReachabilityStatus]==ReachableViaWWAN)) {

    [localdict setValue:[NSString stringWithFormat:@"1"] forKey:k_QusAnsDetailQuestionNumber];
    DataManagerr *dataMana = [[DataManagerr alloc] initWithDelegate:self];
    [dataMana executeRequestWithType:AddPatientPainDetailsInDB andDictionary:localdict];
    }
    else {
        Database *dataBase = [[Database alloc] init];
        [dataBase initWithSqliteOpen];
        [dataBase insertbodydetails:userDict];
        NSString *painStr = [dataBase getPainIDStr];
        NSLog(@"PainStr  %@",painStr);
        [dataBase initWithSqliteClose];
        
        [[NSUserDefaults standardUserDefaults] setValue:painStr forKey:k_painid];
        [[NSUserDefaults standardUserDefaults] synchronize];
        QusAnsFirstPage *firstViewController = [[QusAnsFirstPage alloc] initWithNibName:@"QusAnsFirstPage" bundle:nil];
        [self.navigationController pushViewController:firstViewController animated:YES]; 
    }*/
    
    QusAnsFirstPage *firstViewController = [[QusAnsFirstPage alloc] initWithNibName:@"QusAnsFirstPage" bundle:nil];
    [self.navigationController pushViewController:firstViewController animated:YES];
    
//    QusAnsFirstPage *viewController = [[QusAnsFirstPage alloc] initWithNibName:@"QusAnsFirstPage" bundle:nil];
//    [self.navigationController pushViewController:viewController animated:YES];
    
    //    [[DataManager sharedmanager] loadNextView:self];
    //[datamanager loadNextView:self];
}

-(void)dataManagerDidFinishLoading:(DataManagerr *)dMange {
    if ([dMange.resultedDictionary valueForKey:@"AddPatientPainDetailsInDBResult"] > 0) {
        [[NSUserDefaults standardUserDefaults] setValue:[dMange.resultedDictionary valueForKey:@"AddPatientPainDetailsInDBResult"] forKey:k_PainDetID];
        QusAnsFirstPage *firstViewController = [[QusAnsFirstPage alloc] initWithNibName:@"QusAnsFirstPage" bundle:nil];
        [self.navigationController pushViewController:firstViewController animated:YES];
    }
}

- (void)viewDidLoad
{
    [bg_image setBackgroundColor:[UIColor colorWithRed:(224.0/255.0) green:(224.0/255.0) blue:(224.0/255.0) alpha:1.0]];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:(106.0/255.0) green:(106.0/255.0) blue:(106.0/255.0) alpha:1.0];
    self.navigationItem.title = @"请在下图中标注您疼痛发作的主要部位";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"下一步" style:UIBarButtonItemStyleBordered target:self action:@selector(submitaction)];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"上一步" style:UIBarButtonItemStyleBordered target:self action:@selector(backButtonMove)];
        [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)backButtonMove {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated {
    DataManager *dataManager = [[DataManager alloc] init];
    [dataManager executeRequest];
}
-(void)viewWillDisappear:(BOOL)animated {
    DataManager *dataManager = [[DataManager alloc] init];
    [dataManager executeRequest];
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
