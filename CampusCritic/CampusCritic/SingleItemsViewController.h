//
//  SingleItemsViewController.h
//  CampusCritic
//
//  Created by Andrew Exton on 10/28/13.
//  Copyright (c) 2013 CCDevelopment. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "DLStarRatingControl.h"
#import "iCarousel.h"
#import "SingleItemsViewController.h"
#import "NutritionFactsViewController.h"
#import "ContributeViewController.h"
#import "ReviewPagesViewController.h"


@interface SingleItemsViewController : UIViewController <iCarouselDataSource, iCarouselDelegate>

@property (weak, nonatomic) IBOutlet iCarousel *carousel;
@property (strong, nonatomic) IBOutlet DLStarRatingControl *stars;

@property (strong, nonatomic) NSMutableArray *items;
@property (strong, nonatomic) NSMutableArray *userPhotos;

@property (nonatomic, strong) NSDictionary *passedFoodItem;

@property float ratingAverage;

@end
