//
//  ThankYouViewController.h
//  CampusCritic
//
//  Created by Andrew Exton on 11/26/13.
//  Copyright (c) 2013 CCDevelopment. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ThankYouViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userName;

@property (strong, nonatomic) PFObject *passedItemReview;

- (IBAction)returnTriggered:(id)sender;

@end
