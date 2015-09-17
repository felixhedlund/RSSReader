//
//  XMLParser.h
//  RSSReader
//
//  Created by Felix Hedlund on 17/09/2015.
//  Copyright (c) 2015 FelixHedlund. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol XMLParserDelegate
- (void)parsingWasFinished;
@end

@interface XMLParser : NSObject <NSXMLParserDelegate>

@property NSMutableArray* arrParsedData;
@property NSDictionary* currentDataDictionary;
@property NSString* currentElement;
@property NSString* foundCharacters;
@property NSMutableArray* linksArray;
@property int hasPrinted;
@property id<XMLParserDelegate> delegate;

- (void)startParsingWithContentsOfURL: (NSURL*)rssURL;

//var arrParsedData = [Dictionary<String, String>]()
//var currentDataDictionary = Dictionary<String, String>()
//var currentElement = ""
//var foundCharacters = ""
//var linksArray = NSMutableArray()
//
//var hasPrinted = 0
//
//var delegate : XMLParserDelegate?

@end
