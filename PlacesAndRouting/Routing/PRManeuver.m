//
//  PRManeuver.m
//  PlacesAndRouting
//
//  Created by Sascha Müllner on 20.03.16.
//  Copyright © 2016 smuellner. All rights reserved.
//

#import "PRManeuver.h"
#import "CLLocation+Dictionary.h"

@implementation PRManeuver
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"maneuverId" : @"id",
             @"type" : @"_type"};
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dict {
    if (!dict[@"position"]) return NO;
    _position = [CLLocation initWithDictionary:dict[@"position"]];
    return YES;
}

- (BOOL)modelCustomTransformToDictionary:(NSMutableDictionary *)dict {
    if (!_position) return NO;
    dict[@"position"] = [_position toDictionary];
    return YES;
}
@end
