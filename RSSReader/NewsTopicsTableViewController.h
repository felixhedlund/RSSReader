//
//  NewsTopicsTableViewController.h
//  RSSReader
//
//  Created by Felix Hedlund on 17/09/2015.
//  Copyright (c) 2015 FelixHedlund. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMLParser.h"
#import "PopoverViewController.h"
@class XMLParser;
@interface NewsTopicsTableViewController : UITableViewController <XMLParserDelegate, UIPopoverPresentationControllerDelegate, UITextFieldDelegate>
@property UIBarButtonItem* rssButton;

@property XMLParser* xmlParser;
@property NSArray* urlArray;
@property PopoverViewController* popController;
- (IBAction)showRSSPopover:(id)sender;
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller;

@end

