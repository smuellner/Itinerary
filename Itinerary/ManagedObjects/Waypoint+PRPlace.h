//
//  Waypoint+PRPlace.h
//  Itinerary
//
//  Created by Sascha Müllner on 22.03.16.
//  Copyright © 2016 smuellner. All rights reserved.
//

#import "Waypoint.h"
#import "PRPlace.h"

@interface Waypoint (PRPlace)
- (void)fillWithPlace:(PRPlace *)place;

@end
