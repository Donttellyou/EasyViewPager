//
//  EKThirdViewController.m
//  EasyViewPager
//
//  Created by Lucas Medeiros Leite on 10/30/13.
//  Copyright (c) 2013 CB3 Tecnologia Criativa Ltda. All rights reserved.
//

#import "EKThirdViewController.h"
#import "EKContainerViewController.h"
#import "EKTabHostsContainer.h"
#import "EKTabHost.h"

@interface EKThirdViewController ()

@end

@implementation EKThirdViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [[EKTabHostsContainer appearance] setBackgroundColor:[UIColor redColor]];
    [[EKTabHost appearance] setSelectedColor:[UIColor blackColor]];
    [[EKTabHost appearance] setTitleColor:[UIColor greenColor]];
    [[EKTabHost appearance] setTitleFont:[UIFont systemFontOfSize:12.0f]];
    [self.viewPager reloadData];
}

- (NSInteger)numberOfItemsForViewPager:(EKViewPager *)viewPager
{
    return 5;
}

- (NSString *)viewPager:(EKViewPager *)viewPager titleForItemAtIndex:(NSInteger)index
{
    return [NSString stringWithFormat:@"Title %d", index];
}

- (UIViewController *)viewPager:(EKViewPager *)viewPager controllerAtIndex:(NSInteger)index
{
    EKContainerViewController *container = [self.storyboard instantiateViewControllerWithIdentifier:@"ContentViewController"];
    [container view];
    container.titleLabel.text = [NSString stringWithFormat:@"Controller # %d", index];
    return container;
}

- (void)viewPager:(EKViewPager *)viewPager tabHostClickedAtIndex:(NSInteger)index
{
    NSLog(@"Clicked at %d", index);
}

- (void)viewPager:(EKViewPager *)viewPager willMoveFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex
{
    NSLog(@"Will move from %d to %d", fromIndex, toIndex);
}

- (void)viewPager:(EKViewPager *)viewPager didMoveFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex
{
    NSLog(@"Moved from %d to %d", fromIndex, toIndex);
}

@end
