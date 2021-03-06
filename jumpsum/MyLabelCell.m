//
//  MyLabelCell.m
//  jumpsum
//
//  Created by Tyler Cap on 2/6/15.
//  Copyright (c) 2015 Tyler Cap. All rights reserved.
//

#import "MyLabelCell.h"

@implementation MyLabelCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    return self;
}

- (void)setLabel:(NSString *) value
       textColor:(UIColor *) text
{
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        UIFont *font = [UIFont fontWithName:@"Helvetica-Bold" size:34];
        
        [self.label setFont:font];
    }
    
    self.label.text = value;
    self.label.textColor = text;
}

@end
