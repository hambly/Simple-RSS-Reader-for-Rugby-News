//
//  MainViewController.m
//  Rugby
//
//  Created by Mark on 8/15/13.
//  Copyright (c) 2013 Mark Hambly. All rights reserved.
//

#import "MainViewController.h"
#import "MainTableViewController.h"

@interface MainViewController ()

@property (nonatomic, weak) MainTableViewController *mainTableViewController;
@property (weak, nonatomic) IBOutlet UISegmentedControl *feedSelectSegmentedControl;

@end

@implementation MainViewController {
	NSURL *_feedSelected;
}


-(void) viewDidLoad{
	[super viewDidLoad];
	
//	NSLog(@"%@", [UIFont fontNamesForFamilyName:@"Avenir Next"]);
	
	UIFont *font = [UIFont fontWithName:@"AvenirNext-Regular" size:12.0f];
	NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:UITextAttributeFont];
	[self.feedSelectSegmentedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
	
}
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString:@"EmbedTableView"]){
		[self setFeed];
		self.mainTableViewController = segue.destinationViewController;
		self.mainTableViewController.activityIndicator = self.activityIndicator;
		self.mainTableViewController.feedSelected = _feedSelected;
		
		[self.activityIndicator startAnimating];
		[self.mainTableViewController fetchEntries];
	}
}

- (IBAction)refreshButtonPressed:(id)sender {
	[self.activityIndicator startAnimating];
	[self.mainTableViewController fetchEntries];
}

- (IBAction)feedSelectSegmentedControlValueChanged:(id)sender {
	[self setFeed];
	self.mainTableViewController.feedSelected = _feedSelected;
	[self.activityIndicator startAnimating];
	[self.mainTableViewController fetchEntries];
}

-(void) setFeed {
	if (self.feedSelectSegmentedControl.selectedSegmentIndex){
		_feedSelected = [self listOfFeeds][self.feedSelectSegmentedControl.selectedSegmentIndex];
	} else {
		_feedSelected = [self listOfFeeds][0];
	}
}

-(NSArray*) listOfFeeds {
	
	/*
	 World Championship (Quad) - http://www.planetrugby.com/rss/0,16039,3821,00.xml
	 ITM - http://www.planetrugby.com/rss/0,16039,3826,00.xml
	 SUperrugby - http://www.planetrugby.com/rss/0,16039,3824,00.xml
	 World Cup - http://www.planetrugby.com/rss/0,16039,3818,00.xml
	 */
	
	NSArray *urlStringArray = @[
						@"http://www.planetrugby.com/rss/0,16039,3821,00.xml",
					   @"http://www.planetrugby.com/rss/0,16039,3826,00.xml",
					   @"http://www.planetrugby.com/rss/0,16039,3824,00.xml",
					   @"http://www.planetrugby.com/rss/0,16039,3818,00.xml"];
	NSURL *url;
	NSMutableArray *urlArray = [NSMutableArray new];
	
	for (NSString *string in urlStringArray){
		url = [NSURL URLWithString:string];
		[urlArray addObject:url];
	}
	
	return urlArray;
}

-(IBAction) unwindToMainView: (UIStoryboardSegue *) segue {
	
}

@end
