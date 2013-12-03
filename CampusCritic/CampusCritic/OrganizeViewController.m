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

@synthesize sortOptionsArray, sortOptionPicker, selectedSortOption, vegan, vegetarian, glutenFree, dairyFree, veganSwitch, vegetarianSwitch, glutenFreeSwitch, dairyFreeSwitch, thePicker;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [self.navigationController setToolbarHidden:YES animated:YES];
    
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.sortOptionsArray = [[NSArray alloc] initWithObjects:@"Alphabetically", @"By Rating", @"By Price", @"By Calories", nil];
    
    if (vegan == TRUE) {
        [veganSwitch setOn:TRUE];
        
    }
    if (glutenFree == TRUE) {
        [glutenFreeSwitch setOn:TRUE];
    }
    if (dairyFree == TRUE) {
        [dairyFreeSwitch setOn:TRUE];
    }
    if (vegetarian == TRUE) {
        [vegetarianSwitch setOn:TRUE];
    }
    
    /*
    if ([self.selectedSortOption  isEqualToString: @"Alphabetically"]) {
        [thePicker selectedRowInComponent:0];
    }
    
    if ([self.selectedSortOption  isEqualToString: @"By Rating"]) {
        [thePicker selectedRowInComponent:1];
    }

    if ([self.selectedSortOption  isEqualToString: @"By Price"]) {
        [thePicker selectedRowInComponent:2];
    }

    if ([self.selectedSortOption  isEqualToString: @"By Calories"]) {
        [thePicker selectedRowInComponent:3];
    }
*/

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
    
    if (sender.on) {
        self.vegetarian = true;
    } else {
        self.vegetarian = false;
    }
}

- (IBAction)glutenFreeSwitch:(UISwitch*)sender
{
    
    if (sender.on) {
        self.glutenFree = true;
    } else {
        self.glutenFree = false;
    }
}

- (IBAction)dairyFreeSwitch:(UISwitch*)sender
{
    
    
    if (sender.on) {
        self.dairyFree = true;
    } else {
        self.dairyFree = false;
    }

}


@end
