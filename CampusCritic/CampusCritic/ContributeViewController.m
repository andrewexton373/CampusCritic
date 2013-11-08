//
//  ContributeViewController.m
//  CampusCritic
//
//  Created by Andrew Exton on 10/29/13.
//  Copyright (c) 2013 CCDevelopment. All rights reserved.
//

#import "ContributeViewController.h"

@interface ContributeViewController ()

@end

@implementation ContributeViewController

@synthesize userRating;

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
    
    _userReview.delegate = self;
    _userName.delegate = self;
    
    DLStarRatingControl *ratingControl = [[DLStarRatingControl alloc] initWithFrame:CGRectMake(0, 220, 320, 230) andStars:5 isFractional:NO];
    ratingControl.delegate = self;
    [self.view addSubview:ratingControl];
    
}

-(void)newRating:(DLStarRatingControl *)control :(float)rating
{
    self.userRating = [NSNumber numberWithFloat:rating];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    } else {
        return YES;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return NO;
    } else {
        return YES;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveTriggered:(id)sender
{
    
    if (self.userRating == 0 || [self.userReview.text isEqual:@"Write your review here..."]) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please Enter All Required Fields"
                                                        message:@"Fill out Review Text Box and Provide an Item Rating."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
    } else {
        
        PFObject *itemReview = [PFObject objectWithClassName:@"Reviews"];
        [itemReview setObject:self.passedFoodItem forKey:@"foodItem"];
        itemReview[@"userReview"] = self.userReview.text;
        itemReview[@"userRating"] = self.userRating;
        
        if ([self.userName.text isEqual:@""]) {
            [self.userName.text isEqual: @"Anonymous"];
        }
        
        itemReview[@"userName"] = self.userName.text;
        
        [itemReview saveInBackgroundWithTarget:self selector:@selector(saveCallback:error:)];
        
    }

}

- (void)saveCallback:(NSNumber *)result error:(NSError *)error {
    
    if (!error) {
        
        [self performSegueWithIdentifier: @"saveToThankYou" sender: self];
        
    }
}

@end
