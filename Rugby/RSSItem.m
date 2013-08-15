//
//  RSSItem.m
//  Nerdfeed
//
//  Created by Mark on 2/13/13.
//  Copyright (c) 2013 Mark Hambly. All rights reserved.
//

#import "RSSItem.h"

@implementation RSSItem {
    NSMutableString *_currentString;
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
//    NSLog(@"\t\t%@ found a %@ element", self, elementName);
    
	if([elementName isEqual:@"title"]) {
        _currentString = [[NSMutableString alloc] init];
        self.title = _currentString;
	} else if([elementName isEqual:@"description"]) {
        _currentString = [[NSMutableString alloc] init];
        self.description = _currentString;
    } else if ([elementName isEqual:@"link"]) {
        _currentString = [[NSMutableString alloc] init];
        self.link = _currentString;
    } else if ([elementName isEqual:@"pubDate"]) {
        _currentString = [[NSMutableString alloc] init];
        self.date = _currentString;
	}
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)str {
    [_currentString appendString:str];
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    _currentString = nil;
    if ([elementName isEqual:@"item"]) {
        [parser setDelegate:self.parentParserDelegate];
    }
}

@end
