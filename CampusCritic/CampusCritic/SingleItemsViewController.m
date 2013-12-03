//
//  SingleItemsViewController.m
//  CampusCritic
//
//  Created by Andrew Exton on 10/28/13.
//  Copyright (c) 2013 CCDevelopment. All rights reserved.
//

#import "SingleItemsViewController.h"

@interface SingleItemsViewController ()

@property (weak, nonatomic) IBOutlet UINavigationItem *foodItemName;

@end

@implementation SingleItemsViewController

@synthesize carousel, items;

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

- (void)viewWillDisappear:(BOOL)animated
{
    [self.carousel removeFromSuperview];
}


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
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTranslucent:NO];
    
    [self.navigationController setToolbarHidden:NO animated:YES];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    PFQuery *query = [PFQuery queryWithClassName:@"Reviews"];
    [query whereKey:@"foodItem" equalTo:self.passedFoodItem];
    //[query findObjectsInBackgroundWithTarget:self selector:@selector(loadFoodReviewsCallback:error:)];
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
	[self.navigationController.view addSubview:hud];
	hud.labelText = @"Downloading Reviews...";
	
    [hud show:YES];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *foodReviews, NSError *error) {
        
        if (!error) {
            
            if (foodReviews.count != 0) {
                
                float ratingSum = 0;
                
                self.userPhotos = [[NSMutableArray alloc] init];
                
                for (PFObject *review in foodReviews) {
                    
                    ratingSum = ratingSum + [review[@"userRating"] integerValue];
                    
                    if (review[@"userPhoto"] != nil) {
                        
                        NSData *photoData = [review[@"userPhoto"] getData];
                        UIImage *userImage = [UIImage imageWithData:photoData];
                        
                        if (userImage != NULL) {
                            [self.userPhotos addObject:userImage];
                        }
                        
                    }
                    
                }
                
                self.ratingAverage = ratingSum / foodReviews.count;
                
                // setup a control with 3 fractional stars at a size of 320x230
                DLStarRatingControl *ratingControl = [[DLStarRatingControl alloc] initWithFrame:CGRectMake(0, 190, 320, 230) andStars:5 isFractional:YES];
                ratingControl.rating = self.ratingAverage;
                [ratingControl setEnabled:NO];
                [self.view addSubview:ratingControl];
                
                [self.carousel reloadData];
                
            } else {
                
                //If there are no reviews
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Oops!"
                                                                message: @"No reviews have been contributed. Please Contribute!"
                                                               delegate: self
                                                      cancelButtonTitle:@"Back"
                                                      otherButtonTitles:@"Contribute", nil];
                [alert show];
                
            }
            
        }
        
        [hud show:NO];
        [hud removeFromSuperview];
        
    }];
    
    
    _foodItemName.title = _passedFoodItem[@"foodName"];
    
    carousel.dataSource = self;
    carousel.delegate = self;
    
    carousel.type = iCarouselTypeLinear;

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    if (buttonIndex == 1) {
        [self performSegueWithIdentifier:@"toContribute" sender:self];
    }
}

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    //return the total number of items in the carousel
    return [self.userPhotos count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 210.0f, 210.0f)];
        ((UIImageView *)view).image = self.userPhotos[index];
        view.contentMode = UIViewContentModeCenter;
    }
    else
    {
        //get a reference to the label in the recycled view
    }
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
    
    return view;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
