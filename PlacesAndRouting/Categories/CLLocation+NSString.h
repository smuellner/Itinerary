//
//  CLLocation+NSString.h
//  PlacesAndRouting
//
//  Created by Sascha Müllner on 20.03.16.
//  Copyright © 2016 smuellner. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

@interface CLLocation (NSString)
+ (instancetype)initWithString:(NSString *)string;
- (NSString *)toString;
@end
