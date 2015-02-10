//
//  CellPair.h
//  jumpsum
//
//  Created by Tyler Cap on 2/10/15.
//  Copyright (c) 2015 Tyler Cap. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellPair : NSObject

@property (weak, nonatomic) UICollectionViewCell *landingCell;
@property (weak, nonatomic) UICollectionViewCell *jumpedCell;

-(id)initWithCell:(UICollectionViewCell *)landingCell
            cell2:(UICollectionViewCell *)jumpedCell;

@end
