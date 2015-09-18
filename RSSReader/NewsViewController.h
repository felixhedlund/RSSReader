//
//  NewsViewController.h
//  RSSReader
//
//  Created by Felix Hedlund on 17/09/2015.
//  Copyright (c) 2015 FelixHedlund. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsViewController : UIViewController
@property (weak) IBOutlet UIWebView* webView;
@property NSURL* newsURL;
@property (weak) IBOutlet UIView* hideContentView;
@property UIImageView* hideImage;
@property BOOL newsTopicsIsHidden;

- (void) showWebContent;
- (void) hideButtonPressed:(UIButton *) sender;

@end
