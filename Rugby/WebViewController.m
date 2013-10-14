//
//  WebViewController.m
//  Rugby
//
//  Created by Mark on 8/15/13.
//  Copyright (c) 2013 Mark Hambly. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation WebViewController

-(UIStatusBarStyle) preferredStatusBarStyle	{
	return UIStatusBarStyleDefault;
}


-(void) viewDidLoad {
	[super viewDidLoad];
	
	self.webView.delegate = self;

    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
    [self.webView loadRequest:request];

	UISwipeGestureRecognizer *rightSwipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeRight:)];
	[rightSwipeRecognizer setDirection:UISwipeGestureRecognizerDirectionRight];
	[rightSwipeRecognizer setNumberOfTouchesRequired:1];
	[self.view addGestureRecognizer:rightSwipeRecognizer];


}

-(IBAction)didSwipeRight:(id)sender {
	[self performSegueWithIdentifier:@"UnwindSegueFromWebViewToMainView" sender:self];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	[self.activityIndicator stopAnimating];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
	[self.activityIndicator stopAnimating];

}


@end
