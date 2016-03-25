//
//  PlaceTableViewCell.h
//  Itinerary
//
//  Created by Sascha Müllner on 21.03.16.
//  Copyright © 2016 smuellner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceTableViewCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *vicinityLabel;
@property (nonatomic, weak) IBOutlet UILabel *distanceLabel;
@property (nonatomic, weak) IBOutlet UIImageView *iconImageView;
@property (nonatomic, weak) IBOutlet UIButton *addButton;
@property (nonatomic, strong) void (^completionHandler)(void);
@end
