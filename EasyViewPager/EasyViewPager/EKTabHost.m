//
//  EKTabHost.m
//  EasyViewPager
//
//  Created by Lucas Medeiros Leite on 10/25/13.
//  Copyright (c) 2013 CB3 Tecnologia Criativa Ltda. All rights reserved.
//

#import "EKTabHost.h"
#import <objc/runtime.h>

static char BlockKey;

@implementation EKTabHost

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonSetup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonSetup];
    }
    return self;
}

- (void)commonSetup
{
    self.backgroundColor = [UIColor clearColor];
}

- (void)setContentView:(UIView *)contentView
{
    if (_contentView) {
        [_contentView removeFromSuperview];
    }
    _contentView = contentView;
    [self addSubview:_contentView];
    [self bringSubviewToFront:_contentView];
}

- (void)setSelected:(BOOL)selected
{
    _selected = selected;
    [self setNeedsDisplay];
}

- (NSString *)title
{
    if ([self labelNotPrensent]) {
        return nil;
    }
    return [(UILabel *)_contentView text];
}

- (void)setTitle:(NSString *)title
{
    if ([self labelNotPrensent]) {
        self.contentView = [self newLabel];
        [self applyTitleColor];
        [self applyTitleFont];
    }
    UILabel *titleLabel = (UILabel *)self.contentView;
    titleLabel.text = title;
    [self adjustLabel:titleLabel];
}

- (BOOL)labelNotPrensent
{
    return !self.contentView || ![self.contentView isKindOfClass:[UILabel class]];
}

- (UILabel *)newLabel
{
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    return label;
}

- (void)applyTitleFont
{
    [(UILabel *)_contentView setFont:self.titleFont];
}

- (void)applyTitleColor
{
    [(UILabel *)_contentView setTextColor:self.titleColor];
}

- (void)adjustLabel:(UILabel *)label
{
    CGSize size = [label sizeThatFits:self.frame.size];
    if (size.width > CGRectGetWidth(self.frame)) {
        size.width = CGRectGetWidth(self.frame);
    }
    CGRect titleFrame = label.frame;
    titleFrame.size = size;
    label.frame = titleFrame;
    label.adjustsFontSizeToFitWidth = YES;
    label.center = CGPointMake(CGRectGetWidth(self.bounds) / 2, CGRectGetHeight(self.bounds) / 2 );
}

- (void)drawRect:(CGRect)rect
{
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [self drawTopLine:bezierPath withRect:rect];
    bezierPath = [UIBezierPath bezierPath];
    [self drawBottomLine:bezierPath withRect:rect];
    
    if ([self isSelected]) {
        bezierPath = [UIBezierPath bezierPath];
        [self drawSelectedLine:bezierPath withRect:rect];
    }
}

- (void)drawTopLine:(UIBezierPath *)bezierPath withRect:(CGRect)rect
{
    [bezierPath moveToPoint:CGPointMake(0.0, 0.0)];
    [bezierPath addLineToPoint:CGPointMake(CGRectGetWidth(rect), 0.0)];
    if (self.topColor) {
        [self.topColor setStroke];
    } else {
        [[self defaultColor] setStroke];
    }
    [bezierPath setLineWidth:1.0];
    [bezierPath stroke];
}

- (void)drawBottomLine:(UIBezierPath *)bezierPath withRect:(CGRect)rect
{
    [bezierPath moveToPoint:CGPointMake(0.0, CGRectGetHeight(rect))];
    [bezierPath addLineToPoint:CGPointMake(CGRectGetWidth(rect), CGRectGetHeight(rect))];
    if (self.bottomColor) {
        [self.bottomColor setStroke];
    } else {
        [[self defaultColor] setStroke];
    }
    [bezierPath setLineWidth:1.0];
    [bezierPath stroke];
}

- (void)drawSelectedLine:(UIBezierPath *)bezierPath withRect:(CGRect)rect
{
    [bezierPath moveToPoint:CGPointMake(0.0, CGRectGetHeight(rect) - 1.0)];
    [bezierPath addLineToPoint:CGPointMake(CGRectGetWidth(rect), CGRectGetHeight(rect) - 1.0)];
    [bezierPath setLineWidth:5.0];
    if (self.selectedColor) {
        [self.selectedColor setStroke];
    } else {
        [[self defaultColor] setStroke];
    }
    
    [bezierPath stroke];
}

- (UIColor *)defaultColor
{
    return [UIColor colorWithWhite:197.0/255.0 alpha:0.75];
}

- (void)onClick:(TabHostBlock)tabHostBlock
{
    objc_setAssociatedObject(self, &BlockKey, tabHostBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(executeBlock:)];
    [self addGestureRecognizer:tapGesture];
}

- (void)executeBlock:(UIGestureRecognizer *)gesture
{
    TabHostBlock block = objc_getAssociatedObject(self, &BlockKey);
    if (block) {
        block(self);
    }
}

@end
