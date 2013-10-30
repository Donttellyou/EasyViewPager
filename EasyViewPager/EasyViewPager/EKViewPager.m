//
//  EKViewPager.m
//  EasyViewPager
//
//  Created by Lucas Medeiros Leite on 10/28/13.
//  Copyright (c) 2013 CB3 Tecnologia Criativa Ltda. All rights reserved.
//

#import "EKViewPager.h"
#import "EKTabHostDataSource.h"
#import "EKTabHostsContainer.h"
#import "EKTabHost.h"

@interface EKViewPager() < UIPageViewControllerDataSource, UIPageViewControllerDelegate, UIScrollViewDelegate, EKTabHostDataSource, EKTabHostDelegate > {
    BOOL _swiped;
}

@property (nonatomic, strong) UIPageViewController *pageController;
@property (nonatomic, weak)   UIScrollView *contentScrollView;
@property (nonatomic, assign) CGFloat lastContentOffset;

@end

@implementation EKViewPager

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _currentIndex = 0;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _currentIndex = 0;
    }
    return self;
}

- (void)reloadData
{
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                          navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                        options:nil];
    self.pageController.dataSource = self;
    self.pageController.delegate = self;
    self.contentScrollView  = [self.pageController.view.subviews objectAtIndex:1];
    self.pageController.view.backgroundColor = [UIColor clearColor];
    self.contentScrollView.backgroundColor = [UIColor clearColor];
    
    self.tabHostsContainer = [[EKTabHostsContainer alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), 44.0f)];
    self.tabHostsContainer.dataSource = self;
    self.tabHostsContainer.delegate = self;
    [self.tabHostsContainer reloadData];
    [self addSubview:self.tabHostsContainer];
    
    CGRect contentFrame = CGRectMake(0, CGRectGetHeight(self.tabHostsContainer.frame), CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) - CGRectGetHeight(self.tabHostsContainer.frame));
    self.contentView = [[UIView alloc] initWithFrame:contentFrame];
    [self.contentView addSubview:self.pageController.view];
    [self addSubview:self.contentView];
    
    UIViewController *firstViewController = [self.dataSource viewPager:self controllerAtIndex:self.currentIndex];
    
    NSArray *viewControllers = @[firstViewController];
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [[self.tabHostsContainer.tabs firstObject] setSelected:YES];
    
}

#pragma mark - EKTabHostsDataSource

- (NSInteger)numberOfTabHostsWithContainer:(EKTabHostsContainer *)container
{
    return [self.dataSource numberOfItemsForViewPager:self];
}

- (NSString *)tabHostsContainer:(EKTabHostsContainer *)container titleAtIndex:(NSInteger)index
{
    if ([self.dataSource respondsToSelector:@selector(viewPager:titleForItemAtIndex:)]) {
        return [self.dataSource viewPager:self titleForItemAtIndex:index];
    }
    return nil;
}

- (UIView *)tabHostsContainer:(EKTabHostsContainer *)container viewAtIndex:(NSInteger)index
{
    if ([self.dataSource respondsToSelector:@selector(viewPager:tabHostViewAtIndex:)]) {
        return [self.dataSource viewPager:self tabHostViewAtIndex:index];
    }
    return nil;
}

#pragma mark - EKTabHostsDelegate

- (void)tabHostsContainer:(EKTabHostsContainer *)container didSelectTabHostAtIndex:(NSInteger)index
{
    
    if (self.currentIndex != index) {
        
        UIPageViewControllerNavigationDirection direction;
        
        if (index > self.currentIndex) {
            direction = UIPageViewControllerNavigationDirectionForward;
        } else {
            direction = UIPageViewControllerNavigationDirectionReverse;
        }
        
        self.currentIndex = index;
        
        UIViewController *viewController = [self.dataSource viewPager:self controllerAtIndex:self.currentIndex];
        NSArray *viewControllers = @[viewController];
        [self.pageController setViewControllers:viewControllers direction:direction animated:YES completion:nil];
        
        if ([self.delegate respondsToSelector:@selector(viewPager:tabHostClickedAtIndex:)]) {
            [self.delegate viewPager:self tabHostClickedAtIndex:index];
        }
        
    }
    
}

- (UIColor *)tabHostsContainer:(EKTabHostsContainer *)container bottomColorForTabHostAtIndex:(NSInteger)index
{
    if ([self.delegate respondsToSelector:@selector(viewPager:bottomColorForTabHostAtIndex:)]) {
        return [self.delegate viewPager:self bottomColorForTabHostAtIndex:index];
    }
    return nil;
}

- (UIColor *)tabHostsContainer:(EKTabHostsContainer *)container selectedColorForTabHostAtIndex:(NSInteger)index
{
    if ([self.delegate respondsToSelector:@selector(viewPager:selectedColorForTabHostAtIndex:)]) {
        return [self.delegate viewPager:self selectedColorForTabHostAtIndex:index];
    }
    return nil;
}

- (UIColor *)tabHostsContainer:(EKTabHostsContainer *)container titleColorForTabHostAtIndex:(NSInteger)index
{
    if ([self.delegate respondsToSelector:@selector(viewPager:titleColorForTabHostAtIndex:)]) {
        return [self.delegate viewPager:self titleColorForTabHostAtIndex:index];
    }
    return nil;
}

- (UIColor *)tabHostsContainer:(EKTabHostsContainer *)container topColorForTabHostAtIndex:(NSInteger)index
{
    if ([self.delegate respondsToSelector:@selector(viewPager:topColorForTabHostAtIndex:)]) {
        return [self.delegate viewPager:self topColorForTabHostAtIndex:index];
    }
    return nil;
}

- (UIFont *)tabHostsContainer:(EKTabHostsContainer *)container titleFontForTabHostAtIndex:(NSInteger)index
{
    if ([self.delegate respondsToSelector:@selector(viewPager:titleFontForTabHostAtIndex:)]) {
        return [self.delegate viewPager:self titleFontForTabHostAtIndex:index];
    }
    return nil;
}

#pragma mark - UIPageViewControllerDataSource

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.dataSource numberOfItemsForViewPager:self];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return _currentIndex;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSInteger index = self.currentIndex - 1;
    if (index < 0) {
        return nil;
    }
    return [self.dataSource viewPager:self controllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger index = self.currentIndex + 1;
    if (index >= [self.dataSource numberOfItemsForViewPager:self]) {
        return nil;
    }
    return [self.dataSource viewPager:self controllerAtIndex:index];
}

#pragma mark - UIPageViewControllerDelegate

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers
{
    _swiped = YES;
    _lastContentOffset = self.contentScrollView.contentOffset.x;
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed;
{
    if (completed && _swiped) {
        
        CGFloat actualOffset = self.contentScrollView.contentOffset.x;
        
        if (_lastContentOffset < actualOffset) {
            self.currentIndex++;
        }
        else if (_lastContentOffset > actualOffset) {
            self.currentIndex--;
        }
        [[self tabHostsContainer] moveToCorrectPointOfScrollViewAtIndex:self.currentIndex];
        [[self tabHostsContainer] unselectAllTabHosts];
        [[[self tabHostsContainer] tabHostAtIndex:self.currentIndex] setSelected:YES];
        _swiped = NO;
    }
}

@end
