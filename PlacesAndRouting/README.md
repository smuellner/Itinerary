# Places and Routing Framework (iOS) for HERE's JSON REST API
The framework allows to search for a place by a given string or to get routing informations for a list of waypoints.

## Search for a place 

To search for a place or an address by a given querystring use the `PRPlacesManager`:

```objective-c
[[PRPlacesManager manager]   searchAtLocation:self.mapView.userLocation.location.coordinate
                                    withQuery:@"Berlin"
                            completionHandler:^(PRSearchAtLocation *searchAtLocation, NSError *error) {
                            // show the results of the location search
                            if(searchAtLocation && !error) {
                                NSLog(@"PRSearchAtLocation: %@", searchAtLocation);
                            }
}];
```

## Calculate route with waypoints

To get routing information for a given list of coordinates use the `PRRoutingManager`:

```objective-c
[[PRRoutingManager manager]     calculateRouteWithWayPoints:@[[[CLLocation alloc] initWithLatitude:53.9310 longitude:13.5848],
                                                            [[CLLocation alloc] initWithLatitude:53.8310 longitude:13.4848],
                                                            [[CLLocation alloc] initWithLatitude:53.7310 longitude:13.3848],
                                                            [[CLLocation alloc] initWithLatitude:53.6310 longitude:13.2848]]
                                        andRouteAttributes:PRRouteAttributeShape | PRRouteAttributeWaypoints
completionHandler:^(PRRouteWithWayPoints *routeWithWayPoints, NSError *error) {
    NSLog(@"PRRouteWithWayPoints: %@", routeWithWayPoints);
}];
```

### License (MIT)

Copyright (C) 2016 Sascha Müllner

See the attached LICENSE file.