//
//  EKViewPagerExampleViewController.h
//  EasyViewPager
//
//  Created by Lucas Medeiros Leite on 10/28/13.
//  Copyright (c) 2013 CB3 Tecnologia Criativa Ltda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EKViewPager.h"

@interface EKViewPagerExampleViewController : UIViewController <EKViewPagerDataSource, EKViewPagerDelegate>

@property (nonatomic, weak) IBOutlet EKViewPager *viewPager;

@end
