//
//  ThankYouViewController.h
//  CampusCritic
//
//  Created by Andrew Exton on 11/26/13.
//  Copyright (c) 2013 CCDevelopment. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "MBProgressHUD.h"


@interface ThankYouViewController : UIViewController<UITextFieldDelegate, MBProgressHUDDelegate> {
    
    MBProgressHUD *HUD;
}

@property (strong, nonatomic) MBProgressHUD *HUD;

@property (weak, nonatomic) IBOutlet UITextField *userName;

@property (strong, nonatomic) PFObject *passedItemReview;

@property (strong, nonatomic) PFObject *itemReview;

- (IBAction)returnTriggered:(id)sender;

@end
