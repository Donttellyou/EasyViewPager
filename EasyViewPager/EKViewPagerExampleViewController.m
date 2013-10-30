//
//  EKViewPagerExampleViewController.m
//  EasyViewPager
//
//  Created by Lucas Medeiros Leite on 10/28/13.
//  Copyright (c) 2013 CB3 Tecnologia Criativa Ltda. All rights reserved.
//

#import "EKViewPagerExampleViewController.h"
#import "EKContainerViewController.h"

@interface EKViewPagerExampleViewController ()

@end

@implementation EKViewPagerExampleViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.viewPager reloadData];
}

- (NSInteger)numberOfItemsForViewPager:(EKViewPager *)viewPager
{
    return 10;
}

- (NSString *)viewPager:(EKViewPager *)viewPager titleForItemAtIndex:(NSInteger)index
{
    return [NSString stringWithFormat:@"Title %d", index];
}

- (UIViewController *)viewPager:(EKViewPager *)viewPager controllerAtIndex:(NSInteger)index
{
    EKContainerViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ContentViewController"];
    [controller view];
    controller.titleLabel.text = [NSString stringWithFormat:@"Controller# %d", index];
    return controller;
}

- (void)viewPager:(EKViewPager *)viewPager tabHostClickedAtIndex:(NSInteger)index
{
    NSLog(@"Clicked at %d", index);
}

- (UIColor *)viewPager:(EKViewPager *)viewPager selectedColorForTabHostAtIndex:(NSInteger)index
{
    return [UIColor redColor];
}

- (UIColor *)viewPager:(EKViewPager *)viewPager titleColorForTabHostAtIndex:(NSInteger)index
{
    return [UIColor redColor];
}

- (UIFont *)viewPager:(EKViewPager *)viewPager titleFontForTabHostAtIndex:(NSInteger)index
{
    return [UIFont systemFontOfSize:14.0f];
}

@end
