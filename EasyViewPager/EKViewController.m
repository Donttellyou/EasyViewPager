//
//  EKViewController.m
//  EasyViewPager
//
//  Created by Lucas Medeiros Leite on 10/25/13.
//  Copyright (c) 2013 CB3 Tecnologia Criativa Ltda. All rights reserved.
//

#import "EKViewController.h"
#import "UICustomView.h"

@interface EKViewController ()

@end

@implementation EKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.leftTabHost.selectedColor = [UIColor redColor];
    self.leftTabHost.titleFont = [UIFont systemFontOfSize:14.0f];
    self.leftTabHost.titleColor = [UIColor blueColor];
    [self.leftTabHost setTitle:@"Drinks"];
    [self.leftTabHost setSelected:YES];
    
    self.rightTabHost.contentView = [[UICustomView alloc] init];
    self.rightTabHost.selectedColor = [UIColor blueColor];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)changeSelection:(id)sender{
    
    if ([self.leftTabHost isSelected]) {
        [_rightTabHost setSelected:YES];
        [_leftTabHost setSelected:NO];
    } else if ([self.rightTabHost isSelected]) {
        [_rightTabHost setSelected:NO];
        [_leftTabHost setSelected:YES];
    }
   
}

- (IBAction)changeToLargerText:(id)sender
{
    [_rightTabHost setTitle:@"Some larger text that fits"];
}

@end
