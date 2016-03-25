//
//  PRPlace.m
//  PlacesAndRouting
//
//  Created by Sascha Müllner on 14.03.16.
//  Copyright © 2016 smuellner. All rights reserved.
//

#import "PRPlace.h"
#import "PRCategory.h"

@implementation PRPlace
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"placeId" : @"id"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"tags" : [PRTag class]};
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dict {
    NSArray *coordinates = dict[@"position"];
    if ([coordinates isKindOfClass:[NSArray class]] && coordinates.count >= 2) {
        _position = [[CLLocation alloc] initWithLatitude:[[coordinates objectAtIndex:0] doubleValue]
                                               longitude:[[coordinates objectAtIndex:1] doubleValue]];
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)modelCustomTransformToDictionary:(NSMutableDictionary *)dict {
    if (_position) {
        dict[@"position"] = @[@(_position.coordinate.latitude), @(_position.coordinate.longitude)];
        return YES;
    } else {
        return NO;
    }
}

@end
