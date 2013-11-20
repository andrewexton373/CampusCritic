//
//  SingleItemsViewController.h
//  CampusCritic
//
//  Created by Andrew Exton on 10/28/13.
//  Copyright (c) 2013 CCDevelopment. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"

@interface SingleItemsViewController : UIViewController <iCarouselDataSource, iCarouselDelegate>

@property (nonatomic, strong) NSDictionary *passedFoodItem;





@end
