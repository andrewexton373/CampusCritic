//
//  iCarouselViewController.m
//  CampusCritic
//
//  Created by Michelle on 11/19/13.
//  Copyright (c) 2013 CCDevelopment. All rights reserved.
//

#import "iCarouselViewController.h"
#import <Parse/Parse.h>
#import "iCarousel.h"


@interface iCarouselViewController()
@property (nonatomic,strong) NSMutableArray *items;


@end

@implementation iCarouselViewController

@synthesize carousel;
@synthesize items;

- (void) awakeFromNib
{
    // here, put a way to grab data from parse
    // also need to input
    
    PFQuery *query = [PFQuery queryWithClassName:@"pictures"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *items, NSError *error) {
        if (!error) {
            NSLog(@"%d objects received", (items.count));
            for (PFObject *object in items) {
                NSLog(@"%@", object.objectId);
                
                
            }
        }   else {
            NSLog(@"Error: %@ %@", error, [error userInfo]); {
            }
        }
    }];
    
}

- (void) dealloc
{
    carousel.delegate = nil;
    carousel.dataSource = nil;
    
    // [carousel release];
    // [items release];
    
    // uncomment code to test it once the data is set up (release frees up memory)
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
    // Do any additional setup after loading the view from its nib.
    
    carousel.type = iCarouselTypeCoverFlow2;
    
}



-(void) viewDidUnload
{
    [super viewDidUnload];
    self.carousel = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

- (NSUInteger)numberOfItemsinCarousel:(iCarousel *)carousel
{
    return [items count];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
