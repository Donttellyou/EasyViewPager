//
//  FakeDataSource.m
//  EasyViewPager
//
//  Created by Lucas Medeiros Leite on 10/27/13.
//  Copyright (c) 2013 CB3 Tecnologia Criativa Ltda. All rights reserved.
//

#import "FakeDataSource.h"

@implementation FakeDataSource

- (NSInteger)numberOfTabHostsWithContainer:(EKTabHostsContainer *)container
{
    return 4;
}

- (NSString *)tabHostsContainer:(EKTabHostsContainer *)container titleAtIndex:(NSInteger)index
{
    return [NSString stringWithFormat:@"Title %d", index];
}

@end
