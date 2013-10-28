//
//  NutritionFactsViewController.m
//  CampusCritic
//
//  Created by Andrew Exton on 10/28/13.
//  Copyright (c) 2013 CCDevelopment. All rights reserved.
//

#import "NutritionFactsViewController.h"

@interface NutritionFactsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *foodItemName;
@property (weak, nonatomic) IBOutlet UILabel *servingSize;
@property (weak, nonatomic) IBOutlet UILabel *amountPerServing;
@property (weak, nonatomic) IBOutlet UILabel *calories;
@property (weak, nonatomic) IBOutlet UILabel *totalFat;
@property (weak, nonatomic) IBOutlet UILabel *saturatedFat;
@property (weak, nonatomic) IBOutlet UILabel *cholesterol;
@property (weak, nonatomic) IBOutlet UILabel *sodium;
@property (weak, nonatomic) IBOutlet UILabel *totalCarbohydrate;
@property (weak, nonatomic) IBOutlet UILabel *sugars;
@property (weak, nonatomic) IBOutlet UILabel *protein;

@end

@implementation NutritionFactsViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
