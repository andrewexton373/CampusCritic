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

@synthesize pageViewController;

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
        
        NSLog([NSString stringWithFormat:@"%@", self.foodReviews]);
        
    }
}


- (void)viewWillAppear
{
    

    
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.userNames = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < 10; i++) {
        [self.userNames addObject:[NSString stringWithFormat:@"User Name %d", i]];
    }
    
    self.userReviewsText = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < 10; i++) {
        [self.userReviewsText addObject:[NSString stringWithFormat:@"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. %d", i]];
    }
    
    PFQuery *query = [PFQuery queryWithClassName:@"Reviews"];
    [query whereKey:@"foodItem" equalTo:(@"0xQkV1Afaj")];
    [query findObjectsInBackgroundWithTarget:self selector:@selector(loadFoodReviewsCallback:error:)];
    
    
    
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
    return [self.userReviewsText indexOfObject:viewController.dataObject1];
}

- (ContentViewController *) viewControllerAtIndex:(NSInteger)index {
    
    if (index > self.userReviewsText.count - 1) {
        return nil;
    }
    
    ContentViewController *cVC = [[ContentViewController alloc]init];
    [cVC setDataObject1:[self.userReviewsText objectAtIndex:index]];
    [cVC setDataObject2:[self.userNames objectAtIndex:index]];
    
    return cVC;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
