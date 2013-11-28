//
//  ThankYouViewController.m
//  CampusCritic
//
//  Created by Andrew Exton on 11/26/13.
//  Copyright (c) 2013 CCDevelopment. All rights reserved.
//

#import "ThankYouViewController.h"

@interface ThankYouViewController ()

@end

@implementation ThankYouViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)saveCallback:(NSNumber *)result error:(NSError *)error {
    
    if (!error) {
        
        [self performSegueWithIdentifier: @"thankYouToHome" sender:self];
        
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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    self.userName.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goHomeTriggered:(id)sender
{
    
    PFObject *itemReview = [PFObject objectWithClassName:@"Reviews"];
    
    if ([self.userName.text isEqual:@""]) {
        
        itemReview[@"userName"] = @"Anonymous";
        
    } else {
        
        itemReview[@"userName"] = self.userName.text;
        
    }
    
    [itemReview saveInBackgroundWithTarget:self
                                  selector:@selector(saveCallback:error:)];
    
}
@end
