//
//  PRBasicManager.h
//  PlacesAndRouting
//
//  Created by Sascha Müllner on 15.03.16.
//  Copyright © 2016 smuellner. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PRBasicManager : NSObject
@property (readonly) NSString *appId;
@property (readonly) NSString *appCode;
+ (instancetype)manager;
@end
