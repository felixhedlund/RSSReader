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
@interface NewsTopicsTableViewController : UITableViewController <XMLParserDelegate>
@property (weak) IBOutlet UIImageView* rssImage;
@property XMLParser* xmlParser;
@property NSArray* urlArray;
//var xmlParser : XMLParser!
//@IBOutlet weak var slideshowButton: UIButton!
//var urlArray: NSArray!
//weak var parentSlideShowViewController: ParentSlideShowViewController!
//
//var hideContentView: UIView!
//var hideImage: UIImageView!
//var slideShowHasBeenShown: Bool!
@end

