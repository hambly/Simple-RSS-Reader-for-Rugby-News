//
//  RSSChannel.h
//  Nerdfeed
//
//  Created by Mark on 2/13/13.
//  Copyright (c) 2013 Mark Hambly. All rights reserved.
//

@interface RSSChannel : NSObject <NSXMLParserDelegate>

@property (nonatomic, weak) id parentParserDelegate;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *infoString;
@property (nonatomic, readonly, strong) NSMutableArray *items;

@end
