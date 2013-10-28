//
//  FoodItemsTableCell.h
//  CampusCritic
//
//  Created by Andrew Exton on 10/27/13.
//  Copyright (c) 2013 CCDevelopment. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodItemsTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *foodItemName;
@property (weak, nonatomic) IBOutlet UILabel *foodItemPrice;
@property (weak, nonatomic) IBOutlet UIImageView *foodItemRestuantLogo;
@property (weak, nonatomic) IBOutlet UIImageView *foodItemImage;

@end
