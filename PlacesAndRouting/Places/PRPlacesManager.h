//
//  PRPlacesManager.h
//  PlacesAndRouting
//
//  Created by Sascha Müllner on 13.03.16.
//  Copyright © 2016 smuellner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "PRBasicManager.h"
#import "PRSearchAtLocation.h"

@interface PRPlacesManager : PRBasicManager
- (NSURLSessionTask *)searchAtLocation:(CLLocationCoordinate2D)location
                             withQuery:(NSString *)query
                     completionHandler:(void (^)(PRSearchAtLocation*, NSError*))completionBlock;
@end
