//
//  EKTabHostDataSource.h
//  EasyViewPager
//
//  Created by Lucas Medeiros Leite on 10/27/13.
//  Copyright (c) 2013 CB3 Tecnologia Criativa Ltda. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EKTabHostsContainer;

@protocol EKTabHostDataSource <NSObject>

- (NSInteger)numberOfTabHostsWithContainer:(EKTabHostsContainer *)container;

@optional

- (NSString *)tabHostsContainer:(EKTabHostsContainer *)container titleAtIndex:(NSInteger)index;

- (UIView *)tabHostsContainer:(EKTabHostsContainer *)container viewAtIndex:(NSInteger)index;

@end
