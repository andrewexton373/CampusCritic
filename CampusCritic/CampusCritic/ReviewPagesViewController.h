//
//  ReviewPagesViewController.h
//  CampusCritic
//
//  Created by Andrew Exton on 11/12/13.
//  Copyright (c) 2013 CCDevelopment. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReviewPagesViewController : UIViewController<UIPageViewControllerDataSource>

@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, strong) NSMutableArray *userReviewsText;
@property (nonatomic, strong) NSMutableArray *userNames;

@end
