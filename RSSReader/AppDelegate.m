//
//  AppDelegate.m
//  RSSReader
//
//  Created by Felix Hedlund on 16/09/2015.
//  Copyright (c) 2015 FelixHedlund. All rights reserved.
//

#import "AppDelegate.h"
#import "ContainerViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _splitviewController = [[UIStoryboard storyboardWithName:@"Main" bundle: nil]        instantiateViewControllerWithIdentifier:@"idSplitViewController"];
    _splitviewController.delegate = self;
    _splitviewController.preferredDisplayMode = UISplitViewControllerDisplayModeAllVisible;
    _containerViewController = [[ContainerViewController alloc] init];
    [_containerViewController setEmbeddedViewController:_splitviewController];
    _window.rootViewController = _containerViewController;
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

@end
