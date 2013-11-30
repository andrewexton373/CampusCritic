//
//  OrganizeViewController.h
//  CampusCritic
//
//  Created by Andrew Exton on 11/4/13.
//  Copyright (c) 2013 CCDevelopment. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodItemsTableViewController.h"

@interface OrganizeViewController : UIViewController <UIPickerViewDataSource,UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *sortOptionPicker;

@property (nonatomic, strong) NSArray *passedFoodItems;
@property bool vegan;
@property bool vegetarian;
@property bool glutenFree;
@property bool dairyFree;


- (IBAction)veganSwitch:(id)sender;
- (IBAction)vegetarianSwitch:(id)sender;
- (IBAction)glutenFreeSwitch:(id)sender;
- (IBAction)dairyFreeSwitch:(id)sender;


@property (strong, nonatomic) NSArray *sortOptionsArray;
@property (strong, nonatomic) NSString *selectedSortOption;

@end
