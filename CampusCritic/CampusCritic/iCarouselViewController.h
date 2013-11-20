//
//  iCarouselViewController.h
//  CampusCritic
//
//  Created by Michelle on 11/19/13.
//  Copyright (c) 2013 CCDevelopment. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingleItemsViewController.h"
#import "iCarousel.h"
#import <QuartzCore/QuartzCore.h>

@interface iCarouselViewController : UIViewController <iCarouselDataSource, iCarouselDelegate>
@property (strong, nonatomic) IBOutlet iCarousel *carousel;




@end
