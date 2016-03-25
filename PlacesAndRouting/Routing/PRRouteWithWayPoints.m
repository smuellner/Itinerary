//
//  PRRouteWithWayPoints.m
//  PlacesAndRouting
//
//  Created by Sascha Müllner on 18.03.16.
//  Copyright © 2016 smuellner. All rights reserved.
//

#import "PRRouteWithWayPoints.h"

@implementation PRRouteWithWayPoints

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"language" : @"response.language",
             @"route" : @"response.route"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"route" : [PRRoute class]};
}
@end
