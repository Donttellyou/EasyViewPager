//
//  EKViewPagerController.m
//  EasyViewPager
//
//  Created by Lucas Medeiros Leite on 10/30/13.
//  Copyright (c) 2013 CB3 Tecnologia Criativa Ltda. All rights reserved.
//

#import "EKViewPagerController.h"

@interface EKViewPagerController ()

@end

@implementation EKViewPagerController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.viewPager = [[EKViewPager alloc] initWithFrame:self.view.bounds];
    self.viewPager.dataSource = self;
    self.viewPager.delegate = self;
    [self.view addSubview:self.viewPager];
}

#pragma mark - EKViewPagerDataSource

- (NSInteger)numberOfItemsForViewPager:(EKViewPager *)viewPager
{
    @throw ([NSException exceptionWithName:@"ViewPagerException"
                                    reason:@"numberOfItemsForViewPager: not implemented"
                                  userInfo:nil]);
}

- (UIViewController *)viewPager:(EKViewPager *)viewPager controllerAtIndex:(NSInteger)index
{
    @throw ([NSException exceptionWithName:@"ViewPagerException"
                                    reason:@"viewPager:controllerAtIndex: not implemented"
                                  userInfo:nil]);
}

@end
