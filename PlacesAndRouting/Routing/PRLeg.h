//
//  PRLeg.h
//  PlacesAndRouting
//
//  Created by Sascha Müllner on 20.03.16.
//  Copyright © 2016 smuellner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PRWaypoint.h"
#import "PRManeuver.h"

@interface PRLeg : NSObject
@property PRWaypoint *start;
@property PRWaypoint *end;
@property NSInteger length;
@property NSInteger travelTime;
@property NSArray<PRManeuver*> *maneuver; //Array<PRManeuver>
@end
