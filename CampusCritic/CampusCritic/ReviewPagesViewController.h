//
//  ReviewPagesViewController.h
//  CampusCritic
//
//  Created by Andrew Exton on 11/12/13.
//  Copyright (c) 2013 CCDevelopment. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ReviewPagesViewController : UIViewController<UIPageViewControllerDataSource>

@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, strong) NSArray *foodReviews;
@property (nonatomic, strong) NSObject *foodItem;

@end
