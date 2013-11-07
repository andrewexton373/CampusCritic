//
//  FoodItemsTableViewController.h
//  CampusCritic
//
//  Created by Andrew Exton on 10/25/13.
//  Copyright (c) 2013 CCDevelopment. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodItemsTableCell.h"

@interface FoodItemsTableViewController : UITableViewController <UISearchDisplayDelegate, UISearchBarDelegate>
    
    //NSArray *searchResults; //array that holds the food items that are the result of the user's search


@property (strong,nonatomic) NSArray *searchResults;

//@property IBOutlet UISearchBar *foodItemSearchBar;

@end
