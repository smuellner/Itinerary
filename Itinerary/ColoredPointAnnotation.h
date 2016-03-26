//
//  ColoredPointAnnotation.h
//  Itinerary
//
//  Created by Sascha Müllner on 26.03.16.
//  Copyright © 2016 smuellner. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface ColoredPointAnnotation : MKPointAnnotation
@property (nonatomic, strong) UIColor *pinTintColor;
@end
