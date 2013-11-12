//
//  FoodItemsTableViewController.m
//  CampusCritic
//
//  Created by Andrew Exton on 10/25/13.
//  Copyright (c) 2013 CCDevelopment. All rights reserved.
//

#import "FoodItemsTableViewController.h"
#import <Parse/Parse.h>
#import "FoodItemsTableCell.h"
#import "SingleItemsViewController.h"
#import "OrganizeViewController.h"

@interface FoodItemsTableViewController ()

@end

@implementation FoodItemsTableViewController

@synthesize passedSortOption, filteredFoodItemsArray, foodItemSearchBar, sortedFoodItems, foodItems;

- (void) loadFoodInformationCallback: (NSArray*) foodItems error: (NSError*) error
{
    
    //If there was not an error loading foodItems from Parse...
    if (!error) {
        
        //Set foodItems Array from Data from Parse
        self.foodItems = foodItems;
        
        //Sort foodItems Array Alphabetically by foodItem[@"foodName"] (Default)
        NSSortDescriptor *sortDescriptor;
        sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"foodName"
                                                     ascending:YES
                                                      selector:@selector(localizedCaseInsensitiveCompare:)];
        
        NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
        
        //Return Alphabetically Sorted Array
        self.foodItems = [self.foodItems sortedArrayUsingDescriptors:sortDescriptors];
         
        //Reload tableView
        [self.tableView reloadData];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"foodSelected"])
    {
        //Set Destination View Controller
        SingleItemsViewController *singleItemViewController = [segue destinationViewController];
        
        //Store Selected Table View Row in myIndexPath Object
        NSIndexPath *myIndexPath = [self.tableView indexPathForSelectedRow];
        
        //Get Row From myIndexPath Object
        long row = [myIndexPath row];
        
        //Get foodItem Dictionary from foodItems Array @ Row
        NSDictionary *foodItem = self.foodItems[row];
        
        
        //Pass foodItem NSDictionary to singleItemViewController (Review View)
        singleItemViewController.passedFoodItem = foodItem;
    }
    
    if ([[segue identifier] isEqualToString:@"tableToOrganize"])
    {
        
        //Set Destination View Controller
        OrganizeViewController *organizeViewController = [segue destinationViewController];
        
        //Pass foodItems Array to Organize View (For Filters, but Obsolete now)
        organizeViewController.passedFoodItems = self.foodItems;
    }
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    //Set up query object and query from Parse in background
    PFQuery *query = [PFQuery queryWithClassName:@"foodInformationCSV"];
    [query findObjectsInBackgroundWithTarget:self selector:@selector(loadFoodInformationCallback:error:)];
    
}

- (IBAction) unwindFromOrganizationPicker:(UIStoryboardSegue*) segue
{
    OrganizeViewController *organizationViewController = segue.sourceViewController;
    self.passedSortOption = organizationViewController.selectedSortOption;
    
    //Pass Sort Option to Table View
    self.passedSortOption = organizationViewController.selectedSortOption;
    
    //Pass Filters to Table View
    self.veganFilter = organizationViewController.vegan;
    self.vegetarianFilter = organizationViewController.vegetarian;
    self.glutenFreeFilter = organizationViewController.glutenFree;
    
    if ([self.passedSortOption  isEqual: @"Alphabetically"]) {
        
        NSSortDescriptor *sortDescriptor;
        sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"typeOfFood"
                                                     ascending:YES
                                                      selector:@selector(localizedCaseInsensitiveCompare:)];
        NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
        self.foodItems = [self.foodItems sortedArrayUsingDescriptors:sortDescriptors];
        
        [self.tableView reloadData];
        
    } else if ([self.passedSortOption  isEqualToString: @"By Rating"]) {
        
        self.foodItems = [self.foodItems sortedArrayUsingComparator:^(id obj1, id obj2) {
            NSDictionary *food1 = obj1;
            NSDictionary *food2 = obj2;
            NSNumber *rating1 = food1[@"rating"];
            NSNumber *rating2 = food2[@"rating"];
            
            return [rating2 compare:rating1];
        }];
        
        [self.tableView reloadData];
        
    } else if ([self.passedSortOption  isEqualToString: @"By Price"]) {
        
        self.foodItems = [self.foodItems sortedArrayUsingComparator:^(id obj1, id obj2) {
            NSDictionary *food1 = obj1;
            NSDictionary *food2 = obj2;
            NSNumber *price1 = food1[@"foodPrice"];
            NSNumber *price2 = food2[@"foodPrice"];
            
            return [price1 compare:price2];
        }];
        
        [self.tableView reloadData];
        
    } else if ([self.passedSortOption  isEqualToString: @"By Calories"]) {
        
        self.foodItems = [self.foodItems sortedArrayUsingComparator:^(id obj1, id obj2) {
            NSDictionary *food1 = obj1;
            NSDictionary *food2 = obj2;
            NSNumber *calories1 = food1[@"calories"];
            NSNumber *calories2 = food2[@"calories"];
            
            return [calories1 compare:calories2];
        }];
        
        [self.tableView reloadData];
        
    } else if ([self.passedSortOption isEqual:NULL]) {
        
        //Sort foodItems Array Alphabetically by foodItem[@"foodName"] (Default)
        NSSortDescriptor *sortDescriptor;
        sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"foodName"
                                                     ascending:YES
                                                      selector:@selector(localizedCaseInsensitiveCompare:)];
        
        NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
        
        //Return Alphabetically Sorted Array
        self.foodItems = [self.foodItems sortedArrayUsingDescriptors:sortDescriptors];
        
        //Reload tableView
        [self.tableView reloadData];
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.foodItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"customCell";
    FoodItemsTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    //Get single foodItem from foodItems Array @ Row
    NSDictionary *foodItem = self.foodItems[indexPath.row];
    
    //Set single cell data
    cell.foodItemName.text = foodItem[@"foodName"];
    cell.foodItemPrice.text = [NSString stringWithFormat:@"$%@",foodItem[@"foodPrice"]];
    
    UIImage *foodImage = [UIImage imageNamed: @"CCLogo.png"];
    cell.foodItemImage.image = foodImage;
    
    NSString *subRestaurant = foodItem[@"subRestaurantName"];
    cell.subRestaurant.text = subRestaurant;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation

/*
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
