//
//  NewsTopicsTableViewController.h
//  RSSReader
//
//  Created by Felix Hedlund on 17/09/2015.
//  Copyright (c) 2015 FelixHedlund. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMLParser.h"

@class XMLParser;
@interface NewsTopicsTableViewController : UITableViewController <XMLParserDelegate, UIPopoverPresentationControllerDelegate>
@property UIBarButtonItem* rssButton;

@property XMLParser* xmlParser;
@property NSArray* urlArray;
- (IBAction)showRSSPopover:(id)sender;
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller;

@end

