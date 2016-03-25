//
//  CLLocation+Dictionary.h
//  PlacesAndRouting
//
//  Created by Sascha Müllner on 18.03.16.
//  Copyright © 2016 smuellner. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

@interface CLLocation (Dictionary)
+ (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)toDictionary;
@end
