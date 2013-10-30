//
//  EKViewPager.h
//  EasyViewPager
//
//  Created by Lucas Medeiros Leite on 10/28/13.
//  Copyright (c) 2013 CB3 Tecnologia Criativa Ltda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EKViewPagerDataSource.h"
#import "EKViewPagerDelegate.h"

@class EKTabHostsContainer;

@interface EKViewPager : UIView

@property (nonatomic, strong) EKTabHostsContainer *tabHostsContainer;
@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, assign) IBOutlet id<EKViewPagerDataSource> dataSource;
@property (nonatomic, assign) IBOutlet id<EKViewPagerDelegate> delegate;

@property (nonatomic, assign) NSInteger currentIndex;

- (void)reloadData;

@end
