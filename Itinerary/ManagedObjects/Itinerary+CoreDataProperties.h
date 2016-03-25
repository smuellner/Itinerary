//
//  Itinerary+CoreDataProperties.h
//  Itinerary
//
//  Created by Sascha Müllner on 22.03.16.
//  Copyright © 2016 smuellner. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Itinerary.h"

NS_ASSUME_NONNULL_BEGIN

@interface Itinerary (CoreDataProperties)

@property (nullable, nonatomic, retain) NSSet<NSManagedObject *> *waypoints;

@end

@interface Itinerary (CoreDataGeneratedAccessors)

- (void)addWaypointsObject:(NSManagedObject *)value;
- (void)removeWaypointsObject:(NSManagedObject *)value;
- (void)addWaypoints:(NSSet<NSManagedObject *> *)values;
- (void)removeWaypoints:(NSSet<NSManagedObject *> *)values;

@end

NS_ASSUME_NONNULL_END
