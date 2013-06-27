//
//  TouchViewController.m
//  TouchNavigation
//
//  Created by yuzhou on 13-6-20.
//  Copyright (c) 2013年 wzyk. All rights reserved.
//

#import "TouchViewController.h"
#import "TouchNavigationController.h"
#import <QuartzCore/QuartzCore.h>

@interface TouchViewController ()

@end

@implementation TouchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    self.view.layer.shadowRadius = 8;
    self.view.layer.shadowOffset = CGSizeMake(0, -9);
    self.view.layer.shadowOpacity = 0.8;
    self.view.layer.masksToBounds = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
