//
//  PRCategory.m
//  PlacesAndRouting
//
//  Created by Sascha Müllner on 15.03.16.
//  Copyright © 2016 smuellner. All rights reserved.
//

#import "PRCategory.h"

@implementation PRCategory
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"categoryId" : @"id"};
}
@end
