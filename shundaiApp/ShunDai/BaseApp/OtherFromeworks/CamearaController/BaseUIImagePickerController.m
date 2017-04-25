//
//  BaseUIImagePickerController.m
//  PhonePlus
//
//  Created by lihuan on 12-12-19.
//  Copyright (c) 2012年 LongMaster Inc. All rights reserved.
//

#import "BaseUIImagePickerController.h"
#import "AppDelegate.h"

@interface BaseUIImagePickerController ()

@end

@implementation BaseUIImagePickerController

-(void)dealloc
{
   
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)dismissViewController
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    

}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
