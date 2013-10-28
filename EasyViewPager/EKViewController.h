//
//  EKViewController.h
//  EasyViewPager
//
//  Created by Lucas Medeiros Leite on 10/25/13.
//  Copyright (c) 2013 CB3 Tecnologia Criativa Ltda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EKTabHostDataSource.h"
#import "EKTabHostDelegate.h"
#import "EKTabHostsContainer.h"
#import "EKTabHost.h"


@interface EKViewController : UIViewController < EKTabHostDataSource, EKTabHostDelegate >

@property (nonatomic, weak) IBOutlet EKTabHostsContainer *container;

@property (nonatomic, weak) IBOutlet EKTabHost *leftTabHost;
@property (nonatomic, weak) IBOutlet EKTabHost *rightTabHost;

@end
