//
//  EKTabHostsContainer.h
//  EasyViewPager
//
//  Created by Lucas Medeiros Leite on 10/27/13.
//  Copyright (c) 2013 CB3 Tecnologia Criativa Ltda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EKTabHostDataSource.h"
#import "EKTabHostDelegate.h"

@class EKTabHost;

@interface EKTabHostsContainer : UIView

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *tabs;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, assign) id<EKTabHostDataSource> dataSource;
@property (nonatomic, assign) id<EKTabHostDelegate> delegate;

- (void)reloadData;

- (NSInteger)indexForTabHost:(EKTabHost *)tabHost;
- (EKTabHost *)tabHostAtIndex:(NSInteger)index;

- (void)moveToCorrectPointOfScrollViewAtIndex:(NSInteger)index;
- (void)unselectAllTabHosts;

@end
