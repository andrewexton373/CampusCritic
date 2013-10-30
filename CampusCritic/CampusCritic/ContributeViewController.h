//
//  ContributeViewController.h
//  CampusCritic
//
//  Created by Andrew Exton on 10/29/13.
//  Copyright (c) 2013 CCDevelopment. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLStarRatingControl.h"

@interface ContributeViewController : UIViewController<DLStarRatingDelegate> {
    IBOutlet UILabel *userRating;
}

@end
