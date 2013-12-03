//
//  ImageViewController.m
//  CampusCritic
//
//  Created by Andrea Flores on 11/25/13.
//  Copyright (c) 2013 CCDevelopment. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()

@end

@implementation ImageViewController;

-(IBAction)takePicture:(id)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.SourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion: NULL];
    // This Action allows the user to go to the Iphone camera and take a picture
}


-(IBAction)chooseFromGallery
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.SourceType =UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:NULL];
    //This Action allows the user to go to the Gallery and choose a Picture
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.imageView setImage:image];
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    // Resize image
    UIGraphicsBeginImageContext(CGSizeMake(180.0f, 180.0f));
    [image drawInRect: CGRectMake(0, 0, 180.0f, 180.0f)];
    UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Extract Image as JPEG and Set userImageUpload to that Data
    NSData *imageData = UIImageJPEGRepresentation(resizedImage, 0.9f);
    self.userImageUpload = imageData;
    
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTranslucent:NO];
    
    [self.navigationController setToolbarHidden:NO animated:YES];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
