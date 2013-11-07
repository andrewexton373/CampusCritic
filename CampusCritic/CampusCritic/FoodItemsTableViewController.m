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

@interface FoodItemsTableViewController  ()

@property NSArray *foodItems;

@end

@implementation FoodItemsTableViewController

- (void) loadFoodInformationCallback: (NSArray*) foodItems error: (NSError*) error
{
    
    if (!error) {
        
        self.foodItems = foodItems;
        
        [self.tableView reloadData];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"foodSelected"])
    {
        SingleItemsViewController *singleItemViewController =
        [segue destinationViewController];
        
        NSIndexPath *myIndexPath = [self.tableView
                                    indexPathForSelectedRow];
        
        long row = [myIndexPath row];
        NSDictionary *foodItem = self.foodItems[row];
        
        singleItemViewController.passedFoodItemName = [NSString stringWithFormat:@"%@", foodItem[@"typeOfFood"]];
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
    
    PFQuery *query = [PFQuery queryWithClassName:@"foodInformation"];
    [query findObjectsInBackgroundWithTarget:self selector:@selector(loadFoodInformationCallback:error:)];
    
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

    //if user is searching, the num of rows is the num of food items in the search result
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        NSLog(@"%d", [self.searchResults count]);
        return [self.searchResults count];
        
    } else {
        //otherwise, num rows is just the num of food items overall
        return [self.foodItems count];
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@", indexPath);
    NSLog(@"%@", tableView);
    static NSString *CellIdentifier = @"customCell";
    
    FoodItemsTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    // Configure the cell...
    
    /*
    if (cell == nil) {
        cell = [[FoodItemsTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    */
    
    NSDictionary *foodItem = self.foodItems[indexPath.row];
    
    cell.foodItemName.text = foodItem[@"typeOfFood"];
    cell.foodItemPrice.text = @"Need Price Data";
    
    UIImage *foodImage = [UIImage imageNamed: @"CCLogo.png"];
    cell.foodItemImage.image = foodImage;
    
    UIImage *foodResturantImage = [UIImage imageNamed: @"SubwayLogo.png"];
    cell.foodItemRestuantLogo.image = foodResturantImage;
    
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

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath: (NSIndexPath *)indexPath{
    return 70.0f;
}

//this method takes the user's search terms and search through the list of food items to find matches
//it then puts all matches in the array searchResults
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"typeOfFood CONTAINS[cd] %@",
                                    searchText];
    
   /* NSIndexSet *indicies = [self.foodItems indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
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
    //NSLog(@"%@", resultPredicate);
    NSLog(@"%@", self.searchResults);
    
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
