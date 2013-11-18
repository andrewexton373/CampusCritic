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

@interface ReviewPagesViewController ()

@end

@implementation ReviewPagesViewController

@synthesize pageViewController, userNames, userReviews;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) loadFoodReviewsCallback: (NSArray*) foodReviews error: (NSError*) error
{
    
    //If there was not an error loading foodItems from Parse...
    if (!error) {
        
        //Set foodItems Array from Data from Parse
        self.foodReviews = foodReviews;
        

        
        //If foodReviews has a review entry, then add the pages subview
        if (self.foodReviews.count != 0) {
            
            self.userReviews = [NSMutableArray arrayWithCapacity:self.foodReviews.count];
            self.userNames = [NSMutableArray arrayWithCapacity:self.foodReviews.count];
            
            for (id review in self.foodReviews) {
                [self.userReviews addObject:[review objectForKey:@"userReview"]];
                [self.userNames addObject:[review objectForKey:@"userName"]];
            }
            
            self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
            
            [self.pageViewController setDataSource:self];
            
            ContentViewController *initialVC = [self viewControllerAtIndex:0];
            
            NSArray *viewControllers = [NSArray arrayWithObject:initialVC];
            
            [[self pageViewController]setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
            
            [self.pageViewController.view setFrame:self.view.bounds];
            
            //[self.pageViewController addChildViewController:self.pageViewController];
            
            [self.view addSubview:self.pageViewController.view];
            [self.pageViewController didMoveToParentViewController:self];
            
        }
    }
}


- (void)viewWillAppear
{
    

    
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    PFQuery *query = [PFQuery queryWithClassName:@"Reviews"];
    [query whereKey:@"foodItem" equalTo:self.foodItem];
    [query findObjectsInBackgroundWithTarget:self selector:@selector(loadFoodReviewsCallback:error:)];
    
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
    
    return [self.userReviews indexOfObject:viewController.dataObject1];
    
}

- (ContentViewController *) viewControllerAtIndex:(NSInteger)index {
    
    if (index > self.foodReviews.count - 1) {
        return nil;
    }
    
    ContentViewController *cVC = [[ContentViewController alloc]init];
    
    [cVC setDataObject1:self.userReviews[index]];
    [cVC setDataObject2:self.userNames[index]];
    
    return cVC;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
