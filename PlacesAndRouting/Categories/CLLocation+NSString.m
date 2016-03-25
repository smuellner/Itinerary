//
//  CLLocation+NSString.m
//  PlacesAndRouting
//
//  Created by Sascha Müllner on 20.03.16.
//  Copyright © 2016 smuellner. All rights reserved.
//

#import "CLLocation+NSString.h"

@implementation CLLocation (NSString)
+ (instancetype)initWithString:(NSString *)string
{
    NSArray *coordinates = [string componentsSeparatedByString: @","];
    if (coordinates.count == 2) {
        return [[CLLocation alloc] initWithLatitude:[[coordinates objectAtIndex:0] doubleValue]
                                          longitude:[[coordinates objectAtIndex:1] doubleValue]];
    }
    return nil;
}

- (NSString *)toString {
    return [NSString stringWithFormat:@"%f,%f", self.coordinate.latitude, self.coordinate.longitude];
}
@end
