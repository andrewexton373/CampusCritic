//
//  ReviewPagesViewController.m
//  CampusCritic
//
//  Created by Andrew Exton on 11/12/13.
//  Copyright (c) 2013 CCDevelopment. All rights reserved.
//

#import "ReviewPagesViewController.h"
#import "ContentViewController.h"
#import "SingleItemsViewController.h"
#import <Parse/Parse.h>

@interface ReviewPagesViewController ()

@end

@implementation ReviewPagesViewController

@synthesize pageViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) loadFoodInformationCallback: (NSArray*) foodItemReviews error: (NSError*) error
{
    
    //If there was not an error loading foodItems from Parse...
    if (!error) {
        
        //Set foodItems Array from Data from Parse
        self.foodItemReviews = foodItemReviews;
        
        NSLog(foodItemReviews);
        
        /*
        self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        
        [self.pageViewController setDataSource:self];
        
        ContentViewController *initialVC = [self viewControllerAtIndex:0];
        
        NSArray *viewControllers = [NSArray arrayWithObject:initialVC];
        
        [[self pageViewController]setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
        
        [self.pageViewController.view setFrame:self.view.bounds];
        
        //[self.pageViewController addChildViewController:self.pageViewController];
        
        [self.view addSubview:self.pageViewController.view];
        [self.pageViewController didMoveToParentViewController:self];
        */
    }
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    SingleItemsViewController *siVC = [[SingleItemsViewController alloc]init];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Reviews"];
    [query whereKey:@"foodItem" equalTo:[NSString stringWithFormat:@"%@", siVC.passedFoodItem[@"objectId"]]];
    [query findObjectsInBackgroundWithTarget:self selector:@selector(loadFoodInformationCallback:error:)];

}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
 
    NSUInteger index = [self indexOfViewController:(ContentViewController *)viewController];
    
    if (index==NSNotFound) {
        return nil;
    }
    index++;
    return [self viewControllerAtIndex:index];
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    
    NSUInteger index = [self indexOfViewController:(ContentViewController *)viewController];
    
    if (index==0 || index==NSNotFound) {
        return nil;
    }
    index--;
    return [self viewControllerAtIndex:index];
    
}

- (NSUInteger) indexOfViewController:(ContentViewController *)viewController {
    return [self.foodItemReviews indexOfObject:viewController.dataObject1];
}

- (ContentViewController *) viewControllerAtIndex:(NSInteger)index {
    
    if (index > self.foodItemReviews.count - 1) {
        return nil;
    }
    
    ContentViewController *cVC = [[ContentViewController alloc]init];
    [cVC setDataObject1:[self.foodItemReviews[index] objectForKey:@"userReview"]];
    [cVC setDataObject2:[self.foodItemReviews[index] objectForKey:@"userName"]];
    
    return cVC;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
