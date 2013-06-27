//
//  TouchNavigationController.h
//  TouchNavigation
//
//  Created by yuzhou on 13-6-20.
//  Copyright (c) 2013年 wzyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TouchViewController;

@interface TouchNavigationController : UIViewController

@property (nonatomic,retain) NSArray *viewControllers;

- (id)initWithRootViewController:(TouchViewController *)viewController;
- (void)pushViewController:(TouchViewController *)viewController animated:(BOOL)animated;
- (void)popViewControllerAnimated:(BOOL)animated;

@end
