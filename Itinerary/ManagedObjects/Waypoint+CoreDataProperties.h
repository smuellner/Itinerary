//
//  Waypoint+CoreDataProperties.h
//  Itinerary
//
//  Created by Sascha Müllner on 22.03.16.
//  Copyright © 2016 smuellner. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Waypoint.h"

NS_ASSUME_NONNULL_BEGIN

@interface Waypoint (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *placeId;
@property (nullable, nonatomic, retain) NSString *vicinity;
@property (nullable, nonatomic, retain) NSNumber *displayOrder;
@property (nullable, nonatomic, retain) NSNumber *latitude;
@property (nullable, nonatomic, retain) NSNumber *longitude;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) Itinerary *itinerary;

@end

NS_ASSUME_NONNULL_END
