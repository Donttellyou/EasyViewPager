//
//  EKTabHostDelegate.h
//  EasyViewPager
//
//  Created by Lucas Medeiros Leite on 10/27/13.
//  Copyright (c) 2013 CB3 Tecnologia Criativa Ltda. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol EKTabHostDelegate < NSObject, UIScrollViewDelegate >

@optional

- (void)tabHostsContainer:(EKTabHostsContainer *)container didSelectTabHostAtIndex:(NSInteger)index;

- (UIColor *)tabHostsContainer:(EKTabHostsContainer *)container topColorForTabHostAtIndex:(NSInteger)index;
- (UIColor *)tabHostsContainer:(EKTabHostsContainer *)container bottomColorForTabHostAtIndex:(NSInteger)index;
- (UIColor *)tabHostsContainer:(EKTabHostsContainer *)container selectedColorForTabHostAtIndex:(NSInteger)index;
- (UIColor *)tabHostsContainer:(EKTabHostsContainer *)container titleColorForTabHostAtIndex:(NSInteger)index;
- (UIFont  *)tabHostsContainer:(EKTabHostsContainer *)container titleFontForTabHostAtIndex:(NSInteger)index;

@end
