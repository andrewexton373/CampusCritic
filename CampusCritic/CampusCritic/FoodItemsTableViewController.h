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

@property bool veganFilter;
@property bool vegetarianFilter;
@property bool glutenFreeFilter;
@property bool dairyFreeFilter;

@property bool usingFilter;

@property (strong, nonatomic) NSArray *sortedFoodItems;
@property (strong, nonatomic) NSArray *foodItems;
@property (strong, nonatomic) NSArray *filteredArray;

@end
