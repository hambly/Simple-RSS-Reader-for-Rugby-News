//
//  RSSItem.m
//  Nerdfeed
//
//  Created by Mark on 2/13/13.
//  Copyright (c) 2013 Mark Hambly. All rights reserved.
//

#import "RSSItem.h"

@implementation RSSItem
@synthesize title, link, parentParserDelegate;

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
//    NSLog(@"\t\t%@ found a %@ element", self, elementName);
    if([elementName isEqual:@"title"]) {
        currentString = [[NSMutableString alloc] init];
        [self setTitle:currentString];
	} else if([elementName isEqual:@"description"]) {
        currentString = [[NSMutableString alloc] init];
        self.description = currentString;
    } else if ([elementName isEqual:@"link"]) {
        currentString = [[NSMutableString alloc] init];
        [self setLink:currentString];
    } else if ([elementName isEqual:@"pubDate"]) {
        currentString = [[NSMutableString alloc] init];
        self.date = currentString;
	}
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)str {
    [currentString appendString:str];
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    currentString = nil;
    if ([elementName isEqual:@"item"]) {
        [parser setDelegate:parentParserDelegate];
    }
}

@end
