//
//  MyCollectionViewCell.h
//  jumpsum
//
//  Created by Tyler Cap on 2/5/15.
//  Copyright (c) 2015 Tyler Cap. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCollectionViewController.h"

@interface MyCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) IBOutlet UILabel *title;
@property (nonatomic) NSInteger value;
@property (nonatomic, assign) CGPoint touchOffset;
@property (nonatomic, assign) CGPoint originalPosition;

@property (nonatomic, strong) UIColor *normalBack;
@property (nonatomic, strong) UIColor *highlightBack;

-(void)setLabel:(NSInteger)value;
-(void)highlight:(Boolean)highlight;

@end
