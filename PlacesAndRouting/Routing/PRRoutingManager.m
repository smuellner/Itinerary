//
//  PRRoutingManager.m
//  PlacesAndRouting
//
//  Created by Sascha Müllner on 13.03.16.
//  Copyright © 2016 smuellner. All rights reserved.
//

#import "PRRoutingManager.h"
#import "AFHTTPSessionManager.h"
#import "YYModel.h"

NSString *const kPRRouteAttributeShape              = @"sh";
NSString *const kPRRouteAttributeWaypoints          = @"wp";
NSString *const kPRRouteAttributeBoundingBox        = @"bb";
NSString *const kPRRouteAttributeSummary            = @"sm";
NSString *const kPRRouteAttributeSummaryByCountry   = @"sc";
NSString *const kPRRouteAttributeRouteId            = @"ri";
NSString *const kPRRouteAttributeNotes              = @"no";
NSString *const kPRRouteAttributeLines              = @"li";
NSString *const kPRRouteAttributeLegs               = @"lg";
NSString *const kPRRouteAttributeGroup              = @"gr";

@implementation PRRoutingManager

/**
 * API Explorer
 * https://developer.here.com/api-explorer/rest/routing
 *
 * Example Request:
 * https://route.cit.api.here.com/routing/7.2/calculateroute.json?app_id=appId&app_code=appCode&waypoint0=geo!52.5,13.4&waypoint1=geo!52.5,13.45&mode=fastest;car;traffic:disabled&routeAttributes=sh,wp
 */
NSString * const kCalculateRouteURL = @"https://route.cit.api.here.com/routing/7.2/calculateroute.json";

- (NSURLSessionTask *)calculateRouteWithWayPoints:(NSArray<CLLocation *>*)locations
                               andRouteAttributes:(PRRouteAttributes)routeAttributes
                                completionHandler:(void (^)(PRRouteWithWayPoints*, NSError*))completionBlock {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"app_id":self.appId,
                                                                                      @"app_code":self.appCode,
                                                                                      @"mode":@"fastest;car;traffic:disabled"}];
    if(routeAttributes & ~PRRouteAttributeNone)
    {
        [parameters setObject:[self parametersForRouteAttributes:routeAttributes]
                       forKey:@"routeAttributes"];
    }
    NSUInteger index = 0;
    for(CLLocation *location in locations)
    {
        NSMutableString * waypoint = [NSMutableString stringWithString:@"geo!"];
        if(index != 0 && index != (locations.count - 1)) {
            [waypoint appendString:@"stopOver!"];
        }
        [waypoint appendFormat:@"%f,%f", location.coordinate.latitude, location.coordinate.longitude];
        [parameters setObject:waypoint
                       forKey:[NSString stringWithFormat:@"waypoint%lu", (unsigned long)index]];
        index++;
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSURLSessionTask *dataTask = [manager GET:kCalculateRouteURL parameters:parameters progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        PRRouteWithWayPoints *places = [PRRouteWithWayPoints yy_modelWithJSON:responseObject];
        completionBlock(places, nil);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        completionBlock(nil, error);
    }];
    [dataTask resume];
    return dataTask;
}

- (NSString *)parametersForRouteAttributes:(PRRouteAttributes)routeAttributes {
    NSMutableArray* attributes = [NSMutableArray array];
    if (routeAttributes & PRRouteAttributeShape) {
        [attributes addObject:kPRRouteAttributeShape];
    }
    if (routeAttributes & PRRouteAttributeWaypoints) {
        [attributes addObject:kPRRouteAttributeWaypoints];
    }
    if (routeAttributes & PRRouteAttributeBoundingBox) {
        [attributes addObject:kPRRouteAttributeBoundingBox];
    }
    if (routeAttributes & PRRouteAttributeSummary) {
        [attributes addObject:kPRRouteAttributeSummary];
    }
    if (routeAttributes & PRRouteAttributeSummaryByCountry) {
        [attributes addObject:kPRRouteAttributeSummaryByCountry];
    }
    if (routeAttributes & PRRouteAttributeRouteId) {
        [attributes addObject:kPRRouteAttributeRouteId];
    }
    if (routeAttributes & PRRouteAttributeNotes) {
        [attributes addObject:kPRRouteAttributeNotes];
    }
    if (routeAttributes & PRRouteAttributeLines) {
        [attributes addObject:kPRRouteAttributeLines];
    }
    if (routeAttributes & PRRouteAttributeLegs) {
        [attributes addObject:kPRRouteAttributeLegs];
    }
    if (routeAttributes & PRRouteAttributeGroup) {
        [attributes addObject:kPRRouteAttributeGroup];
    }
    return [attributes componentsJoinedByString:@","];
}

@end
