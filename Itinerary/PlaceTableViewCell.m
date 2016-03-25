//
//  PlaceTableViewCell.m
//  Itinerary
//
//  Created by Sascha Müllner on 21.03.16.
//  Copyright © 2016 smuellner. All rights reserved.
//

#import "PlaceTableViewCell.h"

@interface PlaceTableViewCell()
- (IBAction)addButtonPressed:(id)sender;
@end

@implementation PlaceTableViewCell

- (IBAction)addButtonPressed:(id)sender {
    if(NULL != _completionHandler) {
        _completionHandler();
    }
}
@end
