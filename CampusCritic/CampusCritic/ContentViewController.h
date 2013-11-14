//
//  ContentViewController.h
//  CampusCritic
//
//  Created by Andrew Exton on 11/12/13.
//  Copyright (c) 2013 CCDevelopment. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *userReviewText;
@property (weak, nonatomic) IBOutlet UILabel *userName;

@property (strong, nonatomic) id dataObject1;
@property (strong, nonatomic) id dataObject2;



@end
