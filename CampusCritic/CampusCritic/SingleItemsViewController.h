//
//  SingleItemsViewController.h
//  CampusCritic
//
//  Created by Andrew Exton on 10/28/13.
//  Copyright (c) 2013 CCDevelopment. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SingleItemsViewController : UIViewController<UIPageViewControllerDataSource>

@property (nonatomic, strong) NSDictionary *passedFoodItem;

@property (nonatomic, strong) UIPageViewController *pageViewController;

@end
