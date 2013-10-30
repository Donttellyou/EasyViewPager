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
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.bounces = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.scrollEnabled = NO;
    [self addSubview:self.scrollView];
    self.selectedIndex = 0;
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
    CGFloat width = [self tabHostWidthWithCapacity:[self.tabs count]] * [self.tabs count];
    CGFloat height = CGRectGetHeight(self.scrollView.frame);
    self.scrollView.contentSize = CGSizeMake(width, height);
}

- (void)createViewForIndex:(NSInteger)index withCapacity:(NSInteger)capacity;
{
    EKTabHost *tabHost;
    if ([self.dataSource respondsToSelector:@selector(tabHostsContainer:titleAtIndex:)] &&
        (![self.dataSource respondsToSelector:@selector(tabHostsContainer:viewAtIndex:)] || ![self.dataSource tabHostsContainer:self viewAtIndex:index])) {
        tabHost = [self createTabHostForTitleAtIndex:index withCapacity:capacity];
    } else {
        tabHost = [self createTabHostForViewAtIndex:index withCapacity:capacity];
    }
    
    [self.scrollView addSubview:tabHost];
    [_tabsArray addObject:tabHost];
    
    if ([self.delegate respondsToSelector:@selector(tabHostsContainer:didSelectTabHostAtIndex:)]) {
        [tabHost onClick:^(EKTabHost *tabHost) {
            [self moveToCorrectPointOfScrollViewAtIndex:index];
            [self unselectAllTabHosts];
            [tabHost setSelected:YES];
            [self.delegate tabHostsContainer:self didSelectTabHostAtIndex:index];
        }];
    }
}

- (void)moveToCorrectPointOfScrollViewAtIndex:(NSInteger)index
{
    if (index > 0 && index < ([_tabsArray count] - 1)) {
        
        [UIView animateWithDuration:0.2f animations:^{
            CGPoint point = [[_tabsArray objectAtIndex:index-1] frame].origin;
            self.scrollView.contentOffset = point;
        }];
    
    }
}

- (EKTabHost *)createTabHostForTitleAtIndex:(NSInteger)index withCapacity:(NSInteger)capacity
{
    CGFloat width = [self tabHostWidthWithCapacity:capacity];
    EKTabHost *tabHost = [[EKTabHost alloc] initWithFrame:CGRectMake(width * index, 0, width, CGRectGetHeight(self.frame))];
    [self customizeTabHost:tabHost withTitlePropertiesAtIndex:index];
    [tabHost setTitle:[self.dataSource tabHostsContainer:self titleAtIndex:index]];
    return tabHost;
}

- (void)customizeTabHost:(EKTabHost *)tabHost withTitlePropertiesAtIndex:(NSInteger)index
{
    if ([self.delegate respondsToSelector:@selector(tabHostsContainer:topColorForTabHostAtIndex:)]) {
        [tabHost setTopColor:[self.delegate tabHostsContainer:self topColorForTabHostAtIndex:index]];
    }
    
    if ([self.delegate respondsToSelector:@selector(tabHostsContainer:bottomColorForTabHostAtIndex:)]) {
        [tabHost setBottomColor:[self.delegate tabHostsContainer:self bottomColorForTabHostAtIndex:index]];
    }
    
    if ([self.delegate respondsToSelector:@selector(tabHostsContainer:selectedColorForTabHostAtIndex:)]) {
        [tabHost setSelectedColor:[self.delegate tabHostsContainer:self selectedColorForTabHostAtIndex:index]];
    }
    
    if ([self.delegate respondsToSelector:@selector(tabHostsContainer:titleColorForTabHostAtIndex:)]) {
        [tabHost setTitleColor:[self.delegate tabHostsContainer:self titleColorForTabHostAtIndex:index]];
    }
    
    if ([self.delegate respondsToSelector:@selector(tabHostsContainer:titleFontForTabHostAtIndex:)]) {
        [tabHost setTitleFont:[self.delegate tabHostsContainer:self titleFontForTabHostAtIndex:index]];
    }
}

- (EKTabHost *)createTabHostForViewAtIndex:(NSInteger)index withCapacity:(NSInteger)capacity
{
    CGFloat width = [self tabHostWidthWithCapacity:capacity];
    EKTabHost *tabHost = [[EKTabHost alloc] initWithFrame:CGRectMake(width * index, 0, width, CGRectGetHeight(self.frame))];
    [tabHost setContentView:[self.dataSource tabHostsContainer:self viewAtIndex:index]];
    return tabHost;
}

- (void)unselectAllTabHosts
{
    for (EKTabHost *tabHost in self.tabs) {
        [tabHost setSelected:NO];
    }
}

- (NSInteger)tabHostWidthWithCapacity:(NSInteger)capacity
{
    switch (capacity) {
        case 1:
            return CGRectGetWidth(self.frame);
        case 2:
            return CGRectGetWidth(self.frame) / 2;
        default:
            return ceilf(CGRectGetWidth(self.frame) / 3);
    }
    
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
