//
//  EKViewPagerController.h
//  EasyViewPager
//
//  Created by Lucas Medeiros Leite on 10/30/13.
//  Copyright (c) 2013 CB3 Tecnologia Criativa Ltda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EKViewPager.h"

@interface EKViewPagerController : UIViewController < EKViewPagerDataSource, EKViewPagerDelegate >

@property (nonatomic, strong) EKViewPager *viewPager;

@end
