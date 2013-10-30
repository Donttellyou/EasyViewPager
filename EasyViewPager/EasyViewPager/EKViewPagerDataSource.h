//
//  EKViewPagerDataSource.h
//  EasyViewPager
//
//  Created by Lucas Medeiros Leite on 10/28/13.
//  Copyright (c) 2013 CB3 Tecnologia Criativa Ltda. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EKViewPager;

@protocol EKViewPagerDataSource <NSObject>

@required

- (NSInteger)numberOfItemsForViewPager:(EKViewPager *)viewPager;

- (UIViewController *)viewPager:(EKViewPager *)viewPager controllerAtIndex:(NSInteger)index;

@optional

- (NSString *)viewPager:(EKViewPager *)viewPager titleForItemAtIndex:(NSInteger)index;
- (UIView *)viewPager:(EKViewPager *)viewPager tabHostViewAtIndex:(NSInteger)index;

@end
