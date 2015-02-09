//
//  MyButtonCell.m
//  jumpsum
//
//  Created by Tyler Cap on 2/6/15.
//  Copyright (c) 2015 Tyler Cap. All rights reserved.
//

#import "MyButtonCell.h"

@implementation MyButtonCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //self.backgroundColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0];
    }
    return self;
}

- (void)setLabel:(NSString *)value
       backColor:(UIColor *) back
       textColor:(UIColor *) text
         rounded:(Boolean)round
{
    [self.button setTitle:value forState:UIControlStateNormal];
    
    [self.button setTitleColor:text forState:UIControlStateNormal];
    
    self.backgroundColor = back;
    self.button.titleLabel.textColor = text;
    self.layer.borderColor = text.CGColor;
    self.layer.borderWidth = 1.0;
    
    if( round )
        self.layer.cornerRadius = 6.0f;
    
    self.layer.masksToBounds = YES;
}

@end
