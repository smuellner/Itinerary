//
//  PRWaypoint.h
//  PlacesAndRouting
//
//  Created by Sascha Müllner on 18.03.16.
//  Copyright © 2016 smuellner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface PRWaypoint : NSObject
@property NSString *linkId;
@property NSString *type;
@property NSNumber *spot;
@property NSString *sideOfStreet;
@property NSString *mappedRoadName;
@property NSString *label;
@property NSInteger shapeIndex;
@property CLLocation *mappedPosition;
@property CLLocation *originalPosition;
@end