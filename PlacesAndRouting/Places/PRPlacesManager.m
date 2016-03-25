//
//  PRPlacesManager.m
//  PlacesAndRouting
//
//  Created by Sascha Müllner on 13.03.16.
//  Copyright © 2016 smuellner. All rights reserved.
//
//
//


#import "PRPlacesManager.h"
#import "AFHTTPSessionManager.h"
#import "YYModel.h"

@implementation PRPlacesManager

NSString * const kSearchAtLocationURL = @"https://places.cit.api.here.com/places/v1/discover/search";

/**
 * https://places.cit.api.here.com/places/v1/discover/search?at=52.5310%2C13.3848&q=bar&app_id=appId&app_code=appCode
 */
- (NSURLSessionTask *)searchAtLocation:(CLLocationCoordinate2D)coordinate
                             withQuery:(NSString *)query
                     completionHandler:(void (^)(PRSearchAtLocation*, NSError*))completionBlock {
    NSString *at = [NSString stringWithFormat:@"%f,%f", coordinate.latitude, coordinate.longitude];
    NSDictionary *parameters = @{@"app_id":self.appId, @"app_code":self.appCode, @"at":at, @"q":query};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSURLSessionTask *dataTask = [manager GET:kSearchAtLocationURL parameters:parameters progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        PRSearchAtLocation *places = [PRSearchAtLocation yy_modelWithJSON:responseObject];
        completionBlock(places, nil);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        completionBlock(nil, error);
    }];
    [dataTask resume];
    return dataTask;
}

@end
