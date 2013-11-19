//
//  SingleItemsViewController.h
//  CampusCritic
//
//  Created by Andrew Exton on 10/28/13.
//  Copyright (c) 2013 CCDevelopment. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"

@interface SingleItemsViewController : UIViewController

@property (nonatomic, strong) NSDictionary *passedFoodItem;
@property (readonly) BOOL isDataAvailable;
@property (nonatomic, readonly, getter = isWrapEnabled) BOOL wrapEnabled;
@property (strong, nonatomic) IBOutlet iCarousel *carousel;




@end
