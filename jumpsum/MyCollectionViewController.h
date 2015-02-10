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
<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak) IBOutlet MyCollectionViewLayout *layout;
@property(strong, nonatomic) Gameboard *gameboard;
@property(strong, nonatomic) NSMutableArray *tiles;

@property (nonatomic) NSInteger headerSections;
@property (nonatomic) NSInteger footerSections;

@property (weak, nonatomic) UIButton *restartGame;
@property (weak, nonatomic) UIButton *howTo;
@property (weak, nonatomic) UIButton *signInOut;
@property (weak, nonatomic) UIButton *leaderboard;
@property (weak, nonatomic) UILabel *currentScoreLabel;
@property (weak, nonatomic) UILabel *highScoreLabel;

-(void)highlightValidTargets:(NSIndexPath *)indexPath
                   highlight:(Boolean)highlight;
-(Boolean)jumpedTile:(NSIndexPath *)indexPath
             landing:(CGPoint)dropTarget;

@end

