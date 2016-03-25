//
//  PRSummary.h
//  PlacesAndRouting
//
//  Created by Sascha Müllner on 19.03.16.
//  Copyright © 2016 smuellner. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PRSummary : NSObject
@property NSInteger distance;
@property NSInteger trafficTime;
@property NSInteger baseTime;
@property NSArray *flags;
@property NSString *text;
@property NSInteger travelTime;
@property NSString *type;
@end
