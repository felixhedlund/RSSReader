//
//  ContainerViewController.m
//  RSSReader
//
//  Created by Felix Hedlund on 16/09/2015.
//  Copyright (c) 2015 FelixHedlund. All rights reserved.
//

#import "ContainerViewController.h"

@interface ContainerViewController ()

@end

@implementation ContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    CGFloat viewControllerMaximumPrimaryColumnWidth = self.viewController.maximumPrimaryColumnWidth;
    self.maximumColumnWidth = &(viewControllerMaximumPrimaryColumnWidth);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setEmbeddedViewController:(UISplitViewController*)splitViewController{
    
    if (splitViewController != nil) {
        _viewController = splitViewController;
        [self addChildViewController:_viewController];
        [self.view addSubview:_viewController.view];
        [_viewController didMoveToParentViewController:self];
        [self setOverrideTraitCollection:[UITraitCollection traitCollectionWithHorizontalSizeClass:UIUserInterfaceSizeClassRegular] forChildViewController:_viewController];
    }
    
}

@end
