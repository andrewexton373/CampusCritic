//
//  ReviewPagesViewController.m
//  CampusCritic
//
//  Created by Andrew Exton on 11/12/13.
//  Copyright (c) 2013 CCDevelopment. All rights reserved.
//

#import "ReviewPagesViewController.h"
#import "ContentViewController.h"

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
        [self.userReviewsText addObject:[NSString stringWithFormat:@"Random Text Review Goes Here and this is # %d", i]];
    }
    
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    [self.pageViewController setDataSource:self];
    
    ContentViewController *initialVC = [self viewControllerAtIndex:0];
    
    NSArray *viewControllers = [NSArray arrayWithObject:initialVC];
    
    [[self pageViewController]setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    [self.pageViewController.view setFrame:self.view.bounds];
    [self.pageViewController addChildViewController:self.pageViewController];
    
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
 
    NSUInteger index = [self indexOfViewController:(ContentViewController *)viewController];
    
    if (index==NSNotFound) {
        return nil;
    }
    index++;
    return [self viewControllerAtIndex:index];
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
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
