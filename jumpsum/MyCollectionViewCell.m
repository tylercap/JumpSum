//
//  MyCollectionViewCell.m
//  jumpsum
//
//  Created by Tyler Cap on 2/5/15.
//  Copyright (c) 2015 Tyler Cap. All rights reserved.
//

#import "MyCollectionViewCell.h"

@implementation MyCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //self.backgroundColor = [UIColor colorWithRed:1.0 green:0.6 blue:0.0 alpha:1.0];
    }
    return self;
}

- (void)setLabel:(NSString *)value
{
    self.title.text = value;
    
    self.layer.borderColor = [UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:1.0].CGColor;
    self.layer.borderWidth = 1.0;
    self.layer.cornerRadius = 6.0f;
    self.layer.masksToBounds = YES;
}

@end