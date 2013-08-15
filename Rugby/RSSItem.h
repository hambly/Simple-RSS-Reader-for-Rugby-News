//
//  RSSItem.h
//  Nerdfeed
//
//  Created by Mark on 2/13/13.
//  Copyright (c) 2013 Mark Hambly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSSItem : NSObject <NSXMLParserDelegate>
{
    NSMutableString *currentString;
}

@property (nonatomic, weak) id parentParserDelegate;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *link;

@end
