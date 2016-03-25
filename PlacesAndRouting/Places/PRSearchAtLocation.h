//
//  PRSearchAtLocation.h
//  PlacesAndRouting
//
//  Created by Sascha Müllner on 14.03.16.
//  Copyright © 2016 smuellner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PRPlace.h"

@interface PRSearchAtLocation : NSObject
@property NSString *next;
@property NSArray<PRPlace*> *items; //Array<PRPlace>
@end
