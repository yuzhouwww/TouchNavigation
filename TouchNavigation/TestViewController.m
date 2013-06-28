//
//  TestViewController.m
//  TouchNavigation
//
//  Created by yuzhou on 13-6-21.
//  Copyright (c) 2013年 wzyk. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

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
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor colorWithRed:arc4random() % 255 / 255.00 green:arc4random() % 255 / 255.00 blue:arc4random() % 255 / 255.00 alpha:1];
}

- (IBAction)navPush:(id)sender {
    TestViewController *testViewController = [[[TestViewController alloc] initWithNibName:@"TestViewController" bundle:nil] autorelease];
    [self.touchNavigationController pushViewController:testViewController animated:YES];
}

- (IBAction)navPop:(id)sender {
//    [self.touchNavigationController popViewControllerAnimated:YES];
    [self.touchNavigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
