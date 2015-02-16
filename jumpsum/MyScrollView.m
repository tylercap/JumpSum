//
//  MyScrollView.m
//  jumpsum
//
//  Created by Tyler Cap on 2/16/15.
//  Copyright (c) 2015 Tyler Cap. All rights reserved.
//

#import "MyScrollView.h"

@implementation MyScrollView

- (void)setContentOffset:(CGPoint)contentOffset animated:(BOOL)animated {
    // restrict movement to vertical only
    CGPoint newOffset = CGPointMake(0, contentOffset.y);
    [super setContentOffset:newOffset animated:animated];
}

- (void)setContentOffset:(CGPoint)contentOffset {
    // restrict movement to vertical only
    CGPoint newOffset = CGPointMake(0, contentOffset.y);
    [super setContentOffset:newOffset];
}

@end
