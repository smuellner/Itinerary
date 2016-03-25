//
//  ItineraryTableViewController.m
//  Itinerary
//
//  Created by Sascha Müllner on 23.03.16.
//  Copyright © 2016 smuellner. All rights reserved.
//

#import "ItineraryTableViewController.h"
#import "Itinerary.h"
#import "Waypoint.h"
#import "WaypointTableViewCell.h"
#import <MagicalRecord/MagicalRecord.h>

@interface ItineraryTableViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *calculateRouteButton;
@property (nonatomic, strong) NSMutableArray<Waypoint *> *waypoints;
@end

@implementation ItineraryTableViewController
struct {
    unsigned int calculateRoute:1;
} delegateRespondsTo;

- (void)setDelegate:(id <ItineraryTableViewControllerDelegate>)aDelegate {
    if (_delegate != aDelegate) {
        _delegate = aDelegate;
        delegateRespondsTo.calculateRoute = [_delegate respondsToSelector:@selector(calculateRoute:)];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.toolbarHidden = NO;
    Itinerary *itinerary = [Itinerary MR_findFirst];
    self.waypoints = [NSMutableArray arrayWithArray:[Waypoint MR_findAllSortedBy:@"displayOrder"
                                                                   ascending:YES
                                                               withPredicate:[NSPredicate predicateWithFormat:@"itinerary == %@", itinerary]]];
    self.calculateRouteButton.enabled = self.waypoints.count > 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setEditing:(BOOL)editing {
    [super setEditing:editing];
    self.calculateRouteButton.enabled = editing ? NO : self.waypoints.count > 1;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.waypoints.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WaypointTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WaypointCell" forIndexPath:indexPath];
    Waypoint *waypoint = self.waypoints[indexPath.row];
    cell.titleLabel.text = waypoint.title;
    NSError *err = nil;
    cell.vicinityLabel.attributedText = [[NSAttributedString alloc] initWithData:[waypoint.vicinity dataUsingEncoding:NSUTF8StringEncoding]
                                                                         options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: [NSNumber numberWithInt:NSUTF8StringEncoding]}
                                                              documentAttributes:nil
                                                                           error:&err];
    cell.distanceLabel.text = [NSString stringWithFormat:@"%@", waypoint.displayOrder];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
            Waypoint *waypoint = self.waypoints[indexPath.row];
            [self.waypoints removeObject:waypoint];
            [waypoint MR_deleteEntityInContext:localContext];
        } completion:^(BOOL success, NSError *error) {
            if(success) {
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            }
        }];
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    Waypoint *waypoint = self.waypoints[fromIndexPath.row];
    [self.waypoints removeObjectAtIndex:fromIndexPath.row];
    [self.waypoints insertObject:waypoint atIndex:toIndexPath.row];
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        NSUInteger displayOrder = 0;
        for (Waypoint *waypoint in self.waypoints) {
            waypoint.displayOrder = @(displayOrder++);
        }
    } completion:^(BOOL success, NSError *error) {
    }];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

#pragma mark - Interface builder actions
- (IBAction)calculateRouteButtonPressed:(id)sender {
    if(delegateRespondsTo.calculateRoute) {
        [_delegate calculateRoute:self.waypoints];
    }
}
@end
