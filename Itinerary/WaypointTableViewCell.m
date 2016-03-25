//
//  WaypointTableViewCell.m
//  Itinerary
//
//  Created by Sascha Müllner on 24.03.16.
//  Copyright © 2016 smuellner. All rights reserved.
//

#import "WaypointTableViewCell.h"

@interface WaypointTableViewCell()
- (IBAction)addButtonPressed:(id)sender;
@end

@implementation WaypointTableViewCell

- (IBAction)addButtonPressed:(id)sender {
    if(NULL != _completionHandler) {
        _completionHandler();
    }
}
@end