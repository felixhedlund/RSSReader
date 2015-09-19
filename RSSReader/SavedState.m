//
//  SavedState.m
//  RSSReader
//
//  Created by Felix Hedlund on 18/09/2015.
//  Copyright © 2015 FelixHedlund. All rights reserved.
//

#import "SavedState.h"

@interface SavedState ()

@end

static SavedState* sharedState = nil;

@implementation SavedState

+ (SavedState*)sharedInstance {
    if(!sharedState){
        sharedState = [[self alloc] init];
    }
    return sharedState;
}
- (id)init {
    if (self = [super init]) {
        _rssURL = [[NSURL alloc] initWithString:@"http://www.aftonbladet.se/rss.xml"];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        _rssURL = [defaults URLForKey:@"rssURL"];
    }
    return self;
}
- (void) saveState{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setURL:_rssURL forKey:@"rssURL"];
    [defaults synchronize];
}

@end