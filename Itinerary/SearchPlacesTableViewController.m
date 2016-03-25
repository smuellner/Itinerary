//
//  SearchPlacesTableViewController.m
//  Itinerary
//
//  Created by Sascha Müllner on 20.03.16.
//  Copyright © 2016 smuellner. All rights reserved.
//

#import "SearchPlacesTableViewController.h"
#import "PlaceTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "Itinerary.h"
#import "Waypoint.h"
#import "Waypoint+PRPlace.h"
#import <PlacesAndRouting.h>
#import <MagicalRecord/MagicalRecord.h>

@interface SearchPlacesTableViewController()
@property (nonatomic, strong) NSArray<PRPlace*> *places;
@property (nonatomic, strong) NSMutableArray<NSString*> *placeIds;
@end

@implementation SearchPlacesTableViewController

-(void)viewDidLoad {
    self.placeIds = [NSMutableArray array];
}

-(void)viewWillAppear:(BOOL)animated {
    self.navigationController.toolbarHidden = YES;
    [self.placeIds removeAllObjects];
    Itinerary *itinerary = [Itinerary MR_findFirst];
    if(nil != itinerary) {
        for(Waypoint *waypoint in itinerary.waypoints) {
            if(nil != waypoint.placeId) {
                [self.placeIds addObject:waypoint.placeId];
            }
        }
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.places count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PlaceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlaceCell" forIndexPath:indexPath];
    PRPlace *place = self.places[indexPath.row];
    cell.titleLabel.text = place.title;
    NSError *err = nil;
    cell.vicinityLabel.attributedText = [[NSAttributedString alloc] initWithData:[place.vicinity dataUsingEncoding:NSUTF8StringEncoding]
                                                                         options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: [NSNumber numberWithInt:NSUTF8StringEncoding]}
                                                              documentAttributes:nil
                                                                           error:&err];
    NSLengthFormatter *lengthFormatter = [[NSLengthFormatter alloc] init];
    if(place.distance < 1000) {
        cell.distanceLabel.text = [lengthFormatter stringFromValue:(place.distance) unit:NSLengthFormatterUnitMeter];
    } else {
        cell.distanceLabel.text = [lengthFormatter stringFromValue:(place.distance/1000) unit:NSLengthFormatterUnitKilometer];
    }
    if([self.placeIds containsObject:place.placeId]) {
        cell.iconImageView.image = [UIImage imageNamed:@"CheckmarkIcon"];
    } else {
        [cell.iconImageView setImageWithURL:[NSURL URLWithString:place.icon]];
    }
    cell.completionHandler = ^{
        [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
            Itinerary *itinerary = [Itinerary MR_findFirstInContext:localContext];
            if(nil == itinerary) {
                itinerary = [Itinerary MR_createEntityInContext:localContext];
            }
            Waypoint *lastWaypoint = [Waypoint MR_findFirstOrderedByAttribute:@"displayOrder" ascending:NO inContext:localContext];
            Waypoint *waypoint = [Waypoint MR_createEntityInContext:localContext];
            waypoint.itinerary = itinerary;
            waypoint.displayOrder = nil == lastWaypoint ? @(0) : @(lastWaypoint.displayOrder.integerValue + 1);
            [waypoint fillWithPlace:place];
            [self.placeIds addObject:place.placeId];
        } completion:^(BOOL success, NSError *error) {
            [self.tableView beginUpdates];
            [self.tableView reloadRowsAtIndexPaths:@[indexPath]
                                  withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView endUpdates];

        }];
    };
    return cell;
}

#pragma mark - UISearchResultsUpdating delegate method
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *searchString = searchController.searchBar.text;
    if(searchString.length > 2) {
        [[PRPlacesManager manager] searchAtLocation:self.centerCoordinate
                                          withQuery:searchString
                                  completionHandler:^(PRSearchAtLocation *searchAtLocation, NSError *error) {
                                      if(searchAtLocation && !error) {
                                          self.places = searchAtLocation.items;
                                          [self.tableView reloadData];
                                      }
                                  }];
    }
}
@end
