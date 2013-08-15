//
//  MainTableViewController.m
//  Rugby
//
//  Created by Mark on 8/15/13.
//  Copyright (c) 2013 Mark Hambly. All rights reserved.
//

/*
 ITM - http://www.planetrugby.com/rss/0,16039,3826,00.xml
 World Championship - http://www.planetrugby.com/rss/0,16039,3821,00.xml
 SUperrugby - http://www.planetrugby.com/rss/0,16039,3824,00.xml
 World Cup - http://www.planetrugby.com/rss/0,16039,3818,00.xml
 */

#import "MainTableViewController.h"
#import "MainTableViewCell.h"
#import "RSSChannel.h"
#import "RSSItem.h"
#import "WebViewController.h"

@interface MainTableViewController () 

@end

@implementation MainTableViewController {
	NSURLConnection *_connection;
	NSMutableData *_xmlData;
	RSSChannel *_channel;
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString:@"TableViewSegueToWebView"]){
		WebViewController *webViewController = segue.destinationViewController;
		RSSItem *entry = _channel.items[self.tableView.indexPathForSelectedRow.row];
		NSURL *url = [NSURL URLWithString:entry.link];
		NSLog(@"Trying to view link: %@",url);
		NSURLRequest *request = [NSURLRequest requestWithURL:url];
		[webViewController.webView loadRequest:request];
	}
}

#pragma mark - NSURL Connection

-(void) fetchEntries {
	_xmlData = [[NSMutableData alloc] init];
	NSURL *url = self.feedSelected;
//	NSURL *url = [NSURL URLWithString:@"http://www.rsspect.com/rss/qwantz.xml"];
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	_connection = [[NSURLConnection alloc] initWithRequest:request
												  delegate:self
										  startImmediately:YES];
}

-(void) connection:(NSURLConnection *)conn didReceiveData:(NSData *)data {
    [_xmlData appendData:data];
}

-(void) connectionDidFinishLoading: (NSURLConnection *)conn {
	NSXMLParser *parser = [[NSXMLParser alloc] initWithData:_xmlData];
	[parser setDelegate:self];
	[parser parse];
	_connection = nil;
	[self.tableView reloadData];
}

-(void) connection:(NSURLConnection *) connection didFailWithError:(NSError *)error {
	_connection = nil;
	_xmlData = nil;
	NSString *errorString = [NSString stringWithFormat:@"Fetch failed: %@",[error localizedDescription]];
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
													message:errorString
												   delegate:nil
										  cancelButtonTitle:@"OK"
										  otherButtonTitles:nil];
	[alert show];
}

#pragma mark - NSXMLParser Delegate Methods

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
	
	if([elementName isEqual:@"channel"]) {
        //If the parser saw a channel create a new instance
        _channel = [[RSSChannel alloc]init];
        
        //Give the channel object a pointer back to ourselves for later
        [_channel setParentParserDelegate:self];
        
        //Set the parser's delegate to the channel object
        [parser setDelegate:_channel];
    }
	
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _channel.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MainTableViewCell";
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    RSSItem *item = [[_channel items] objectAtIndex:indexPath.row];
	cell.headlineLabel.text = item.title;
	cell.snippetLabel.text = item.description;
    
    return cell;
}



@end
