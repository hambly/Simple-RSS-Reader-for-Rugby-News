//
//  RSSChannel.m
//  Nerdfeed
//
//  Created by Mark on 2/13/13.
//  Copyright (c) 2013 Mark Hambly. All rights reserved.
//

#import "RSSChannel.h"
#import "RSSItem.h"

@implementation RSSChannel
@synthesize items, title, infoString, parentParserDelegate;

-(id) init {
    self = [super init];
    
    if(self) {
        //Create the container for the RSSItems
        items = [[NSMutableArray alloc]init];
    }
    return self;
}

-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
//    NSLog(@"\t%@ found a %@ element", self, elementName);
    
    if ([elementName isEqual:@"title"]) {
        currentString = [[NSMutableString alloc] init];
        [self setInfoString:currentString];
    }
    else if ([elementName isEqual:@"description"]) {
        currentString = [[NSMutableString alloc] init];
        [self setInfoString:currentString];
    }
    else if ([elementName isEqual:@"item"]) {
        //when we find an item, create an instance of RSSItem
        RSSItem *entry = [[RSSItem alloc] init];
        
        //Set up its parent as ourselves so we can regain control of the parser
        [entry setParentParserDelegate:self];
        
        //Turn the parser to the RSSItem
        [parser setDelegate:entry];
        
        //Add the item to our array and release our hold on it
        [items addObject:entry];
        
    }
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)str {
    [currentString appendString:str];
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    currentString = nil;
    if([elementName isEqual:@"channel"]) {
        [parser setDelegate:parentParserDelegate];
    }
}

@end
