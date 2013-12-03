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

@synthesize passedSortOption, sortedFoodItems, filteredFoodItemsArray, foodItemSearchBar, foodItems, veganFilter, vegetarianFilter, glutenFreeFilter, dairyFreeFilter, searchResults, usingSearch, internetConnectionStatus;


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
        
        NSIndexPath *myIndexPath;
        
        //Store Selected Table View Row in myIndexPath Object
        if (usingSearch == true) {
            myIndexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
        }
        else {
            myIndexPath = [self.tableView indexPathForSelectedRow];
        }
        
        
        //Get Row From myIndexPath Object
        long row = [myIndexPath row];
        
        //Get foodItem Dictionary from foodItems Array @ Row
        NSDictionary *foodItem;
        
        //NSLog(@"%ld", row);
        
        NSLog(@"%hhd", usingSearch);
        
        if (usingSearch == true) {
            foodItem = self.searchResults[row];
        } else {
            foodItem = self.foodItems[row];
        }
        
        //NSLog(@"%@", foodItem);
        
        
        //Pass foodItem NSDictionary to singleItemViewController (Review View)
        singleItemViewController.passedFoodItem = foodItem;
    
        if ([[segue identifier] isEqualToString:@"tableToOrganize"])
        {
        
            //Set Destination View Controller
            OrganizeViewController *organizeViewController = [segue destinationViewController];
        
            //Pass foodItems Array to Organize View (For Filters, but Obsolete now)
            organizeViewController.passedFoodItems = self.foodItems;
        }
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

- (void)viewWillAppear:(BOOL)animated
{
    
    [self.navigationController setToolbarHidden:YES animated:YES];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    //Set up query object and query from Parse in background
    
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    internetConnectionStatus = [reachability currentReachabilityStatus];
    
    if (internetConnectionStatus != NotReachable) {
        
        HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        [self.navigationController.view addSubview:HUD];
        
        HUD.delegate = self;
        HUD.labelText = @"Fetching Food Data...";
        
        [HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
        
    } else {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Error!"
                                                        message: @"An active internet connection is needed to download food data."
                                                       delegate: nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
    }
    
    

}

- (void)myTask {
    
    PFQuery *query = [PFQuery queryWithClassName:@"foodInformationCSV"];
    [query findObjectsInBackgroundWithTarget:self selector:@selector(loadFoodInformationCallback:error:)];
    
    sleep(2);
}

- (IBAction) unwindFromOrganizationPicker:(UIStoryboardSegue*) segue
{
    OrganizeViewController *organizationViewController = segue.sourceViewController;
    
    //Pass Sort Option to Table View
    self.passedSortOption = organizationViewController.selectedSortOption;
    
    //Pass Filters to Table View
    self.veganFilter = organizationViewController.vegan;
    self.vegetarianFilter = organizationViewController.vegetarian;
    self.glutenFreeFilter = organizationViewController.glutenFree;
    self.dairyFreeFilter = organizationViewController.dairyFree;
    
    /*
     // INDIVIDUAL ARRAYS (NOT NECESSARY WITH WORKING FULL ARRAY, here to understand)
     
    //Vegan Switch Array
    
    NSIndexSet *veganFoods = [self.foodItems indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *food = obj;
        int intVal = idx;
        BOOL veganVal = [[[self.foodItems objectAtIndex:intVal] valueForKey:@"vegan"] boolValue];
        if ((self.veganFilter == TRUE) && (veganVal == TRUE))
            return YES;
        else {
            return NO;
        }
    }];
    
    NSArray *veganArray = [self.foodItems objectsAtIndexes:veganFoods];
    NSLog(@"Vegan Array: %@", veganArray);
    
    // Vegetarian Switch Array
    
    NSIndexSet *vegetarianFoods = [self.foodItems indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *food = obj;
        int intVal = idx;
        BOOL vegetarianVal = [[[self.foodItems objectAtIndex:intVal] valueForKey:@"vegetarian"] boolValue];
        if ((self.vegetarianFilter == TRUE) && (vegetarianVal == TRUE))
            return YES;
        else {
            return NO;
        }
    }];
    
    NSArray *vegetarianArray = [self.foodItems objectsAtIndexes:vegetarianFoods];
    NSLog(@"Vegetarian Array: %@", vegetarianArray);
    
    // Gluten Free Switch Array
    
    NSIndexSet *glutenFreeFoods = [self.foodItems indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *food = obj;
        int intVal = idx;
        BOOL glutenFreeVal = [[[self.foodItems objectAtIndex:intVal] valueForKey:@"glutenFree"] boolValue];
        if ((self.glutenFreeFilter == TRUE) && (glutenFreeVal == TRUE))
            return YES;
        else {
            return NO;
        }
    }];
    
    NSArray *glutenFreeArray = [self.foodItems objectsAtIndexes:glutenFreeFoods];
    NSLog(@"Gluten Free Array: %@", glutenFreeArray);
    
    // Dairy Free Switch Array
    
    NSIndexSet *dairyFreeFoods = [self.foodItems indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *food = obj;
        int intVal = idx;
        BOOL dairyFreeVal = [[[self.foodItems objectAtIndex:intVal] valueForKey:@"dairyFree"] boolValue];
        if ((self.dairyFreeFilter == TRUE) && (dairyFreeVal == TRUE))
            return YES;
        else {
            return NO;
        }
    }];
    

    
    NSArray *dairyFreeArray = [self.foodItems objectsAtIndexes:dairyFreeFoods];
    NSLog(@"Dairy Free Array: %@", dairyFreeArray);
     
     */
    
    //full filter
    
    NSIndexSet *filteredFoods = [self.foodItems indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        //NSDictionary *food = obj;
        int intVal = idx;
        BOOL veganVal = [[[self.foodItems objectAtIndex:intVal] valueForKey:@"vegan"] boolValue];
        BOOL vegetarianVal = [[[self.foodItems objectAtIndex:intVal] valueForKey:@"vegetarian"] boolValue];
        BOOL glutenFreeVal = [[[self.foodItems objectAtIndex:intVal] valueForKey:@"glutenFree"] boolValue];
        BOOL dairyFreeVal = [[[self.foodItems objectAtIndex:intVal] valueForKey:@"dairyFree"] boolValue];
        
        //no filters
        if ((self.veganFilter == FALSE) && (self.vegetarianFilter == FALSE) && (self.glutenFreeFilter == FALSE) && (self.dairyFreeFilter == FALSE))
            return YES;
        
        //vegan filter only
        if ((self.veganFilter == TRUE) && (veganVal == TRUE) && (self.vegetarianFilter == FALSE) && (self.glutenFreeFilter == FALSE) && (self.dairyFreeFilter == FALSE)){
            return YES;}
        
        //vegetarian filter only
        if ((self.veganFilter == FALSE) && (self.vegetarianFilter == TRUE) && (vegetarianVal == TRUE) && (self.glutenFreeFilter == FALSE) && (self.dairyFreeFilter == FALSE)){
            return YES;}
        
        //gluten free filter only
        if ((self.veganFilter == FALSE) && (self.vegetarianFilter == FALSE) && (self.glutenFreeFilter == TRUE) && (glutenFreeVal == TRUE) && (self.dairyFreeFilter == FALSE)){
            return YES;}
        
        //dairy free filter only
        if ((self.veganFilter == FALSE) && (self.vegetarianFilter == FALSE) && (self.glutenFreeFilter == FALSE) && (self.dairyFreeFilter == TRUE) && (dairyFreeVal == TRUE)){
            return YES;}
        
        //vegan and vegetarian filter
        if ((self.veganFilter == TRUE) && (veganVal == TRUE) && (self.vegetarianFilter == TRUE) && (vegetarianVal == TRUE) && (self.glutenFreeFilter == FALSE) && (self.dairyFreeFilter == FALSE)) {
            return YES;}
        
        //vegan and gluten free filter
        if ((self.veganFilter == TRUE) && (veganVal == TRUE) && (self.vegetarianFilter == FALSE) && (self.glutenFreeFilter == TRUE) && (glutenFreeVal == TRUE) && (self.dairyFreeFilter == FALSE)) {
            return YES;}
        
        //vegan and dairy free filter
        if ((self.veganFilter == TRUE) && (veganVal == TRUE) && (self.vegetarianFilter == FALSE) && (self.glutenFreeFilter == FALSE) && (self.dairyFreeFilter == TRUE) && (dairyFreeVal == TRUE)) {
            return YES;}
        
        //vegetarian and gluten free filter
        if ((self.veganFilter == FALSE) && (self.vegetarianFilter == TRUE) && (vegetarianVal == TRUE) && (self.glutenFreeFilter == TRUE) && (glutenFreeVal == TRUE) && (self.dairyFreeFilter == FALSE)) {
            return YES;}
        
        //vegetarian and dairy free filter
        if ((self.veganFilter == FALSE) && (self.vegetarianFilter == TRUE) && (vegetarianVal == TRUE) && (self.glutenFreeFilter == FALSE) && (self.dairyFreeFilter == TRUE) && (dairyFreeVal == TRUE)) {
            return YES;}
        
        //gluten free and dairy free filter
        if ((self.veganFilter == FALSE) && (self.vegetarianFilter == FALSE) && (self.glutenFreeFilter == TRUE) && (glutenFreeVal == TRUE) && (self.dairyFreeFilter == FALSE) && (dairyFreeVal == TRUE)) {
            return YES;}
        
        //vegan, vegeterian and gluten free filter
        if ((self.veganFilter == TRUE) && (veganVal == TRUE) && (self.vegetarianFilter == TRUE) && (vegetarianVal == TRUE) && (self.glutenFreeFilter == TRUE) && (glutenFreeVal == TRUE) && (self.dairyFreeFilter == FALSE)) {
            return YES;}
        
        //vegan, vegetarian and dairy free filter
        if ((self.veganFilter == TRUE) && (veganVal == TRUE) && (self.vegetarianFilter == TRUE) && (vegetarianVal == TRUE) && (self.glutenFreeFilter == FALSE) && (self.dairyFreeFilter == TRUE) && (dairyFreeVal == TRUE)) {
            return YES;}
        
        //vegan, gluten free and dairy free filter
        if ((self.veganFilter == TRUE) && (veganVal == TRUE) && (self.vegetarianFilter == FALSE) && (self.glutenFreeFilter == TRUE) && (glutenFreeVal == TRUE) && (self.dairyFreeFilter == TRUE) && (dairyFreeVal == TRUE)) {
            return YES;}
        
        //vegetarian, gluten free and dairy free filter
        if ((self.veganFilter == FALSE) && (self.vegetarianFilter == TRUE) && (vegetarianVal == TRUE) && (self.glutenFreeFilter == TRUE) && (glutenFreeVal == TRUE) && (self.dairyFreeFilter == TRUE) && (dairyFreeVal == TRUE)) {
            return YES;}
        
        //vegan, vegetarian, gluten free and dairy free filter
        if ((self.veganFilter == TRUE) && (veganVal == TRUE) && (self.vegetarianFilter == TRUE) && (vegetarianVal == TRUE) && (self.glutenFreeFilter == TRUE) && (glutenFreeVal == TRUE) && (self.dairyFreeFilter == TRUE) && (dairyFreeVal == TRUE)) {
            return YES;}
        
        
            return NO;
    }];
    
    self.filteredArray = [self.foodItems objectsAtIndexes:filteredFoods];
    NSLog(@"Filtered Array: %@", self.filteredArray);
    
    /*
     //changing the value of foodItems
     
    self.foodItems = filteredArray;
    */
    [self.tableView reloadData];
    

    
    //sorting
    
    if ([self.passedSortOption  isEqualToString: @"Alphabetically"]) {
        
        NSSortDescriptor *sortDescriptor;
        sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"foodName"
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
    
    if (self.filteredArray.count != 0) {
        return self.filteredArray.count;
    } else if (tableView == self.searchDisplayController.searchResultsTableView){
        return self.searchResults.count;
    } else  {
        return self.foodItems.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"customCell";
    FoodItemsTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    NSDictionary *foodItem;
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        foodItem = self.searchResults[indexPath.row];
        //usingSearch = true;
    } else if (self.filteredArray.count != 0) {
        foodItem = self.filteredArray[indexPath.row];
    } else {
        foodItem = self.foodItems[indexPath.row];
        //usingSearch = false;
    }
    
    
    //Set single cell data
    cell.foodItemName.text = foodItem[@"foodName"];
    
    cell.foodItemPrice.text = [NSString stringWithFormat:@"$%.2f", [foodItem[@"foodPrice"] floatValue]];
    
    UIImage *foodImage = [UIImage imageNamed: @"CCLogo.png"];
    cell.foodItemImage.image = foodImage;
    
    NSString *subRestaurant = foodItem[@"subRestaurantName"];
    cell.subRestaurant.text = subRestaurant;
    
    //if user is searching, the text in a cell is the name of the food item from searchResults at that respective index
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        PFObject *searchedItem = [self.searchResults objectAtIndex:indexPath.row];
        cell.textLabel.text = [searchedItem objectForKey:@"foodItemName"];
    } else {
        //else, text in a cell is the name of the food item at that respective index
        PFObject *searchedItem = [self.foodItems objectAtIndex:indexPath.row];
        cell.textLabel.text = [searchedItem objectForKey:@"foodItemName"];
    }
    
    
    return cell;
}

    //this method takes the user's search terms and search through the list of food items to find matches
    //it then puts all matches in the array searchResults
    - (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
    {
        
        NSPredicate *resultPredicate = [NSPredicate
                                        predicateWithFormat:@"foodName CONTAINS[cd] %@",
                                        searchText];
        
        
        /*
         
         NSIndexSet *indicies = [self.foodItems indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
         PFObject *food = obj;
         NSString *name = [food objectForKey:@"foodItemName"];
         
         NSRange range = [name rangeOfString:searchText options:NSCaseInsensitiveSearch];
         NSLog(@"%d", range.length);
         
         //if (range.location)
         return YES;
         }];
         
         self.searchResults = [self.foodItems objectsAtIndexes:indicies];
         
         */
        
        self.searchResults = [self.foodItems filteredArrayUsingPredicate:resultPredicate];
        
        //NSLog(@"%@", self.searchResults);
        
    }
    
    
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath: (NSIndexPath *)indexPath{
    return 70.0f;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    usingSearch = true;
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    usingSearch = false;
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    usingSearch = false;
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
    
#pragma mark - UISearchDisplayController Delegate Methods
    
//this method tells the table view when it needs to reload itself (so we can show the updated search results)
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    // Tells the table data source to reload when text changes
    [self filterContentForSearchText:searchString scope:
    [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}
    
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    // Tells the table data source to reload when scope bar selection changes
    [self filterContentForSearchText:self.searchDisplayController.searchBar.text scope:
    [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

@end

