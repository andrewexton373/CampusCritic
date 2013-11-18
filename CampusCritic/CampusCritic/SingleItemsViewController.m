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
        
        nutritionFactsViewController.foodItem = self.passedFoodItem;
    }
    
    if ([[segue identifier] isEqualToString:@"toContribute"])
    {
        ContributeViewController *contributeViewController = [segue destinationViewController];
        
        contributeViewController.passedFoodItem = self.passedFoodItem;
    }
    
    if ([[segue identifier] isEqualToString:@"reviewsContainer"])
    {
        
        ReviewPagesViewController *vC = [segue destinationViewController];
        
        vC.foodItem = self.passedFoodItem;
        
    }
}

- (void) loadFoodReviewsCallback: (NSArray*) foodReviews error: (NSError*) error
{
    
    //If there was not an error loading foodItems from Parse...
    if (!error) {
        
        if (foodReviews.count != 0) {
            
            float ratingSum = 0;
            
            for (id review in foodReviews) {
                
                ratingSum = ratingSum + [review[@"userRating"] integerValue];
                
            }
            
            self.ratingAverage = ratingSum / foodReviews.count;
            
            NSLog(@"%f", self.ratingAverage);
            
            // setup a control with 3 fractional stars at a size of 320x230
            DLStarRatingControl *ratingControl = [[DLStarRatingControl alloc] initWithFrame:CGRectMake(0, 190, 320, 230) andStars:5 isFractional:YES];
            ratingControl.rating = self.ratingAverage;
            [ratingControl setEnabled:NO];
            [self.view addSubview:ratingControl];
            
        }
        
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
    
    PFQuery *query = [PFQuery queryWithClassName:@"Reviews"];
    [query whereKey:@"foodItem" equalTo:self.passedFoodItem];
    [query findObjectsInBackgroundWithTarget:self selector:@selector(loadFoodReviewsCallback:error:)];
    
    _foodItemName.title = _passedFoodItem[@"foodName"];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
