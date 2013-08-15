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

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString:@"EmbedTableView"]){
		[self setFeed];
		self.mainTableViewController = segue.destinationViewController;
		self.mainTableViewController.feedSelected = _feedSelected;
		[self.mainTableViewController fetchEntries];
	}
}

- (IBAction)refreshButtonPressed:(id)sender {
	[self.mainTableViewController fetchEntries];
}

- (IBAction)feedSelectSegmentedControlValueChanged:(id)sender {
	[self setFeed];
	self.mainTableViewController.feedSelected = _feedSelected;
	[self.mainTableViewController fetchEntries];
}

-(void) setFeed {
	if (self.feedSelectSegmentedControl.selectedSegmentIndex){
		_feedSelected = [self listOfFeeds][self.feedSelectSegmentedControl.selectedSegmentIndex];
		NSLog(@"feed selected: %@",_feedSelected);
	} else {
		_feedSelected = [self listOfFeeds][0];
		NSLog(@"feed selected: %@",_feedSelected);
	}
}

-(NSArray*) listOfFeeds {
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
