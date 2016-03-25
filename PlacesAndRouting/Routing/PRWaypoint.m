//
//  PRWaypoint.m
//  PlacesAndRouting
//
//  Created by Sascha Müllner on 18.03.16.
//  Copyright © 2016 smuellner. All rights reserved.
//

#import "PRWaypoint.h"
#import "CLLocation+Dictionary.h"

@implementation PRWaypoint
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"linkId" : @"id"};
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dict {
    if (!dict[@"mappedPosition"] && !dict[@"originalPosition"]) return NO;
    _mappedPosition = [CLLocation initWithDictionary:dict[@"mappedPosition"]];
    _originalPosition = [CLLocation initWithDictionary:dict[@"originalPosition"]];
    return YES;
}

- (BOOL)modelCustomTransformToDictionary:(NSMutableDictionary *)dict {
    if (!_mappedPosition && !_originalPosition) return NO;
    dict[@"mappedPosition"] = [_mappedPosition toDictionary];
    dict[@"originalPosition"] = [_originalPosition toDictionary];
    return YES;
}
@end