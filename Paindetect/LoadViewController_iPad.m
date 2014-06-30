    //
//  LoadViewController_iPad.m
//  i519HD_Universal
//
//  Created by apple on 11-6-28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LoadViewController_iPad.h"
#import "PatientHistoryView.h"
#import "AllListView.h"

#define kTagOfProgressView		123

@implementation LoadViewController_iPad

@synthesize webView;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[webView setDelegate:self];
	
    self.navigationItem.title = @"疼痛量表";
   self.navigationItem.hidesBackButton = YES;
    
	NSString *path=[[NSBundle mainBundle]pathForResource:@"paindetect" ofType:@"html"];
	[webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]]];
    //gittest
}

//UIAlertView *myAlert;

- (void)webViewDidStartLoad:(UIWebView *)webView{

}

- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
	NSString *requestString = [[request URL] absoluteString];
	//NSArray *components = [requestString componentsSeparatedByString:@"::"];
    if ([[requestString substringToIndex:4] isEqualToString:@"http"]){
	if ([requestString isEqualToString:@"http://input/"]) {
		PatientHistoryView *patienthistoryview = [[PatientHistoryView alloc] initWithNibName:@"PatientHistoryView" bundle:nil];
        [self.navigationController pushViewController:patienthistoryview animated:YES];
        
        
        return NO;

	}else if([requestString isEqualToString:@"http://record/"]){
        AllListView *aview = [[AllListView alloc] initWithNibName:@"AllListView" bundle:nil];
        [self.navigationController pushViewController:aview animated:YES];
        
        
        return NO;
    }
    else {
        NSURL *requestURL =[ [ request URL ] retain ];
        [ [ UIApplication sharedApplication ] openURL: [ requestURL autorelease ] ];
        [ requestURL release ];
        return NO;
    }
    }
    
    return YES;
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
	//self.view.autoresizesSubviews=TRUE;
	//self.view.autoresizingMask=TRUE;
	//webView.reload;
	return NO;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	//[myAlert release];
    [super dealloc];
}

@end
