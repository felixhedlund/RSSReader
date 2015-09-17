//
//  AppDelegate.h
//  RSSReader
//
//  Created by Felix Hedlund on 16/09/2015.
//  Copyright (c) 2015 FelixHedlund. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContainerViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, UISplitViewControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property UISplitViewController* splitviewController;
@property ContainerViewController* containerViewController;

@end

