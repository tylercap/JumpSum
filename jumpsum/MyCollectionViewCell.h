//
//  MyCollectionViewCell.h
//  jumpsum
//
//  Created by Tyler Cap on 2/5/15.
//  Copyright (c) 2015 Tyler Cap. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCollectionViewCell : UICollectionViewCell
@property (nonatomic, weak) IBOutlet UILabel *title;

-(void)setLabel:(NSString *)value;

@end
