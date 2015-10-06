//
//  RCTCardIOUtilities.m
//  RCTCardIO
//
//  Created by Roger Chapman on 4/10/2015.
//  Copyright © 2015 Kayla Technologies. All rights reserved.
//

#import "RCTCardIOUtilities.h"
#import "CardIOUtilities.h"
#import "RCTBridge.h"
#import "RCTUtils.h"

@implementation RCTCardIOUtilities

RCT_EXPORT_MODULE();

@synthesize bridge = _bridge;

- (NSDictionary *)constantsToExport {
    NSString *libraryVersion = [CardIOUtilities libraryVersion];
    BOOL canReadCardWithCamera = [CardIOUtilities canReadCardWithCamera];
    return @{
             @"libraryVersion" : (libraryVersion),
             @"canReadCardWithCamera": @(canReadCardWithCamera),
             };
}

RCT_EXPORT_METHOD(preload:(nonnull NSNumber *)reactTag) {
    [CardIOUtilities preload];
}

@end
