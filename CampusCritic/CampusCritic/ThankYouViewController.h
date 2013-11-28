//
//  ThankYouViewController.h
//  CampusCritic
//
//  Created by Andrew Exton on 11/26/13.
//  Copyright (c) 2013 CCDevelopment. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ThankYouViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *userName;

- (IBAction)goHomeTriggered:(id)sender;

@end
