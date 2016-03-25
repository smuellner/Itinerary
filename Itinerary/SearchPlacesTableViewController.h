//
//  SearchPlacesTableViewController.h
//  Itinerary
//
//  Created by Sascha Müllner on 20.03.16.
//  Copyright © 2016 smuellner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface SearchPlacesTableViewController : UITableViewController <UISearchResultsUpdating>
@property (nonatomic, assign) CLLocationCoordinate2D centerCoordinate;
@end
