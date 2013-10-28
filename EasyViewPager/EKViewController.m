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
    
    [self.leftTabHost onClick:^(EKTabHost *tabHost) {
        [self.rightTabHost setSelected:NO];
        [self.leftTabHost setSelected:YES];
    }];
    
    self.rightTabHost.contentView = [[UICustomView alloc] init];
    self.rightTabHost.selectedColor = [UIColor blueColor];

    [self.rightTabHost onClick:^(EKTabHost *tabHost) {
        [self.leftTabHost setSelected:NO];
        [self.rightTabHost setSelected:YES];
    }];
    
    self.container.dataSource = self;
    self.container.delegate = self;
    [self.container reloadData];
    
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

#pragma mark - EKTabHostDataSource

- (NSInteger)numberOfTabHostsWithContainer:(EKTabHostsContainer *)container
{
    return 10;
}

- (NSString *)tabHostsContainer:(EKTabHostsContainer *)container titleAtIndex:(NSInteger)index
{
    return [NSString stringWithFormat:@"Title %d", index];
}

#pragma mark - EKTabHostDelegate

- (void)tabHostsContainer:(EKTabHostsContainer *)container didSelectTabHostAtIndex:(NSInteger)index
{
    NSLog(@"Clicked at index %d", index);
}

- (UIColor *)tabHostsContainer:(EKTabHostsContainer *)container selectedColorForTabHostAtIndex:(NSInteger)index
{
    return [UIColor redColor];
}

- (UIColor *)tabHostsContainer:(EKTabHostsContainer *)container titleColorForTabHostAtIndex:(NSInteger)index
{
    return [UIColor blueColor];
}

- (UIFont *)tabHostsContainer:(EKTabHostsContainer *)container titleFontForTabHostAtIndex:(NSInteger)index
{
    return [UIFont systemFontOfSize:14.0f];
}

@end
