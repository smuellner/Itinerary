//
//  PRRoute.h
//  PlacesAndRouting
//
//  Created by Sascha Müllner on 18.03.16.
//  Copyright © 2016 smuellner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PRWaypoint.h"
#import "PRLeg.h"
#import "PRSummary.h"

@interface PRRoute : NSObject
@property NSArray<PRWaypoint *> *waypoint; //Array<PRWaypoint>
@property NSArray<CLLocation *> *shape; //Array<CLLocation>
@property NSArray<PRLeg *> *leg; //Array<PRLeg>
@property PRSummary *summary;
@end
