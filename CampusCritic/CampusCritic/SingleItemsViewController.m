//
//  SingleItemsViewController.m
//  CampusCritic
//
//  Created by Andrew Exton on 10/28/13.
//  Copyright (c) 2013 CCDevelopment. All rights reserved.
//

#import "SingleItemsViewController.h"
#import "NutritionFactsViewController.h"
#import "ContributeViewController.h"
#import "ReviewPagesViewController.h"
#import "ContentViewController.h"
#import "DLStarRatingControl.h"
#import "DLStarView.h"
#import <Parse/Parse.h>

@interface SingleItemsViewController ()

@property (weak, nonatomic) IBOutlet UINavigationItem *foodItemName;

@end

@implementation SingleItemsViewController

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"nutritionFactsSegue"])
    {
        NutritionFactsViewController *nutritionFactsViewController = [segue destinationViewController];
        
        nutritionFactsViewController.foodItem = _passedFoodItem;
    }
    
    if ([[segue identifier] isEqualToString:@"toContribute"])
    {
        ContributeViewController *contributeViewController = [segue destinationViewController];
        
        contributeViewController.passedFoodItem = _passedFoodItem;
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    _foodItemName.title = _passedFoodItem[@"foodName"];
    
    float rating = [_passedFoodItem[@"rating"] floatValue];
    
    // setup a control with 3 fractional stars at a size of 320x230
    DLStarRatingControl *ratingControl = [[DLStarRatingControl alloc] initWithFrame:CGRectMake(0, 190, 320, 230) andStars:5 isFractional:YES];
    ratingControl.rating = rating;
    [ratingControl setEnabled:NO];
    [self.view addSubview:ratingControl];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
