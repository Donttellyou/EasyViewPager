//
//  UICustomView.m
//  EasyViewPager
//
//  Created by Lucas Medeiros Leite on 10/26/13.
//  Copyright (c) 2013 CB3 Tecnologia Criativa Ltda. All rights reserved.
//

#import "UICustomView.h"

@implementation UICustomView

- (id)init
{
    self = [[[NSBundle mainBundle] loadNibNamed:@"UICustomView" owner:self options:nil] objectAtIndex:0];
    if (self) {
    
    }
    return self;
}

@end
