//
//  WebViewController.m
//  Rugby
//
//  Created by Mark on 8/15/13.
//  Copyright (c) 2013 Mark Hambly. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

-(void) viewDidLoad {
	[super viewDidLoad];

	UISwipeGestureRecognizer *rightSwipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeRight:)];
	[rightSwipeRecognizer setDirection:UISwipeGestureRecognizerDirectionRight];
	[rightSwipeRecognizer setNumberOfTouchesRequired:1];
	[self.view addGestureRecognizer:rightSwipeRecognizer];

}

-(IBAction)didSwipeRight:(id)sender {
	[self performSegueWithIdentifier:@"UnwindSegueFromWebViewToMainView" sender:self];
}

@end
