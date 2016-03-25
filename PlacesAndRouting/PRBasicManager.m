//
//  PRBasicManager.m
//  PlacesAndRouting
//
//  Created by Sascha Müllner on 15.03.16.
//  Copyright © 2016 smuellner. All rights reserved.
//

#import "PRBasicManager.h"

@interface PRBasicManager()
@property (readwrite) NSString *appId;
@property (readwrite) NSString *appCode;
@end

@implementation PRBasicManager
+ (instancetype)manager {
    return [[self alloc] init];
}

- (instancetype)init {
    if (self = [super init]) {
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        self.appId = infoDictionary[@"PRHereAppId"];
        self.appCode = infoDictionary[@"PRHereAppCode"];
    }
    return self;
}
@end
