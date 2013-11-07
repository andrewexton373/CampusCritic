//
//  OrganizeViewController.m
//  CampusCritic
//
//  Created by Andrew Exton on 11/4/13.
//  Copyright (c) 2013 CCDevelopment. All rights reserved.
//

#import "OrganizeViewController.h"


@interface OrganizeViewController ()

@end

@implementation OrganizeViewController

@synthesize sortOptionsArray, sortOptionPicker, selectedSortOption, vegan, vegatarian, glutenFree;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"organizeToTable"])
    {
        //Set Destination View Controller
        FoodItemsTableViewController *foodItemsTableViewController = [segue destinationViewController];
        
        //Pass Sort Option to Table View
        foodItemsTableViewController.passedSortOption = self.selectedSortOption;
        
        //Pass Filters to Table View
        foodItemsTableViewController.veganFilter = vegan;
        foodItemsTableViewController.vegatarianFilter = vegatarian;
        foodItemsTableViewController.glutenFreeFilter = glutenFree;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.sortOptionsArray = [[NSArray alloc] initWithObjects:@"Alphabetically", @"By Rating", @"By Price", @"By Calories", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component
{
    return [self.sortOptionsArray count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.sortOptionsArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    NSLog(@"Selected Sort Option: %@", self.sortOptionsArray[row]);
    
    self.selectedSortOption = self.sortOptionsArray[row];
    
}


- (IBAction)veganSwitch:(UISwitch*)sender
{
    if (sender.on) {
        self.vegan = true;
    } else {
        self.vegan = false;
    }
}

- (IBAction)vegetarianSwitch:(UISwitch*)sender
{


}

- (IBAction)glutenFreeSwitch:(UISwitch*)sender
{

}


@end
