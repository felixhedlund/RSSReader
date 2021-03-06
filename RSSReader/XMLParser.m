//
//  XMLParser.m
//  RSSReader
//
//  Created by Felix Hedlund on 17/09/2015.
//  Copyright (c) 2015 FelixHedlund. All rights reserved.
//

#import "XMLParser.h"

@interface XMLParser ()

@end

@implementation XMLParser

- (id)init {
    self = [super init];
    if (self) {
        _arrParsedData = [[NSMutableArray alloc] init];
        _currentDataDictionary = [[NSMutableDictionary alloc] init];
        _currentElement = @"";
        _foundCharacters = @"";
        _linksArray = [[NSMutableArray alloc] init];
        _hasPrinted = 0;
    }
    return self;
}

- (void)startParsingWithContentsOfURL: (NSURL*)rssURL{
    NSXMLParser* parser = [[NSXMLParser alloc] initWithContentsOfURL:rssURL];
    parser.delegate = self;
    [parser parse];
}

- (void)parser: (NSXMLParser*)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    _currentElement = elementName;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    if([_currentElement  isEqual: @"title"] || [_currentElement  isEqual: @"link"] || [_currentElement  isEqual: @"pubDate"]){
        _foundCharacters = [_foundCharacters stringByAppendingString:string];
        
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    if ([_foundCharacters length] > 0) {
        if ([elementName isEqual:@"link"]) {
            _foundCharacters = [_foundCharacters stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            [_linksArray addObject:_foundCharacters];
        }
        
        [_currentDataDictionary setValue:_foundCharacters forKey:_currentElement];
        _foundCharacters = @"";
        
        
        
        if ([_currentElement isEqual:@"pubDate"]) {
            [_arrParsedData addObject:_currentDataDictionary.copy];
        }
        
    }
}

- (void) parserDidEndDocument:(NSXMLParser *)parser{
    
    [_delegate parsingWasFinished];
    
}

- (void) parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
    NSLog(@"%@",parseError.description);
}

- (void)parser:(NSXMLParser *)parser validationErrorOccurred:(NSError *)validationError{
    NSLog(@"%@",validationError.description);
}

@end

