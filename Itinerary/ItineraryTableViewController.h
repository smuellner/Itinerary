//
//  ItineraryTableViewController.h
//  Itinerary
//
//  Created by Sascha Müllner on 23.03.16.
//  Copyright © 2016 smuellner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Waypoint.h"

@protocol ItineraryTableViewControllerDelegate <NSObject>
- (void)calculateRoute:(NSArray<Waypoint *> *)waypoints;
@end

@interface ItineraryTableViewController : UITableViewController
@property (nonatomic, weak) id <ItineraryTableViewControllerDelegate> delegate;
- (IBAction)calculateRouteButtonPressed:(id)sender;
@end
