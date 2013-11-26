//
//  ImageViewController.h
//  CampusCritic
//
//  Created by Andrea Flores on 11/25/13.
//  Copyright (c) 2013 CCDevelopment. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic,weak)IBOutlet UIImageView *imageView;

@property (strong, nonatomic) NSData *userImageUpload;

-(IBAction)takePicture:(id)sender;

-(IBAction)chooseFromGallery;

@end

UIImage *image;
UIImageView *imageView;