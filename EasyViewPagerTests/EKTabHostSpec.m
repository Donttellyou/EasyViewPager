#import "Kiwi.h"
#import "EKTabHost.h"

SPEC_BEGIN(EKTabHostSped)

    __block EKTabHost *tabHost;

    beforeEach(^{
        tabHost = [[EKTabHost alloc] init];
    });

    it(@"should be an UIView", ^{
        [[tabHost should] beKindOfClass:[UIView class]];
    });

    describe(@"properties", ^{
        
        it(@"should have an indicator tha tabhost is selected", ^{
            [[tabHost should] respondToSelector:@selector(isSelected)];
        });
        
        it(@"should have a topColor", ^{
            [[tabHost should] respondToSelector:@selector(topColor)];
        });
        
        it(@"should have a selectedColor", ^{
            [[tabHost should] respondToSelector:@selector(selectedColor)];
        });
        
        it(@"should have an unselectedColor", ^{
            [[tabHost should] respondToSelector:@selector(bottomColor)];
        });
        
        it(@"should have a content view", ^{
            [[tabHost should] respondToSelector:@selector(contentView)];
        });
        
        it(@"should have a title font", ^{
            [[tabHost should] respondToSelector:@selector(titleFont)];
        });
        
        it(@"should have a title color", ^{
            [[tabHost should] respondToSelector:@selector(titleColor)];
        });
        
        it(@"should have a title", ^{
            [[tabHost should] respondToSelector:@selector(title)];
        });
    
    });

    describe(@"methods", ^{
        
        it(@"should respond to setTitle:", ^{
            [[tabHost should] respondToSelector:@selector(setTitle:)];
        });
        
    });

    describe(@"#initWithFrame:", ^{
       
        __block EKTabHost *tabHost;
        
        beforeEach(^{
            tabHost = [[EKTabHost alloc] initWithFrame:CGRectMake(0, 0, 160, 44)];
        });
        
        it(@"should have its background color set to clear color", ^{
            [[tabHost.backgroundColor should] equal:[UIColor clearColor]];
        });
        
    });

    describe(@"#setSelected:", ^{
        
        __block EKTabHost *tabHost;
        
        beforeEach(^{
            tabHost = [[EKTabHost alloc] initWithFrame:CGRectMake(0, 0, 160, 44)];
        });
        
        it(@"should update views state", ^{
            [[tabHost should] receive:@selector(setNeedsDisplay)];
            [tabHost setSelected:YES];
        });
        
    });

    describe(@"#setTitle:", ^{
        
        __block EKTabHost *tabHost;
        
        beforeEach(^{
            tabHost = [[EKTabHost alloc] initWithFrame:CGRectMake(0, 0, 160, 44)];
        });
        
        describe(@"creating contenview view", ^{
           
            context(@"when content view is nil", ^{
               
                it(@"should create an uilabel", ^{
                    [[tabHost should] receive:@selector(newLabel)];
                    [tabHost setTitle:@"Some title"];
                });
                
                it(@"should apply title font", ^{
                    [[tabHost should] receive:@selector(applyTitleFont)];
                    [tabHost setTitle:@"Some title"];
                });
                
                it(@"should apply title color", ^{
                    [[tabHost should] receive:@selector(applyTitleColor)];
                    [tabHost setTitle:@"Some title"];
                });
                
            });
            
            context(@"when content view is already and uilabel", ^{
            
                __block EKTabHost *tabHost;
                
                beforeEach(^{
                    tabHost = [[EKTabHost alloc] initWithFrame:CGRectMake(0, 0, 160, 44)];
                    tabHost.contentView = [[UILabel alloc] init];
                    [tabHost addSubview:tabHost.contentView];
                });
                
                it(@"should not create a new label", ^{
                    [[tabHost shouldNot] receive:@selector(newLabel)];
                    [tabHost setTitle:@"Some title"];
                });
                
                it(@"should not apply title font", ^{
                    [[tabHost shouldNot] receive:@selector(applyTitleFont)];
                    [tabHost setTitle:@"Some title"];
                });
                
                it(@"should not apply title color", ^{
                    [[tabHost shouldNot] receive:@selector(applyTitleColor)];
                    [tabHost setTitle:@"Some title"];
                });
            });
            
            context(@"when contentview is not an uilabel", ^{
                
                __block EKTabHost *tabHost;
                
                beforeEach(^{
                    tabHost = [[EKTabHost alloc] initWithFrame:CGRectMake(0, 0, 160, 44)];
                    tabHost.contentView = [[UIButton alloc] init];
                    [tabHost addSubview:tabHost.contentView];
                });
                
                it(@"should not create a new label", ^{
                    [[tabHost should] receive:@selector(newLabel)];
                    [tabHost setTitle:@"Some title"];
                });
                
                it(@"should apply title font", ^{
                    [[tabHost should] receive:@selector(applyTitleFont)];
                    [tabHost setTitle:@"Some title"];
                });
                
                it(@"should apply title color", ^{
                    [[tabHost should] receive:@selector(applyTitleColor)];
                    [tabHost setTitle:@"Some title"];
                });
                
            });
            
            it(@"should have its contentView as type of UILabel", ^{
                [tabHost setTitle:@"Some title"];
                [[tabHost.contentView should] beKindOfClass:[UILabel class]];
            });
            
        });
        
    });

    describe(@"#drawRect:", ^{
        
        __block EKTabHost *tabHost;
        
        beforeEach(^{
            tabHost = [[EKTabHost alloc] initWithFrame:CGRectMake(0, 0, 160, 44)];
        });
        
        it(@"should draw top line", ^{
            [[tabHost should] receive:@selector(drawTopLine:withRect:)];
            [tabHost drawRect:tabHost.frame];
        });
        
        it(@"should draw bottom line", ^{
            [[tabHost should] receive:@selector(drawBottomLine:withRect:)];
            [tabHost drawRect:tabHost.frame];
        });

        context(@"when its selected", ^{
            
            it(@"should draw selected line", ^{
                [[tabHost should] receive:@selector(drawSelectedLine:withRect:)];
                [tabHost setSelected:YES];
                [tabHost drawRect:tabHost.frame];
            });
            
        });

        context(@"when its unselected", ^{
            
            it(@"should not draw the selected line", ^{
                [[tabHost shouldNot] receive:@selector(drawSelectedLine:withRect:)];
                [tabHost setSelected:NO];
                [tabHost drawRect:tabHost.frame];
            });
            
        });
        
    });

SPEC_END
