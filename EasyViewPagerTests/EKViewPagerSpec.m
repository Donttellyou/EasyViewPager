#import "Kiwi.h"
#import "EKViewPager.h"
#import "EKTabHostsContainer.h"

SPEC_BEGIN(EKViewPagerSpec)

    __block EKViewPager *viewPager;

    beforeEach(^{
        viewPager = [[EKViewPager alloc] init];
    });

    it(@"should be an UIView", ^{
        [[viewPager should] beKindOfClass:[UIView class]];
    });

    describe(@"properties", ^{
       
        it(@"should have an EKTabHostsContainer", ^{
            [[viewPager should] respondToSelector:@selector(tabHostsContainer)];
        });
        
        it(@"should have a contentView", ^{
            [[viewPager should] respondToSelector:@selector(contentView)];
        });
        
        it(@"should have selected item", ^{
            [[viewPager should] respondToSelector:@selector(currentIndex)];
        });
        
        it(@"should have a dataSource", ^{
            [[viewPager should] respondToSelector:@selector(dataSource)];
        });
        
        it(@"should have a delegate", ^{
            [[viewPager should] respondToSelector:@selector(delegate)];
        });
        
    });

SPEC_END