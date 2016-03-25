//
//  PRSummary.m
//  PlacesAndRouting
//
//  Created by Sascha Müllner on 19.03.16.
//  Copyright © 2016 smuellner. All rights reserved.
//

#import "PRSummary.h"

@implementation PRSummary
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"type" : @"_type"};
}

@end
