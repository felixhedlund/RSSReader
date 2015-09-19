//
//  SavedState.h
//  RSSReader
//
//  Created by Felix Hedlund on 18/09/2015.
//  Copyright © 2015 FelixHedlund. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SavedState: NSObject

@property NSURL* rssURL;
- (void)saveState;
+ (SavedState*)sharedInstance;
@end
