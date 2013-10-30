//
//  EKViewPagerDelegate.h
//  EasyViewPager
//
//  Created by Lucas Medeiros Leite on 10/28/13.
//  Copyright (c) 2013 CB3 Tecnologia Criativa Ltda. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EKViewPager;

@protocol EKViewPagerDelegate <NSObject>

@optional

- (void)viewPager:(EKViewPager *)viewPager tabHostClickedAtIndex:(NSInteger)index;

- (UIColor *)viewPager:(EKViewPager *)viewPager topColorForTabHostAtIndex:(NSInteger)index;
- (UIColor *)viewPager:(EKViewPager *)viewPager bottomColorForTabHostAtIndex:(NSInteger)index;
- (UIColor *)viewPager:(EKViewPager *)viewPager selectedColorForTabHostAtIndex:(NSInteger)index;
- (UIColor *)viewPager:(EKViewPager *)viewPager titleColorForTabHostAtIndex:(NSInteger)index;
- (UIFont  *)viewPager:(EKViewPager *)viewPager titleFontForTabHostAtIndex:(NSInteger)index;

@end
