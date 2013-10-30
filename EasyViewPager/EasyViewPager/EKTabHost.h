//
//  EKTabHost.h
//  EasyViewPager
//
//  Created by Lucas Medeiros Leite on 10/25/13.
//  Copyright (c) 2013 CB3 Tecnologia Criativa Ltda. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EKTabHost;

typedef void (^TabHostBlock)(EKTabHost *tabHost);

@interface EKTabHost : UIView < UIAppearance >

@property (nonatomic, strong) UIColor  *selectedColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIView   *contentView;
@property (nonatomic, strong) UIColor  *bottomColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor  *titleColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIFont   *titleFont UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor  *topColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, copy)   NSString *title;

@property (nonatomic, assign, getter = isSelected) BOOL selected;

- (void)setTitle:(NSString *)title;
- (void)onClick:(TabHostBlock)tabHostBlock;

@end
