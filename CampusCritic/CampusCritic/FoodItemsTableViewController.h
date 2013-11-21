//
//  FoodItemsTableViewController.h
//  CampusCritic
//
//  Created by Andrew Exton on 10/25/13.
//  Copyright (c) 2013 CCDevelopment. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodItemsTableCell.h"
#import "Reachability.h"
#import <SystemConfiguration/SystemConfiguration.h>

@interface FoodItemsTableViewController : UITableViewController <UISearchBarDelegate, UISearchDisplayDelegate, MBProgressHUDDelegate> {
    
}

@property NetworkStatus internetConnectionStatus;

@property (strong,nonatomic) NSMutableArray *filteredFoodItemsArray;
@property IBOutlet UISearchBar *foodItemSearchBar;

@property (strong, nonatomic) NSString *passedSortOption;

@property BOOL veganFilter;
@property BOOL vegetarianFilter;
@property BOOL glutenFreeFilter;

@property (strong, nonatomic) NSArray *sortedFoodItems;
@property (strong, nonatomic) NSArray *foodItems;

@property (strong,nonatomic) NSArray *searchResults;

@property (nonatomic, assign) BOOL usingSearch;

@end
