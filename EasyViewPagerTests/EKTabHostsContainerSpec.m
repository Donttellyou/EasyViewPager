#import "Kiwi.h"
#import "EKTabHostsContainer.h"
#import "FakeDataSource.h"
#import "IncompleteFakeDataSource.h"

SPEC_BEGIN(EKTabHostsContainerSpec)

    __block EKTabHostsContainer *container;

    beforeEach(^{
        container = [[EKTabHostsContainer alloc] init];
    });

    it(@"should be an UIView", ^{
        [[container should] beKindOfClass:[UIView class]];
    });

    describe(@"properties", ^{
       
        it(@"should have a scrollView", ^{
            [[container should] respondToSelector:@selector(scrollView)];
        });
        
        it(@"should have tabs", ^{
            [[container should] respondToSelector:@selector(tabs)];
        });
        
        it(@"should have a dataSource", ^{
            [[container should] respondToSelector:@selector(dataSource)];
        });
        
        it(@"should have a delegate", ^{
            [[container should] respondToSelector:@selector(delegate)];
        });
        
        it(@"should have a selectedIndex", ^{
            [[container should] respondToSelector:@selector(selectedIndex)];
        });
        
    });

    describe(@"methods", ^{
        
        it(@"should respond to reloadData", ^{
            [[container should] respondToSelector:@selector(reloadData)];
        });
        
        it(@"should respond to tabHostAtIndex:", ^{
            [[container should] respondToSelector:@selector(tabHostAtIndex:)];
        });
        
        it(@"should respond to indexForTabHost:",  ^{
            [[container should] respondToSelector:@selector(indexForTabHost:)];
        });
        
    });

    describe(@"#initWithFrame:", ^{
        
        beforeEach(^{
            container = [[EKTabHostsContainer alloc] initWithFrame:CGRectMake(0, 0, 320, 44.0f)];
        });
        
        it(@"should have a scrollView created", ^{
            [[container.scrollView shouldNot] beNil];
        });
        
        it(@"should its scrollView color set to clear", ^{
            [[container.scrollView.backgroundColor should] equal:[UIColor clearColor]];
        });
        
    });

    describe(@"#reloadData", ^{
        
        __block FakeDataSource *containerDataSource;
        
        beforeEach(^{
            container = [[EKTabHostsContainer alloc] initWithFrame:CGRectMake(0, 0, 320, 44.0f)];
            containerDataSource = [[FakeDataSource alloc] init];
        });
        
        it(@"should warn when there is no dataSource", ^{
        
            [[theBlock(^{
                [container reloadData];
            }) should] raiseWithName:@"DataSourceNotFoundException" reason:@"There is no dataSource for the tabHostContainer"];
            
        });
        
        it(@"should warn where there is no implementation of title nor view", ^{
            IncompleteFakeDataSource *dataSource = [[IncompleteFakeDataSource alloc] init];
            container.dataSource = dataSource;
            [[theBlock(^{
                [container reloadData];
            }) should] raiseWithName:@"DataSourceIncompleteImplementationException"
                              reason:@"You should implement #tabHostsContainer:titleAtIndex: or #tabHostsContainer:viewAtIndex:"];
        });
        
        context(@"initializing based on dataSource", ^{
            
            beforeEach(^{
                container.dataSource = containerDataSource;
                [container reloadData];
            });
            
            it(@"should populate scrollView subviews", ^{
                [[theValue([container.scrollView.subviews count]) should] equal:theValue([containerDataSource numberOfTabHostsWithContainer:container])];
                
            });
            
            it(@"should set tabHostsContainer tabs", ^{
                [[theValue([container.tabs count]) should] equal:theValue([containerDataSource numberOfTabHostsWithContainer:container])];
            });
            
        });
        
    });


SPEC_END

