//
//  PRCategory.h
//  PlacesAndRouting
//
//  Created by Sascha Müllner on 15.03.16.
//  Copyright © 2016 smuellner. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PRCategory : NSObject
@property NSString *categoryId;
@property NSString *title;
@property NSString *href;
@property NSString *type;
@property NSString *system;
@property NSString *icon;
@end
