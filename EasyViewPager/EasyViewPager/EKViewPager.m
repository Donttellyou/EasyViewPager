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

@interface EKViewPager() < UIScrollViewDelegate, EKTabHostDataSource, EKTabHostDelegate >

@property (nonatomic, strong) NSMutableArray *contentControllers;

@end

@implementation EKViewPager

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commontSetup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commontSetup];
    }
    return self;
}

- (void)commontSetup
{
    self.tabHostsContainer = [[EKTabHostsContainer alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), 44.0f)];
    self.tabHostsContainer.dataSource = self;
    self.tabHostsContainer.delegate = self;
    [self addSubview:self.tabHostsContainer];
    
    CGRect contentFrame = CGRectMake(0, CGRectGetHeight(self.tabHostsContainer.frame), CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) - CGRectGetHeight(self.tabHostsContainer.frame));
    self.contentView = [[UIScrollView alloc] initWithFrame:contentFrame];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.contentView.showsHorizontalScrollIndicator = NO;
    self.contentView.bounces = NO;
    self.contentView.pagingEnabled = YES;
    self.contentView.decelerationRate = UIScrollViewDecelerationRateFast;
    self.contentView.delegate = self;
    [self addSubview:self.contentView];
    
}

- (void)reloadData
{
    _currentIndex = 0;
    
    [self.tabHostsContainer reloadData];
    [[self.tabHostsContainer.tabs firstObject] setSelected:YES];
    
    [[self.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];

    [self createPages];
}

- (void)createPages
{
    NSInteger capacity  = [self.dataSource numberOfItemsForViewPager:self];
    _contentControllers = [NSMutableArray arrayWithCapacity:capacity];
    for (NSInteger i = 0; i < capacity; i++) {
        
        UIViewController *controller = [self.dataSource viewPager:self controllerAtIndex:i];
        
        UIView *controllerView = controller.view;
        CGRect frame = controllerView.frame;
        frame.origin.x = i * CGRectGetWidth(controllerView.bounds);
        controllerView.frame = frame;
        
        [_contentControllers addObject:controllerView];
        [self.contentView addSubview:controllerView];
        
    }
    self.contents = _contentControllers;
    CGFloat width = CGRectGetWidth(self.bounds) * [self.contents count];
    CGFloat height = CGRectGetHeight(self.contentView.bounds);
    self.contentView.contentSize = CGSizeMake(width, height);
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
        
        if (index > self.currentIndex) {
            self.currentIndex++;
        } else {
            self.currentIndex--;
        }
        
        
        [UIView animateWithDuration:0.2 animations:^{
            CGPoint point = [[self.contentControllers objectAtIndex:self.currentIndex] frame].origin;
            self.contentView.contentOffset = point;
        }];
        
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

#pragma mark - UIScrollViewDelegate

- (void) scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    NSUInteger nearestIndex = (NSUInteger)(targetContentOffset->x / scrollView.bounds.size.width + 0.5f);
    nearestIndex = MAX( MIN( nearestIndex, [self.contentControllers count] - 1 ), 0 );
    self.currentIndex = nearestIndex;
}

- (void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.currentIndex >= 0 && self.currentIndex < [self.dataSource numberOfItemsForViewPager:self]) {
        [self.tabHostsContainer unselectAllTabHosts];
        [self.tabHostsContainer moveToCorrectPointOfScrollViewAtIndex:self.currentIndex];
        [[self.tabHostsContainer tabHostAtIndex:self.currentIndex] setSelected:YES];
    }
    [scrollView setContentOffset:CGPointMake(scrollView.bounds.size.width * self.currentIndex, 0) animated:YES];
}

@end
