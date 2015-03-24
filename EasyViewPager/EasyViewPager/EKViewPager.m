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

@interface EKViewPager() < UIScrollViewDelegate, EKTabHostDataSource, EKTabHostDelegate > {
    NSInteger _previousIndex;
}

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

- (void) layoutSubviews {
    self.tabHostsContainer.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), 44.0f);
    [self.tabHostsContainer layoutSubviews];
    
    CGRect contentFrame = CGRectMake(0, CGRectGetHeight(self.tabHostsContainer.frame), CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) - CGRectGetHeight(self.tabHostsContainer.frame));
    self.contentView.frame = contentFrame;
    
    for (int index =0;index<self.contents.count;index++) {
        UIView* view = [self.contents objectAtIndex:index];
        contentFrame.origin.y = 0;
        CGRect bounds = contentFrame;
        bounds.origin.x = index * CGRectGetWidth(bounds);
        view.frame = bounds;
        [view layoutSubviews];
    }
    CGFloat width = CGRectGetWidth(self.bounds) * [self.contents count];
    CGFloat height = CGRectGetHeight(self.contentView.bounds);
    self.contentView.contentSize = CGSizeMake(width, height);
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
    CGRect contentFrame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) - CGRectGetHeight(self.tabHostsContainer.frame));
    _contentControllers = [NSMutableArray arrayWithCapacity:capacity];
    for (NSInteger i = 0; i < capacity; i++) {
        
        UIViewController *controller = [self.dataSource viewPager:self controllerAtIndex:i];
        
        UIView *controllerView = controller.view;
        CGRect frame = contentFrame;
        frame.origin.x = i * CGRectGetWidth(self.bounds);
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
        self.currentIndex = index;
        
        [UIView animateWithDuration:0.2 animations:^{
            CGPoint point = [[self.contentControllers objectAtIndex:self.currentIndex] frame].origin;
            self.contentView.contentOffset = point;
        }];
        
        if ([self.delegate respondsToSelector:@selector(viewPager:tabHostClickedAtIndex:)]) {
            [self.delegate viewPager:self tabHostClickedAtIndex:index];
        }
        
    }
}

#pragma mark - UIScrollViewDelegate

- (void) scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if (scrollView == self.contentView) {
        
        _previousIndex = self.currentIndex;
        NSUInteger nearestIndex = (NSUInteger)(targetContentOffset->x / scrollView.bounds.size.width + 0.5f);
        nearestIndex = MAX( MIN( nearestIndex, [self.contentControllers count] - 1 ), 0 );
        
        if ([self.delegate respondsToSelector:@selector(viewPager:willMoveFromIndex:toIndex:)]) {
            [self.delegate viewPager:self willMoveFromIndex:_previousIndex toIndex:nearestIndex];
        }
        
        self.currentIndex = nearestIndex;
    }
}

- (void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (scrollView == self.contentView) {
        if (self.currentIndex >= 0 && self.currentIndex < [self.dataSource numberOfItemsForViewPager:self]) {
            
            if ([self.delegate respondsToSelector:@selector(viewPager:didMoveFromIndex:toIndex:)]) {
                [self.delegate viewPager:self didMoveFromIndex:_previousIndex toIndex:self.currentIndex];
            }
            
            [self.tabHostsContainer unselectAllTabHosts];
            [self.tabHostsContainer moveToCorrectPointOfScrollViewAtIndex:self.currentIndex];
            [[self.tabHostsContainer tabHostAtIndex:self.currentIndex] setSelected:YES];
        }
        [scrollView setContentOffset:CGPointMake(scrollView.bounds.size.width * self.currentIndex, 0) animated:YES];
    }
}

@end
