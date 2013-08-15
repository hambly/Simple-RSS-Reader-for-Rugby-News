//
//  MainTableViewController.h
//  Rugby
//
//  Created by Mark on 8/15/13.
//  Copyright (c) 2013 Mark Hambly. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainViewController;

@interface MainTableViewController : UITableViewController <NSXMLParserDelegate>

-(void) fetchEntries;

@property (nonatomic, strong) NSURL* feedSelected;

@property (nonatomic, weak) UIActivityIndicatorView *activityIndicator;

@end
