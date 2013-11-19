//
//  SingleItemsViewController.h
//  CampusCritic
//
//  Created by Andrew Exton on 10/28/13.
//  Copyright (c) 2013 CCDevelopment. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SingleItemsViewController : UIViewController

@property (nonatomic, strong) NSDictionary *passedFoodItem;
@property (strong, nonatomic) IBOutlet PFImageView *image1;

@end
