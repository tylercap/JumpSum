//
//  MyCollectionViewController.h
//  jumpsum
//
//  Created by Tyler Cap on 2/5/15.
//  Copyright (c) 2015 Tyler Cap. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCollectionViewCell.h"
#import "Gameboard.h"
#import "MyCollectionViewLayout.h"
#import "MyButtonCell.h"

@interface MyCollectionViewController : UICollectionViewController
<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak) IBOutlet MyCollectionViewLayout *layout;
@property(strong, nonatomic) Gameboard *gameboard;

@end
