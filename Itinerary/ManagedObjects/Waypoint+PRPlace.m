//
//  Waypoint+PRPlace.m
//  Itinerary
//
//  Created by Sascha Müllner on 22.03.16.
//  Copyright © 2016 smuellner. All rights reserved.
//

#import "Waypoint+PRPlace.h"

@implementation Waypoint (PRPlace)

- (void)fillWithPlace:(PRPlace *)place {
    self.placeId = place.placeId;
    self.title = place.title;
    self.vicinity = place.vicinity;
    self.latitude = @(place.position.coordinate.latitude);
    self.longitude = @(place.position.coordinate.longitude);
}
@end
