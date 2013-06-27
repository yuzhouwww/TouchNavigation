//
//  TouchNavigationController.m
//  TouchNavigation
//
//  Created by yuzhou on 13-6-20.
//  Copyright (c) 2013年 wzyk. All rights reserved.
//

#define kAnimateDuration 0.5
#define kScaleFactor 0.95
#define kPopDistance 50
#define kBottomAlpha 0.6

#import "TouchNavigationController.h"
#import "TouchViewController.h"

@interface TouchNavigationController ()
{
    TouchViewController *topViewController;
    TouchViewController *bottomViewController;
    
    BOOL gestureBegan;
    BOOL shouldSlide;
}

@property (nonatomic,retain) NSMutableArray *stackViewControllers;

@end

@implementation TouchNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithRootViewController:(TouchViewController *)viewController
{
    self = [super init];
    if (self) {
        self.stackViewControllers = [NSMutableArray arrayWithCapacity:3];
        viewController.touchNavigationController = self;
        [self.stackViewControllers addObject:viewController];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    if (self.stackViewControllers.count > 0) {
        [self transitionViewControllerToTop:[self.stackViewControllers lastObject] animated:NO completion:nil];
    }
    if (self.stackViewControllers.count > 1) {
        [self transitionViewControllerToBottom:[self.stackViewControllers objectAtIndex:self.stackViewControllers.count -2] animated:NO];
    }
    UIPanGestureRecognizer *gesture = [[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)] autorelease];
    gesture.maximumNumberOfTouches = 1;
    [self.view addGestureRecognizer:gesture];
}

- (void)transitionViewControllerToTop:(TouchViewController *)viewController animated:(BOOL)animated completion:(void(^)(BOOL finished))completion
{
    if (viewController.view.superview) {
        [UIView animateWithDuration:animated ? kAnimateDuration : 0 animations:^{
            viewController.view.transform = CGAffineTransformMakeScale(1, 1);
            viewController.view.alpha = 1;
        } completion:^(BOOL finished) {
            if (completion) {
                completion(finished);
            }
        }];
    }
    else {
        CGRect rect = self.view.bounds;
        rect.origin.x = 320;
        viewController.view.frame = rect;
        [self.view addSubview:viewController.view];
        [UIView animateWithDuration:animated ? kAnimateDuration : 0 animations:^{
            CGRect rect = viewController.view.frame;
            rect.origin.x = 0;
            viewController.view.frame = rect;
        } completion:^(BOOL finished) {
            if (completion) {
                completion(finished);
            }
        }];
    }
    topViewController = viewController;
}

- (void)transitionViewControllerToBottom:(TouchViewController *)viewController animated:(BOOL)animated
{
    if (viewController.view.superview) {
        [UIView animateWithDuration:animated ? kAnimateDuration : 0 animations:^{
            viewController.view.transform = CGAffineTransformMakeScale(kScaleFactor, kScaleFactor);
            viewController.view.alpha = kBottomAlpha;
        }];
    }
    else {
        viewController.view.transform = CGAffineTransformMakeScale(1, 1);
        CGRect rect = self.view.bounds;
        rect.origin.x = 320;
        viewController.view.frame = rect;
        [self.view insertSubview:viewController.view belowSubview:topViewController.view];
        [UIView animateWithDuration:animated ? kAnimateDuration : 0 animations:^{
            CGRect rect = viewController.view.frame;
            rect.origin.x = 0;
            viewController.view.frame = rect;
            viewController.view.transform = CGAffineTransformMakeScale(kScaleFactor, kScaleFactor);
            viewController.view.alpha = kBottomAlpha;
        }];
    }
    bottomViewController = viewController;
}

- (void)removeViewController:(TouchViewController *)viewController animated:(BOOL)animated
{
    [UIView animateWithDuration:animated ? kAnimateDuration : 0 animations:^{
        CGRect rect = viewController.view.frame;
        rect.origin.x = 320;
        viewController.view.frame = rect;
    } completion:^(BOOL finished) {
        [viewController.view removeFromSuperview];
        [viewController release];
        NSLog(@"%d",self.stackViewControllers.count);
    }];
}

- (void)dismissViewController:(TouchViewController *)viewController animated:(BOOL)animated
{
    [UIView animateWithDuration:animated ? kAnimateDuration : 0 animations:^{
        CGRect rect = viewController.view.frame;
        rect.origin.x = 320;
        viewController.view.frame = rect;
    } completion:^(BOOL finished) {
        [viewController.view removeFromSuperview];    }];
}

- (void)fadeBottomViewControllerByValue:(float)value
{
    if (bottomViewController) {
        float scale = kScaleFactor + (1 - kScaleFactor) * value;
        float alpha = kBottomAlpha + (1 - kBottomAlpha) * value;
        bottomViewController.view.transform = CGAffineTransformMakeScale(scale, scale);
        bottomViewController.view.alpha  = alpha;
    }
}

- (void)pushViewController:(TouchViewController *)viewController animated:(BOOL)animated
{
    viewController.touchNavigationController = self;
    [self.stackViewControllers addObject:viewController];
    if (bottomViewController) {
        [self dismissViewController:bottomViewController animated:NO];
        bottomViewController = nil;
    }
    [self transitionViewControllerToBottom:topViewController animated:YES];
    [self transitionViewControllerToTop:viewController animated:YES completion:nil];
    NSLog(@"%d",self.stackViewControllers.count);
}

- (void)popViewControllerAnimated:(BOOL)animated
{
    if (self.stackViewControllers.count > 1) {
        TouchViewController *top = [topViewController retain];
        [self removeViewController:top animated:YES];
        [self.stackViewControllers removeObject:topViewController];
        if (self.stackViewControllers.count > 0) {
            [self transitionViewControllerToTop:bottomViewController animated:YES completion:^(BOOL finished) {
                if (self.stackViewControllers.count > 1) {
                    TouchViewController *vc = [self.stackViewControllers objectAtIndex:self.stackViewControllers.count - 2];
                    [self transitionViewControllerToBottom:vc animated:NO];
                }
            }];
            bottomViewController = nil;
        }
    }
}

- (void)panAction:(UIPanGestureRecognizer *)gesture
{
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
            gestureBegan = YES;
            break;
        case UIGestureRecognizerStateChanged:
        {
            if (gestureBegan) {
                float vx = [gesture velocityInView:self.view].x;
                float vy = [gesture velocityInView:self.view].y;
                if (vx != 0 && ABS(vy / vx) <  0.75) {
                    shouldSlide = YES;
                }
                gestureBegan = NO;
            }
            if (shouldSlide) {
                float dx = [gesture translationInView:self.view].x;
                dx = dx >= 0 ? dx : 0;
                CGRect rect = topViewController.view.frame;
                rect.origin.x = self.stackViewControllers.count > 1 ? dx : dx * 0.5;
                topViewController.view.frame = rect;
                [self fadeBottomViewControllerByValue:dx / 320];
            }
        }
            break;
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateEnded:
            if (shouldSlide) {
                if (self.stackViewControllers.count == 1) {
                    [UIView animateWithDuration:0.5 animations:^{
                        CGRect rect = topViewController.view.frame;
                        rect.origin.x = 0;
                        topViewController.view.frame = rect;
                    }];
                }
                else {
                    float dx = [gesture translationInView:self.view].x;
                    if (dx >= kPopDistance) {
                        [self popViewControllerAnimated:YES];
                    }
                    else {
                        [UIView animateWithDuration:0.5 animations:^{
                            CGRect rect = topViewController.view.frame;
                            rect.origin.x = 0;
                            topViewController.view.frame = rect;
                            [self fadeBottomViewControllerByValue:0];
                        }];
                    }
                }
                shouldSlide = NO;
            }
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [self.stackViewControllers release];
    [super dealloc];
}

@end
