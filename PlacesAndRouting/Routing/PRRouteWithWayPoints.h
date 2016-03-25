//
//  PRRouteWithWayPoints.h
//  PlacesAndRouting
//
//  Created by Sascha Müllner on 18.03.16.
//  Copyright © 2016 smuellner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PRRoute.h"

@interface PRRouteWithWayPoints : NSObject
@property NSArray<PRRoute*> *route; //Array<PRRoute>
@property NSString *language;
@end
