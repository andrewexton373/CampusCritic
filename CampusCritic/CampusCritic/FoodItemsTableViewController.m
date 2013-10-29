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

@interface FoodItemsTableViewController ()

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
    // Return the number of rows in the section.
    return self.foodItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"customCell";
    FoodItemsTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    NSDictionary *foodItem = self.foodItems[indexPath.row];
    
    cell.foodItemName.text = foodItem[@"typeOfFood"];
    cell.foodItemPrice.text = @"Need Price Data";
    
    UIImage *foodImage = [UIImage imageNamed: @"CCLogo.png"];
    cell.foodItemImage.image = foodImage;
    
    UIImage *foodResturantImage = [UIImage imageNamed: @"SubwayLogo.png"];
    cell.foodItemRestuantLogo.image = foodResturantImage;
    
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
