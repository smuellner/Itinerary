//
//  CLLocation+Dictionary.m
//  PlacesAndRouting
//
//  Created by Sascha Müllner on 18.03.16.
//  Copyright © 2016 smuellner. All rights reserved.
//

#import "CLLocation+Dictionary.h"

@implementation CLLocation (Dictionary)
+ (instancetype)initWithDictionary:(NSDictionary *)dict
{
    if([dict objectForKey:@"latitude"] && [dict objectForKey:@"longitude"]) {
        return [[CLLocation alloc] initWithLatitude:[[dict objectForKey:@"latitude"] doubleValue]
                                          longitude:[[dict objectForKey:@"longitude"] doubleValue]];
    }
    return nil;
}

- (NSDictionary *)toDictionary {
    return @{@"latitude" : @(self.coordinate.latitude),
             @"longitude" : @(self.coordinate.longitude)};
}

@end