//
//  PRPlace.h
//  PlacesAndRouting
//
//  Created by Sascha Müllner on 14.03.16.
//  Copyright © 2016 smuellner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "PRCategory.h"
#import "PROpeningHours.h"
#import "PRTag.h"

@interface PRPlace : NSObject
@property NSString *placeId;
@property NSString *title;
@property NSString *vicinity;
@property NSString *icon;
@property NSInteger distance;
@property CLLocation *position;
@property NSString *href;
@property NSArray<PRTag *> *tags; //Array<PRTag>
@property PRCategory *category;
@property PROpeningHours *openingHours;
@end
