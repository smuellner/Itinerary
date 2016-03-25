//
//  PRRoute.m
//  PlacesAndRouting
//
//  Created by Sascha Müllner on 18.03.16.
//  Copyright © 2016 smuellner. All rights reserved.
//

#import "PRRoute.h"
#import "CLLocation+NSString.h"

@implementation PRRoute

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"waypoint" : [PRWaypoint class],
             @"leg" : [PRLeg class]};
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dict {
    NSArray *coordinates = dict[@"shape"];
    if ([coordinates isKindOfClass:[NSArray class]]) {
        NSMutableArray *shapes = [NSMutableArray array];
        for (NSString *coordinate in coordinates) {
            CLLocation *location = [CLLocation initWithString:coordinate];
            if(nil != location) {
                [shapes addObject:location];
            }
        }
        _shape = shapes;
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)modelCustomTransformToDictionary:(NSMutableDictionary *)dict {
    /*  if (_position) {
     dict[@"position"] = @[@(_position.coordinate.latitude), @(_position.coordinate.longitude)];
     return YES;
     } else {
     return NO;
     }*/
    return NO;
}
@end
