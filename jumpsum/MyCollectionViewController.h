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
#import "MyLabelCell.h"
#import "CellPair.h"

@interface MyCollectionViewController : UICollectionViewController
<UICollectionViewDataSource>

@property (nonatomic, weak) IBOutlet MyCollectionViewLayout *layout;
@property(strong, nonatomic) Gameboard *gameboard;
@property(strong, nonatomic) NSMutableArray *tiles;

@property (nonatomic) NSInteger headerSections;
@property (nonatomic) NSInteger footerSections;

@property (weak, nonatomic) MyButtonCell *restartGame;
@property (weak, nonatomic) MyButtonCell *howTo;
@property (weak, nonatomic) MyButtonCell *signInOut;
@property (weak, nonatomic) MyButtonCell *leaderboard;
@property (weak, nonatomic) MyLabelCell *currentScoreLabel;
@property (weak, nonatomic) MyLabelCell *highScoreLabel;

-(void)highlightValidTargets:(NSIndexPath *)indexPath
                   highlight:(Boolean)highlight;
-(Boolean)jumpedTile:(NSIndexPath *)indexPath
             landing:(CGPoint)dropTarget;

@end

