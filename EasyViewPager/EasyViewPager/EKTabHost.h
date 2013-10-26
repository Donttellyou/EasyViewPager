//
//  EKTabHost.h
//  EasyViewPager
//
//  Created by Lucas Medeiros Leite on 10/25/13.
//  Copyright (c) 2013 CB3 Tecnologia Criativa Ltda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EKTabHost : UIView

@property (nonatomic, strong) UIColor  *selectedColor;
@property (nonatomic, strong) UIView   *contentView;
@property (nonatomic, strong) UIColor  *bottomColor;
@property (nonatomic, strong) UIColor  *titleColor;
@property (nonatomic, strong) UIFont   *titleFont;
@property (nonatomic, strong) UIColor  *topColor;
@property (nonatomic, copy)   NSString *title;

@property (nonatomic, assign, getter = isSelected) BOOL selected;

- (void)setTitle:(NSString *)title;

@end
