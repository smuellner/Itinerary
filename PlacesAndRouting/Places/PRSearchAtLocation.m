//
//  PRSearchAtLocation.m
//  PlacesAndRouting
//
//  Created by Sascha Müllner on 14.03.16.
//  Copyright © 2016 smuellner. All rights reserved.
//

#import "PRSearchAtLocation.h"

@implementation PRSearchAtLocation

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"next" : @"results.next",
             @"items" : @"results.items"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"items" : [PRPlace class]};
}
@end
