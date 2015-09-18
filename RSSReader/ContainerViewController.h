//
//  ContainerViewController.h
//  RSSReader
//
//  Created by Felix Hedlund on 16/09/2015.
//  Copyright (c) 2015 FelixHedlund. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContainerViewController : UIViewController

@property UISplitViewController* viewController;
@property CGFloat maximumColumnWidth;

- (void)setEmbeddedViewController:(UISplitViewController*)splitViewController;
-(void) hideNewsTopics;
-(void) showNewsTopics;
@end
