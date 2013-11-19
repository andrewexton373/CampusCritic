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
#import "DLStarRatingControl.h"
#import "DLStarView.h"
#import <Parse/Parse.h>

@interface SingleItemsViewController ()

@property (weak, nonatomic) IBOutlet UINavigationItem *foodItemName;
@property (strong, nonatomic) IBOutlet UIImageView *image;


@end

@implementation SingleItemsViewController

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"nutritionFactsSegue"])
    
    {

        NutritionFactsViewController *nutritionFactsViewController = [segue destinationViewController];
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
    
    PFQuery *query = [PFQuery queryWithClassName:@"pictures"];

    PFObject *object_image1 = [[query getFirstObject] objectForKey:@"ZehLFqKUYk"];
  //  PFImageView *image1 =[PFObject *object_image1:@"ZehLFqKUYk"];
    PFImageView *image1 = [[PFImageView alloc] init];
    
    PFFile *userImageFile = anotherPhoto[@"imageFile"];
    [userImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
        if (!error) {
            UIImage *image = [UIImage imageWithData:imageData];
        }
    }];
    
 //   UICollectionViewCell *cell1 = [UICollectionView ];

    
    
    
    
   /* PFQuery *query = [PFQuery queryWithClassName:@"pictures"];
    [query getObjectInBackgroundWithId:@"ZehLFqKUYk"
                                 block:^(PFObject *uploadedPictures, NSError *error) {
                                     {
                                         if (!error) {
                                             PFFile *imageFile = [uploadedPictures objectForKey:@"uploadedPictures"];
                                             [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                                                 if (!error) {
                                                     UIImage *image = [UIImage imageWithData:data];
                                                     image = [UIImage imageWithData:@"imageData"];
                                                     imagedata =
                                                 }
                                             }];
                                         }
                                     }];
 
    */
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
