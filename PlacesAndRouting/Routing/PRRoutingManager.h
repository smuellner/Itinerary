//
//  PRRoutingManager.h
//  PlacesAndRouting
//
//  Created by Sascha Müllner on 13.03.16.
//  Copyright © 2016 smuellner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "PRBasicManager.h"
#import "PRRouteWithWayPoints.h"

typedef NS_OPTIONS(NSUInteger, PRRouteAttributes) {
    PRRouteAttributeNone                   = 0,
    PRRouteAttributeShape                  = 1 << 0,
    PRRouteAttributeWaypoints              = 1 << 1,
    PRRouteAttributeBoundingBox            = 1 << 2,
    PRRouteAttributeSummary                = 1 << 3,
    PRRouteAttributeSummaryByCountry       = 1 << 4,
    PRRouteAttributeRouteId                = 1 << 5,
    PRRouteAttributeNotes                  = 1 << 6,
    PRRouteAttributeLines                  = 1 << 7,
    PRRouteAttributeLegs                   = 1 << 8,
    PRRouteAttributeGroup                  = 1 << 9
};

@interface PRRoutingManager : PRBasicManager
- (NSURLSessionTask *)calculateRouteWithWayPoints:(NSArray<CLLocation *>*)coordinates
                               andRouteAttributes:(PRRouteAttributes)routeAttributes
                                completionHandler:(void (^)(PRRouteWithWayPoints*, NSError*))completionBlock;
@end
