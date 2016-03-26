//
//  ViewController.m
//  Itinerary
//
//  Created by Sascha Müllner on 14.03.16.
//  Copyright © 2016 smuellner. All rights reserved.
//

#import "MapViewController.h"
#import "SearchPlacesTableViewController.h"
#import "ItineraryTableViewController.h"
#import "SCLAlertView.h"
#import "ColoredPointAnnotation.h"
#import <PlacesAndRouting.h>

@interface MapViewController () <CLLocationManagerDelegate, MKMapViewDelegate, UISearchBarDelegate, UISearchControllerDelegate, ItineraryTableViewControllerDelegate>
@property (nonatomic, weak) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, assign) BOOL isFirstAppearance;
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isFirstAppearance = YES;
    // setup location manager
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
    // setup map view
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = NO;
    self.mapView.mapType = MKMapTypeStandard;
    self.mapView.zoomEnabled = YES;
    self.mapView.scrollEnabled = YES;
    // setup search controller
    SearchPlacesTableViewController *searchPlacesTableViewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"SearchPlacesTableViewController"];
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:searchPlacesTableViewController];
    self.searchController.delegate = self;
    self.searchController.searchResultsUpdater = searchPlacesTableViewController;
    self.searchController.searchBar.placeholder = NSLocalizedString(@"Search for places", nil);
    self.searchController.hidesNavigationBarDuringPresentation = NO;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.navigationItem.titleView = self.searchController.searchBar;
    self.definesPresentationContext = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.toolbarHidden = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    if(self.isFirstAppearance) {
        self.isFirstAppearance = NO;
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager requestLocation];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showItinerary"]) {
        ItineraryTableViewController *destViewController = segue.destinationViewController;
        destViewController.delegate = self;
    }
}

#pragma mark - CLLocationManagerDelegate methods
-(void)locationManager:(CLLocationManager *)manager
    didUpdateLocations:(NSArray *)locations {
    CLLocation *newLocation = [locations lastObject];
    MKCoordinateRegion currentLocation = MKCoordinateRegionMakeWithDistance(newLocation.coordinate, 500.0, 500.0);
    [self.mapView setRegion:currentLocation animated:YES];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    [self.mapView setRegion:MKCoordinateRegionMake(self.mapView.centerCoordinate, MKCoordinateSpanMake(180, 360))
                   animated:YES];
}

#pragma mark - ItineraryTableViewControllerDelegate methods
- (void)calculateRoute:(NSArray<Waypoint *> *)waypoints {
    [self.navigationController popToRootViewControllerAnimated:YES];
    self.searchController.active = NO;
    // TODO show progress dialog
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    alert.customViewColor = [UIColor blueColor];
    [alert showWaiting:self
                 title:NSLocalizedString(@"Calculating Route...", nil)
              subTitle:nil
      closeButtonTitle:nil
              duration:0.0];
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self.mapView removeOverlays:self.mapView.overlays];
    //
    NSMutableArray *locations = [NSMutableArray array];
    for(Waypoint *waypoint in waypoints) {
        [locations addObject:[[CLLocation alloc] initWithLatitude:waypoint.latitude.doubleValue
                                                        longitude:waypoint.longitude.doubleValue]];
    }
    [[PRRoutingManager manager] calculateRouteWithWayPoints:locations
                                         andRouteAttributes:PRRouteAttributeShape | PRRouteAttributeWaypoints
                                          completionHandler:^(PRRouteWithWayPoints *routeWithWayPoints, NSError *error) {
                                              [alert hideView];
                                              if(routeWithWayPoints && !error) {
                                                  for(PRRoute * route in routeWithWayPoints.route) {
                                                      // add markers for waypoints
                                                      for(PRWaypoint * waypoint in route.waypoint) {
                                                          ColoredPointAnnotation *waypointAnnotation = [[ColoredPointAnnotation alloc] init];
                                                          waypointAnnotation.coordinate = waypoint.mappedPosition.coordinate;
                                                          waypointAnnotation.title = waypoint.label;
                                                          if(waypoint == route.waypoint.firstObject) {
                                                              waypointAnnotation.pinTintColor = [UIColor greenColor];
                                                          } else if(waypoint == route.waypoint.lastObject) {
                                                              waypointAnnotation.pinTintColor = [UIColor redColor];
                                                          } else {
                                                              waypointAnnotation.pinTintColor = [UIColor purpleColor];
                                                          }
                                                          [self.mapView addAnnotation:waypointAnnotation];
                                                      }
                                                      // draw polyline for shape
                                                      NSUInteger maxCount = route.shape.count;
                                                      CLLocationCoordinate2D coordinates[maxCount];
                                                      for (int idx = 0; idx < maxCount; ++idx) {
                                                          coordinates[idx] = route.shape[idx].coordinate;
                                                      }
                                                      MKPolyline *polyline = [MKPolyline polylineWithCoordinates:coordinates
                                                                                                           count:maxCount];
                                                      [self.mapView addOverlay:polyline];
                                                      [self.mapView showAnnotations:self.mapView.annotations
                                                                           animated:YES];

                                                  }
                                              } else {
                                                  SCLAlertView *errorAlertView = [[SCLAlertView alloc] init];
                                                  [errorAlertView showError:self
                                                                      title:NSLocalizedString(@"Calculation failed", nil)
                                                                   subTitle:error.localizedDescription
                                                           closeButtonTitle:NSLocalizedString(@"Close", nil)
                                                                   duration:5.0];
                                              }
                                          }];
}

#pragma mark - MKMapViewDelegate method
-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        MKPolylineRenderer *polylineRenderer = [[MKPolylineRenderer alloc] initWithPolyline:overlay];
        polylineRenderer.strokeColor = [UIColor blueColor];
        polylineRenderer.lineWidth = 2;
        return polylineRenderer;
    }
    return nil;
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    static NSString * const kPinAnnotationIdentifier = @"PinIdentifier";
    ColoredPointAnnotation *coloredPointAnnotation = annotation;
    MKPinAnnotationView *pinAnnotationView = (MKPinAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:kPinAnnotationIdentifier];
    if(!pinAnnotationView){
        pinAnnotationView = [[MKPinAnnotationView alloc] initWithAnnotation:coloredPointAnnotation reuseIdentifier:kPinAnnotationIdentifier];
    }
    pinAnnotationView.pinTintColor = coloredPointAnnotation.pinTintColor;
    pinAnnotationView.enabled = YES;
    return pinAnnotationView;
}

#pragma mark - UISearchControllerDelegate method
- (void)willPresentSearchController:(UISearchController *)searchController {
    SearchPlacesTableViewController *searchPlacesTableViewController = (SearchPlacesTableViewController *)searchController.searchResultsController;
    searchPlacesTableViewController.centerCoordinate = self.mapView.centerCoordinate;
}
@end
