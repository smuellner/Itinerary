//
//  PRTag.m
//  PlacesAndRouting
//
//  Created by Sascha Müllner on 15.03.16.
//  Copyright © 2016 smuellner. All rights reserved.
//

#import "PRTag.h"

@implementation PRTag
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"tagId" : @"id"};
}
@end
