//
//  EKTabHostsContainer.m
//  EasyViewPager
//
//  Created by Lucas Medeiros Leite on 10/27/13.
//  Copyright (c) 2013 CB3 Tecnologia Criativa Ltda. All rights reserved.
//

#import "EKTabHostsContainer.h"
#import "EKTabHost.h"

@interface EKTabHostsContainer()

@property (nonatomic, strong) NSMutableArray *tabsArray;

@end

@implementation EKTabHostsContainer

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonSetup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonSetup];
    }
    return self;
}

- (void)commonSetup
{
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.bounces = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
}

- (void)reloadData
{
    [self checkIfDataSourceIsSet];
    [self checkDataSourceConsistence];
    [[self.scrollView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self createTabs];
}

- (void)checkIfDataSourceIsSet
{
    if (!self.dataSource) {
        @throw ([NSException exceptionWithName:@"DataSourceNotFoundException"
                                        reason:@"There is no dataSource for the tabHostContainer"
                                      userInfo:nil]);
    }
}

- (void)checkDataSourceConsistence
{
    if (![self isDataSourceConsistent]) {
        @throw ([NSException exceptionWithName:@"DataSourceIncompleteImplementationException"
                                        reason:@"You should implement #tabHostsContainer:titleAtIndex: or #tabHostsContainer:viewAtIndex:"
                                      userInfo:nil]);
    }
}

- (BOOL)isDataSourceConsistent
{
    return [self.dataSource respondsToSelector:@selector(tabHostsContainer:titleAtIndex:)] ||
           [self.dataSource respondsToSelector:@selector(tabHostsContainer:viewAtIndex:)];
    
}

- (void)createTabs
{
    NSInteger capacity = [self.dataSource numberOfTabHostsWithContainer:self];
    _tabsArray = [NSMutableArray arrayWithCapacity:capacity];
    for (NSInteger i = 0; i < capacity; i++) {
        [self createViewForIndex:i withCapacity:capacity];
    }
    self.tabs = _tabsArray;
}

- (void)createViewForIndex:(NSInteger)index withCapacity:(NSInteger)capacity;
{
    EKTabHost *tabHost;
    if ([self.dataSource respondsToSelector:@selector(tabHostsContainer:titleAtIndex:)] &&
        ![self.dataSource respondsToSelector:@selector(tabHostsContainer:viewAtIndex:)]) {
        tabHost = [self createTabHostForTitleAtIndex:index withCapacity:capacity];
    } else {
        tabHost = [self createTabHostForViewAtIndex:index withCapacity:capacity];
    }
    
    [self.scrollView addSubview:tabHost];
    [_tabsArray addObject:tabHost];
    
    if ([self.delegate respondsToSelector:@selector(tabHostsContainer:didSelectTabHostAtIndex:)]) {
        [tabHost onClick:^(EKTabHost *tabHost) {
            [[self.scrollView subviews] makeObjectsPerformSelector:@selector(setSelected:) withObject:[NSNumber numberWithBool:NO]];
            [tabHost setSelected:YES];
            [self.delegate tabHostsContainer:self didSelectTabHostAtIndex:index];
        }];
    }
    
    CGFloat width = CGRectGetWidth(self.scrollView.frame) * [self.tabs count];
    CGFloat height = CGRectGetHeight(self.scrollView.frame);
    self.scrollView.contentSize = CGSizeMake(width, height);
    
}

- (EKTabHost *)createTabHostForTitleAtIndex:(NSInteger)index withCapacity:(NSInteger)capacity
{
    EKTabHost *tabHost;
    if (capacity == 1) {
        tabHost = [[EKTabHost alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    } else if (capacity == 2) {
        CGFloat witdh = CGRectGetWidth(self.frame)/2;
        tabHost = [[EKTabHost alloc] initWithFrame:CGRectMake(witdh * index, 0, witdh, CGRectGetHeight(self.frame))];
    } else {
        CGFloat witdh = CGRectGetWidth(self.frame)/3;
        tabHost = [[EKTabHost alloc] initWithFrame:CGRectMake(witdh * index, 0, witdh, CGRectGetHeight(self.frame))];
    }
    [tabHost setTitle:[self.dataSource tabHostsContainer:self titleAtIndex:index]];
    return tabHost;
}

- (EKTabHost *)createTabHostForViewAtIndex:(NSInteger)index withCapacity:(NSInteger)capacity
{
    EKTabHost *tabHost;
    if (capacity == 1) {
        tabHost = [[EKTabHost alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    } else if (capacity == 2) {
        CGFloat witdh = CGRectGetWidth(self.frame)/2;
        tabHost = [[EKTabHost alloc] initWithFrame:CGRectMake(witdh * index, 0, witdh, CGRectGetHeight(self.frame))];
    } else {
        CGFloat witdh = CGRectGetWidth(self.frame)/3;
        tabHost = [[EKTabHost alloc] initWithFrame:CGRectMake(witdh * index, 0, witdh, CGRectGetHeight(self.frame))];
    }
    [tabHost setContentView:[self.dataSource tabHostsContainer:self viewAtIndex:index]];
    return tabHost;
}

- (NSInteger)indexForTabHost:(EKTabHost *)tabHost
{
    return [self.tabs indexOfObject:tabHost];
}

- (EKTabHost *)tabHostAtIndex:(NSInteger)index
{
    return [self.tabs objectAtIndex:index];
}

@end
