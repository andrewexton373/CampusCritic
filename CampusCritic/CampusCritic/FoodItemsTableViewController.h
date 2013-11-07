//
//  FoodItemsTableViewController.h
//  CampusCritic
//
//  Created by Andrew Exton on 10/25/13.
//  Copyright (c) 2013 CCDevelopment. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodItemsTableCell.h"

@interface FoodItemsTableViewController : UITableViewController <UISearchBarDelegate, UISearchDisplayDelegate>

@property (strong,nonatomic) NSMutableArray *filteredFoodItemsArray;
@property IBOutlet UISearchBar *foodItemSearchBar;

@property (strong, nonatomic) NSString *passedSortOption;

@property BOOL veganFilter;
@property BOOL vegatarianFilter;
@property BOOL glutenFreeFilter;

@property (strong, nonatomic) NSArray *sortedFoodItems;

@end
