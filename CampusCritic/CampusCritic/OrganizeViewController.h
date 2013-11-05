//
//  OrganizeViewController.h
//  CampusCritic
//
//  Created by Andrew Exton on 11/4/13.
//  Copyright (c) 2013 CCDevelopment. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrganizeViewController : UIViewController <UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *sortOptionPicker;
@property (strong, nonatomic) NSArray *sortOptionsArray;

@end
