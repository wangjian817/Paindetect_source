//
//  LoadViewController_iPad.h
//  i519HD_Universal
//
//  Created by apple on 11-6-28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadViewController_iPad : UIViewController<UIWebViewDelegate,NSXMLParserDelegate> {
	IBOutlet UIWebView *webView;
	UIAlertView *myAlertD;
}

@property(nonatomic,retain)IBOutlet UIWebView *webView;

-(IBAction)switchToMenuViews:(id)sender;

@end
