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
    NSURLComponents *components = [[NSURLComponents alloc] initWithString:kSearchAtLocationURL];
    components.queryItems = @[ [NSURLQueryItem queryItemWithName:@"app_id" value:self.appId],
                               [NSURLQueryItem queryItemWithName:@"app_code" value:self.appCode],
                               [NSURLQueryItem queryItemWithName:@"at" value:at],
                               [NSURLQueryItem queryItemWithName:@"q" value:query] ];
    NSURLSessionTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:components.URL
                                                             completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      if(nil == error) {
                                          PRSearchAtLocation *places = [PRSearchAtLocation yy_modelWithJSON:data];
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                              completionBlock(places, nil);
                                          });
                                      } else {
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                              completionBlock(nil, error);
                                          });
                                      }
                                  }];
    [dataTask resume];
    return dataTask;
}

@end
