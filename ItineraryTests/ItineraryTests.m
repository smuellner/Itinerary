//
//  ItineraryTests.m
//  ItineraryTests
//
//  Created by Sascha Müllner on 14.03.16.
//  Copyright © 2016 smuellner. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <PlacesAndRouting.h>

@interface ItineraryTests : XCTestCase

@end

@implementation ItineraryTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testPlacesSearchAtLocation {
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    [[PRPlacesManager manager] searchAtLocation:CLLocationCoordinate2DMake(52.5243700, 13.4105300)
                                      withQuery:@"Bär"
                              completionHandler:^(PRSearchAtLocation *searchAtLocation, NSError *error) {
                                  XCTAssertNil(error, @"Request failed");
                                  XCTAssertNotNil(searchAtLocation, @"Missing response for search");
                                  XCTAssertNotNil(searchAtLocation.items, @"No results for search");
                                  XCTAssertTrue(searchAtLocation.items.count >= 1, @"No results for search");
                                  for (PRPlace *place in searchAtLocation.items) {
                                      XCTAssertNotNil(place.placeId, @"Missing ID");
                                      XCTAssertNotNil(place.title, @"Missing title");
                                      XCTAssertNotNil(place.vicinity, @"Missing vicinity");
                                      XCTAssertNotNil(place.icon, @"Missing icon");
                                      XCTAssertNotNil(place.position, @"Missing position");
                                      XCTAssertTrue(place.position.coordinate.latitude != 0, @"Wrong latitude");
                                      XCTAssertTrue(place.position.coordinate.longitude != 0, @"Wrong longitude");
                                  }
                                  [expectation fulfill];
                              }];
    [self waitForExpectationsWithTimeout:10 handler:NULL];
}

- (void)testRoutingCalculateRouteWithWayPoints {
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];

    NSMutableArray *locations = [NSMutableArray array];
    [locations addObject:[[CLLocation alloc] initWithLatitude:52.5243700
                                                    longitude:13.4105300]];
    [locations addObject:[[CLLocation alloc] initWithLatitude:52.5158286
                                                    longitude:13.3774424]];
    [locations addObject:[[CLLocation alloc] initWithLatitude:52.5159999
                                                    longitude:13.3778999]];
    [[PRRoutingManager manager] calculateRouteWithWayPoints:locations
                                         andRouteAttributes:PRRouteAttributeShape | PRRouteAttributeWaypoints | PRRouteAttributeLegs
                                          completionHandler:^(PRRouteWithWayPoints *routeWithWayPoints, NSError *error) {
                                              XCTAssertNil(error, @"Request failed");
                                              XCTAssertNotNil(routeWithWayPoints, @"Missing response for route calculation");
                                              XCTAssertNotNil(routeWithWayPoints.route, @"Missing routes");
                                              for(PRRoute * route in routeWithWayPoints.route) {
                                                  XCTAssertNotNil(route.waypoint, @"Missing waypoints for route");
                                                  for(PRWaypoint * waypoint in route.waypoint) {
                                                      XCTAssertNotNil(waypoint.linkId, @"Missing link id for waypoint");
                                                      XCTAssertNotNil(waypoint.type, @"Missing type for waypoint");
                                                      XCTAssertNotNil(waypoint.mappedRoadName, @"Missing mappedRoadName for waypoint");
                                                      XCTAssertNotNil(waypoint.originalPosition, @"Missing originalPosition for waypoint");
                                                      XCTAssertTrue(waypoint.originalPosition.coordinate.latitude != 0, @"Wrong latitude for originalPosition");
                                                      XCTAssertTrue(waypoint.originalPosition.coordinate.longitude != 0, @"Wrong longitude for originalPosition");
                                                      XCTAssertNotNil(waypoint.mappedPosition, @"Missing mappedPosition for waypoint");
                                                      XCTAssertTrue(waypoint.mappedPosition.coordinate.latitude != 0, @"Wrong latitude for mappedPosition");
                                                      XCTAssertTrue(waypoint.mappedPosition.coordinate.longitude != 0, @"Wrong longitude for mappedPosition");
                                                  }
                                                  XCTAssertNotNil(route.waypoint, @"Missing legs for route");
                                                  for(PRLeg * leg in route.leg) {
                                                      XCTAssertNotNil(leg.start, @"Missing start waypoint for leg");
                                                      XCTAssertNotNil(leg.end, @"Missing end waypoint for leg");
                                                      XCTAssertNotNil(leg.maneuver, @"Missing maneuvers for leg");
                                                      for(PRManeuver * maneuver in leg.maneuver) {
                                                          XCTAssertNotNil(maneuver.maneuverId, @"Missing maneuver id for maneuver");
                                                          XCTAssertNotNil(maneuver.type, @"Missing type for maneuver");
                                                          XCTAssertNotNil(maneuver.instruction, @"Missing mappedRoadName for maneuver");
                                                          XCTAssertNotNil(maneuver.position, @"Missing position for maneuver");
                                                          XCTAssertTrue(maneuver.position.coordinate.latitude != 0, @"Wrong latitude for position");
                                                          XCTAssertTrue(maneuver.position.coordinate.longitude != 0, @"Wrong longitude for position");
                                                      }
                                                  }
                                              }

                                              [expectation fulfill];
                                          }];
    [self waitForExpectationsWithTimeout:10 handler:NULL];
}

@end
