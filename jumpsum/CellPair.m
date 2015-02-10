//
//  CellPair.m
//  jumpsum
//
//  Created by Tyler Cap on 2/10/15.
//  Copyright (c) 2015 Tyler Cap. All rights reserved.
//

#import "CellPair.h"

@implementation CellPair

-(id)initWithCell:(UICollectionViewCell *)landingCell
            cell2:(UICollectionViewCell *)jumpedCell
{
    self = [super init];
    
    _landingCell = landingCell;
    _jumpedCell = jumpedCell;
    
    return self;
}

@end