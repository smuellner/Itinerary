//
//  PRManeuver.h
//  PlacesAndRouting
//
//  Created by Sascha Müllner on 20.03.16.
//  Copyright © 2016 smuellner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface PRManeuver : NSObject
@property CLLocation *position;
@property NSString *maneuverId;
@property NSString *type;
@property NSString *instruction;
@property NSInteger length;
@property NSInteger travelTime;
@end
