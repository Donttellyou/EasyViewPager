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

- (void)viewPager:(EKViewPager *)viewPager willMoveFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex;

- (void)viewPager:(EKViewPager *)viewPager didMoveFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex;

@end
