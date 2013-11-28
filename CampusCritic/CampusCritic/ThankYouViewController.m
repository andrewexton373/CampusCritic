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
        
    } else {
        
        NSLog(@"PARSE ERROR: %@", error);
        
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

- (IBAction)returnTriggered:(id)sender
{
   
    NSLog(@"Passed Item Review:", self.passedItemReview);
    
    PFObject *itemReview = self.passedItemReview;
    
    if ([self.userName.text isEqual:@""]) {
        
        itemReview[@"userName"] = @"Anonymous";
        
    } else {
        
        itemReview[@"userName"] = self.userName.text;
        
    }
    
    NSLog(@"Item Review: %@", itemReview);
    
    self.itemReview = itemReview;
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
	[self.navigationController.view addSubview:HUD];
	
	HUD.delegate = self;
	HUD.labelText = @"Upload in Progress";
	HUD.detailsLabelText = @"Uploading Review";
	HUD.square = YES;
	
	[HUD showWhileExecuting:@selector(saveCallback:error:) onTarget:self withObject:nil animated:YES];
    
}
@end
