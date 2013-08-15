//
//  RSSChannel.m
//  Nerdfeed
//
//  Created by Mark on 2/13/13.
//  Copyright (c) 2013 Mark Hambly. All rights reserved.
//

#import "RSSChannel.h"
#import "RSSItem.h"

@implementation RSSChannel {
	NSMutableString *_currentString;
}

-(id) init {
    self = [super init];
    
    if(self) {
        _items = [[NSMutableArray alloc]init];
    }
    return self;
}

-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
//    NSLog(@"\t%@ found a %@ element", self, elementName);
    
    if ([elementName isEqual:@"title"]) {
        _currentString = [[NSMutableString alloc] init];
        self.infoString = _currentString;
    }
    else if ([elementName isEqual:@"description"]) {
        _currentString = [[NSMutableString alloc] init];
        self.infoString = _currentString;
    }
    else if ([elementName isEqual:@"item"]) {
        RSSItem *entry = [[RSSItem alloc] init];
        [entry setParentParserDelegate:self];
        [parser setDelegate:entry];
        [self.items addObject:entry];
        
    }
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)str {
    [_currentString appendString:str];
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    _currentString = nil;
    if([elementName isEqual:@"channel"]) {
        [parser setDelegate:self.parentParserDelegate];
    }
}

@end
