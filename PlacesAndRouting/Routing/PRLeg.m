//
//  PRLeg.m
//  PlacesAndRouting
//
//  Created by Sascha Müllner on 20.03.16.
//  Copyright © 2016 smuellner. All rights reserved.
//

#import "PRLeg.h"

@implementation PRLeg

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"maneuver" : [PRManeuver class]};
}

@end
