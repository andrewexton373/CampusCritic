//
//  NutritionFactsViewController.m
//  CampusCritic
//
//  Created by Andrew Exton on 10/28/13.
//  Copyright (c) 2013 CCDevelopment. All rights reserved.
//

#import "NutritionFactsViewController.h"

@interface NutritionFactsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *servingSize;
@property (weak, nonatomic) IBOutlet UILabel *calories;
@property (weak, nonatomic) IBOutlet UILabel *totalFat;
@property (weak, nonatomic) IBOutlet UILabel *saturatedFat;
@property (weak, nonatomic) IBOutlet UILabel *cholesterol;
@property (weak, nonatomic) IBOutlet UILabel *sodium;
@property (weak, nonatomic) IBOutlet UILabel *totalCarbohydrate;
@property (weak, nonatomic) IBOutlet UILabel *sugars;
@property (weak, nonatomic) IBOutlet UILabel *protein;
@property (weak, nonatomic) IBOutlet UINavigationItem *foodNameTitle;

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

- (void)viewWillAppear:(BOOL)animated
{
    
    [self.navigationController setToolbarHidden:YES animated:YES];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //Set Labels from Passed Food Item Dictionary
    
    self.foodNameTitle.title = self.foodItem[@"foodName"];
    
    self.servingSize.text = self.foodItem[@"servingSize"];
    self.calories.text = [NSString stringWithFormat:@"%@",self.foodItem[@"calories"]];
    self.totalFat.text = [NSString stringWithFormat:@"%@ grams", self.foodItem[@"totalFatG"]];
    self.saturatedFat.text = [NSString stringWithFormat:@"Saturated Fat %@ grams", self.foodItem[@"saturatedFatG"]];
    self.cholesterol.text = [NSString stringWithFormat:@"%@ milligrams", self.foodItem[@"cholesterolMg"]];
    self.sodium.text = [NSString stringWithFormat:@"%@ milligrams", self.foodItem[@"sodiumMg"]];
    self.totalCarbohydrate.text = [NSString stringWithFormat:@"%@ grams", self.foodItem[@"carbsG"]];
    self.sugars.text = [NSString stringWithFormat:@"Sugars %@ grams", self.foodItem[@"sugarG"]];
    self.protein.text = [NSString stringWithFormat:@"%@ grams", self.foodItem[@"proteinG"]];
}

-(void) viewDidLayoutSubviews
{
    [scroller setScrollEnabled: YES];
    [scroller setContentSize:CGSizeMake (0, 550) ];  //scroller stuff
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
