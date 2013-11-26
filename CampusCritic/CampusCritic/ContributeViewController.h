//
//  ContributeViewController.h
//  CampusCritic
//
//  Created by Andrew Exton on 10/29/13.
//  Copyright (c) 2013 CCDevelopment. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLStarRatingControl.h"
#import "ImageViewController.h"
#import <Parse/Parse.h>

@interface ContributeViewController : UIViewController<DLStarRatingDelegate, UITextViewDelegate, UITextFieldDelegate> {
    NSNumber *userRating;
}

@property (strong, nonatomic) NSNumber *userRating;
@property (weak, nonatomic) IBOutlet UITextView *userReview;

@property (weak, nonatomic) NSDictionary *passedFoodItem;
@property (strong, nonatomic) NSData *passedPhotoUpload;

- (IBAction)saveTriggered:(id)sender;

@end